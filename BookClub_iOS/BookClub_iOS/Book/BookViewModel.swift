//
//  BookViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/27.
//

import Foundation

import UIKit.UITapGestureRecognizer

import RxSwift
import RxRelay
import RxCocoa

class BookViewModel {
    var book = BehaviorRelay<BookModel?>(value: nil)
    var searchedInfo = BehaviorSubject<SearchedBook?>(value: nil)
    var posts = BehaviorRelay<[PostModel]>(value: [])
    
    var deleteButtonTapped = PublishRelay<Bool>()
    var bookDeleted = PublishRelay<Bool>()

    var disposeBag = DisposeBag()
    
    init(
        book_: BookModel?,
        input: (
            readingButtonTapped: Observable<Bool>,
            finishButtonTapped: Observable<Bool>,
            writeButtonTapped: Observable<UITapGestureRecognizer>
        )
    ) {
        guard let book = book_ else { return }
        
        self.book.accept(book)
        
        SearchServices.searchBookBy(isbn: book.isbn)
            .map { $0.first }
            .bind(to: searchedInfo)
            .disposed(by: disposeBag)
        
        input.readingButtonTapped
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .flatMap { isOn -> Observable<String> in
                if isOn {
                    return BookServices.updateBook(id: book.id, category: "BEFORE")
                        .map { _ in "BEFORE" }
                } else {
                    return BookServices.updateBook(id: book.id, category: "NOW")
                        .map { _ in "NOW" }
                }
            }
            .bind { [weak self] in
                guard let self = self else { return }
                
                let newBook = BookModel(category: $0, createdDate: book.createdDate, id: book.id, isbn: book.isbn, modifiedDate: book.modifiedDate, name: book.name)
                
                self.book.accept(newBook)
            }
            .disposed(by: disposeBag)
        
        input.finishButtonTapped
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .flatMap { isOn -> Observable<String> in
                if isOn {
                    return BookServices.updateBook(id: book.id, category: "BEFORE")
                        .map { _ in "BEFORE" }
                } else {
                    return BookServices.updateBook(id: book.id, category: "AFTER")
                        .map { _ in "AFTER" }
                }
            }
            .bind { [weak self] in
                guard let self = self else { return }
                
                let newBook = BookModel(category: $0, createdDate: book.createdDate, id: book.id, isbn: book.isbn, modifiedDate: book.modifiedDate, name: book.name)
                
                self.book.accept(newBook)
            }
            .disposed(by: disposeBag)
        
        deleteButtonTapped
            .asObservable()
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .flatMap { _ in
                return BookServices.deleteBook(id: book.id)
            }
            .bind(to: self.bookDeleted)
            .disposed(by: disposeBag)
    }
    
    func refreshPosts() {
        guard let book = self.book.value else { return }
        PostServices.getPostsByBookId(bookId: book.id)
            .bind(to: posts)
            .disposed(by: disposeBag)
    }
}
