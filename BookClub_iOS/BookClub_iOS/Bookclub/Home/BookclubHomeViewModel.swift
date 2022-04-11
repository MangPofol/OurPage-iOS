//
//  BookclubHomeViewModel.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/30.
//

import Foundation
import RxSwift
import RxCocoa

class BookclubHomeViewModel: ViewModelType {
    struct Input {
        var createBookclubTapped: Observable<UITapGestureRecognizer>
        var bookclubSettingTapped: Observable<UITapGestureRecognizer>
    }
    
    struct Output {
        var openBookclubSetting: Driver<Bool>!
        var openAddBookclub: Driver<Bool>!
        var bookclub: Driver<[Club?]>!
    }
    
    var input: Input?
    var output: Output = Output()
    
    init(input: Input?) {
        self.input = input
        
        guard let input = self.input else {
            return
        }
        
        self.output.openBookclubSetting = input.bookclubSettingTapped
            .map { _ in true }.asDriver(onErrorJustReturn: false)
        
        self.output.openAddBookclub = input.createBookclubTapped
            .map { _ in true }.asDriver(onErrorJustReturn: false)
        
        self.output.bookclub = Constants.CurrentUser
            .compactMap { $0 }
            .flatMap {
                BookclubServices.getClubsByUser(id: $0.userId)
            }
            .map {
                if 3 - $0.count > 0 {
                    return $0 + Array(repeating: nil, count: 3 - $0.count)
                } else {
                    return $0
                }
            }
            .asDriver(onErrorJustReturn: [])
    }
}
