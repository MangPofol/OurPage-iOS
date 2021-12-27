//
//  BookViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/27.
//

import Foundation

import RxSwift

class BookViewModel {
    var book = BehaviorSubject<BookModel?>(value: nil)
    var searchedInfo = BehaviorSubject<SearchedBook?>(value: nil)
    var posts = BehaviorSubject<[PostModel]>(value: [])
    
    var disposeBag = DisposeBag()
    
    init(book_: BookModel?) {
        guard let book = book_ else { return }
        
        self.book.onNext(book)
        
        SearchServices.searchBookBy(isbn: book.isbn)
            .map { $0.first }
            .bind(to: searchedInfo)
            .disposed(by: disposeBag)
        
        PostServices.getPostsByBookId(bookId: book.id)
            .bind(to: posts)
            .disposed(by: disposeBag)
    }
}
