//
//  BookCollectionViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/26.
//

import Foundation
import RxSwift

class BookCollectionViewModel {
    var data = Observable<[BookModel]>.just([])
    
    init(bookTapped: Observable<BookModel>) {
        data = Observable<[BookModel]>.just([])
    }
}
