//
//  BookclubSettingViewModel.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/04/24.
//

import Foundation

import RxSwift
import RxCocoa

class BookclubSettingViewModel: ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        var ownBookclub: Driver<[Bookclub]>!
        var joinedBookclub: Driver<[Bookclub]>!
    }
    
    var input: Input?
    var output: Output = Output()
    
    init() {
        let bookclubs = Constants.CurrentUser
            .compactMap { $0 }
            .flatMap {
                BookclubServices.getClubsByUser(id: $0.userId)
            }
            .asDriver(onErrorJustReturn: [])
        
        let bookclubsAnduser = bookclubs.withLatestFrom(Constants.CurrentUser.asDriver(onErrorJustReturn: nil)) { ($0, $1) }
        
        
        self.output.ownBookclub = bookclubsAnduser.map { bookclubsAnduser in
            bookclubsAnduser.0.filter { bookclub in
                bookclub.presidentId == bookclubsAnduser.1?.userId
            }
        }
        
        self.output.joinedBookclub = bookclubsAnduser.map { bookclubsAnduser in
            bookclubsAnduser.0.filter { bookclub in
                bookclub.presidentId != bookclubsAnduser.1?.userId
            }
        }
    }
}
