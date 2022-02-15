//
//  MyProfileViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/13.
//

import Foundation

import RxSwift
import RxCocoa

class MyProfileViewModel {
    var myGenre: Driver<[String]>
    var recordCount: Driver<Int>
    var bookCount: Driver<Int>
    
    init() {
        self.myGenre = Constants.CurrentUser
            .compactMap { $0?.genres }
            .asDriver(onErrorJustReturn: [])
        
        self.recordCount = PostServices.getTotalCount()
            .compactMap{ $0 }
            .asDriver(onErrorJustReturn: 0)
        
        self.bookCount = BookServices.getBooksBy(category: "AFTER")
            .compactMap { $0.count }
            .asDriver(onErrorJustReturn: 0)
    }
}
