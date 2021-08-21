//
//  MyLibraryViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/13.
//

import Foundation
import RxSwift
import RxCocoa

class MyLibraryViewModel {
    
    // outputs
    var data = Observable<[BookModel]>.just([])
    var bookListType = Observable.just(BookListType.reading)
    var filterType: Observable<FilterType>
    var bookclubs = Observable<[String]>.just([])
    
    init(
        input: (
            typeTapped: Observable<BookListType>,
            filterTapped: Observable<FilterType>
        )
    ) {
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
        
        bookclubs = Observable<[String]>.just(["북클럽 1", "북클럽 2", "북클럽 3"])
        
        bookListType = input.typeTapped
            .map {
                return $0
            }
        
        filterType = input.filterTapped
            .map {
                return $0
            }
    }
}

enum BookListType: Int {
    case reading = 0
    case finished = 1
    case wantToRead = 2
}

enum FilterType: String {
    case none = ""
    case search = "검색"
    case bookclub = "북클럽"
    case sorting = "정렬"
}
