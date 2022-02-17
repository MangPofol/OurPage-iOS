//
//  BookViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/27.
//

import Foundation

import RxSwift
import RxRelay

class BookViewModel {
    var book = BehaviorRelay<BookModel?>(value: nil)
    var searchedInfo = BehaviorSubject<SearchedBook?>(value: nil)
    var posts = BehaviorRelay<[PostModel]>(value: [])
    
    var disposeBag = DisposeBag()
    
    init(book_: BookModel?) {
        guard let book = book_ else { return }
        
        self.book.accept(book)
        
        SearchServices.searchBookBy(isbn: book.isbn)
            .map { $0.first }
            .bind(to: searchedInfo)
            .disposed(by: disposeBag)
    }
    
    func refreshPosts() {
        guard let book = self.book.value else { return }
        PostServices.getPostsByBookId(bookId: book.id)
            .bind(to: posts)
            .disposed(by: disposeBag)
    }
}
