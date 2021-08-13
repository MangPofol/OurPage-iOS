//
//  BookListViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/13.
//

import Foundation
import RxSwift
import RxCocoa

class BookListViewModel {
    var data = Observable<[BookModel]>.just([])
    
    init() {
        // TODO: Book List fetching
        data = Observable<[BookModel]>.just([
                                                BookModel(image: "SampleBook", title: "Book1"),
                                                BookModel(image: "SampleBook", title: "Book2"),
                                                BookModel(image: "SampleBook", title: "Book3"),
                                                BookModel(image: "SampleBook", title: "Book4"),
                                                BookModel(image: "SampleBook", title: "Book5"),
                                                BookModel(image: "SampleBook", title: "Book6"),
                                                BookModel(image: "SampleBook", title: "Book7"),
                                                BookModel(image: "SampleBook", title: "Book8"),
                                                BookModel(image: "SampleBook", title: "Book9"),
                                                BookModel(image: "SampleBook", title: "Book10"),
                                                BookModel(image: "SampleBook", title: "Book11")])
    }
}

enum BookListType {
    case reading
    case finished
    case wantToRead
}
