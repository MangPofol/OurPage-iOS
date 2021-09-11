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
    
    init(bookTapped: Observable<BookModel>) {
        data = BookServices.getBooksBy(email: "2@naver.com", category: "NOW")
    }
}
