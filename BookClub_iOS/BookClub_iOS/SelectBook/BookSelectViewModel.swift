//
//  BookSelectViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/20.
//

import Foundation
import RxSwift
import RxCocoa

class BookSelectionViewModel {
    
    // outputs
    var bookTypeFilter: Observable<BookListType>
    var searchTextChanged: Observable<String?>
    var isSearching: Observable<Bool>
    var newBooks = Observable<[BookModel]>.just([])
    
    init(
        input: (
            searchBarText: Observable<String?>,
            readingButtonTapped: Observable<BookListType>,
            finishedButtonTapped: Observable<BookListType>,
            wantToButtonTapped: Observable<BookListType>
        )
    ) {
        bookTypeFilter = Observable.merge(input.readingButtonTapped, input.finishedButtonTapped, input.wantToButtonTapped).map {$0}
        
        searchTextChanged = input.searchBarText
        
        isSearching = input.searchBarText.map { $0 != "" }
    }
}
