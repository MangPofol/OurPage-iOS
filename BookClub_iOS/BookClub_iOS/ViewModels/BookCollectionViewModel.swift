//
//  BookCollectionViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/26.
//

import Foundation
import RxSwift

class BookCollectionViewModel {
    var data: Observable<[BookModel]>
    var category = BehaviorSubject<BookListType>(value: BookListType.NOW)
    
    init(bookTapped: Observable<BookModel>) {
        data = category.flatMap { value -> Observable<[BookModel]> in
            switch value {
            case .NOW:
                return BookServices.getBooksBy(email: "2@naver.com", category: "NOW")
            case .BEFORE:
                return BookServices.getBooksBy(email: "2@naver.com", category: "BEFORE")
            case .AFTER:
                return BookServices.getBooksBy(email: "2@naver.com", category: "AFTER")
            }
            
        }
    }
}
