//
//  BookclubInfoViewModel.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/05/15.
//

import Foundation

import RxSwift
import RxCocoa

class BookclubInfoViewModel: ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        var bookclubInfo: Driver<BookclubInfo?>!
    }
    
    var input: Input?
    var output: Output = Output()
    
    var bookclubId: Int? {
        didSet {
            guard let bookclubId = bookclubId else {
                return
            }
            
            self.output.bookclubInfo = BookclubServices.getClubInfoByClub(id: bookclubId).asDriver(onErrorJustReturn: nil)
        }
        
    }
    
    init(input: Input?) {
        self.input = input
        
        guard let input = self.input else {
            return
        }

        
    }
}
