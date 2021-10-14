//
//  BookCollectionViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/26.
//

import Foundation
import RxSwift
import RxRelay

class BookCollectionViewModel {
    var books = BehaviorRelay<[Book]>(value: [])
    var fetchedBooks = BehaviorRelay<[Book]>(value: [])
    var bookInformation = Observable<[SearchedBook]>.just([])
    var category = BehaviorSubject<BookListType>(value: BookListType.NOW)
    var tappedBook: Observable<Book>
    
    let disposeBag = DisposeBag()
    
    init(bookTapped: Observable<Book>) {
        tappedBook = bookTapped
        
        category.bind {
            self.getBooksBy(email: "testerlnj@naver.com", category: $0.rawValue)
        }.disposed(by: disposeBag)
    }
    
    func getBooksBy(email: String, category: String){
        BookServices.getBooksBy(email: email, category: category).map { values -> [Book] in
            var books = [Book]()
            
            values.forEach {
                let book = Book(bookModel: $0, searchedInfo: nil)
                books.append(book)
            }
            
            return books
        }.bind {
            self.fetchedBooks.accept($0)
            self.books.accept($0)
        }.disposed(by: disposeBag)
    }
    
    func searchBook(by title: String) {
        if title == "" {
            self.getBooksBy(email: "testerlnj@naver.com", category: BookListType.NOW.rawValue)
            
        } else {
            print(#fileID, #function, #line, "")
            SearchServices.searchBookBy(title: title)
                .bind {
                    self.books.accept($0)
                }
                .disposed(by: disposeBag)
        }
    }
    
    func filterBySearching(with text: String) {
        var books = self.fetchedBooks.value
        books = books.filter {
            print($0.bookModel.name)
            return $0.bookModel.name.hasPrefix(text)
        }
        self.books.accept(books)
    }
    
}
