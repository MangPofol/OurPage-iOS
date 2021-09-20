//
//  BookCollectionViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/26.
//

import Foundation
import RxSwift

class BookCollectionViewModel {
    var bookModel = BehaviorSubject<[Book]>(value: [])
    var bookInformation = Observable<[SearchedBook]>.just([])
    var category = BehaviorSubject<BookListType>(value: BookListType.NOW)
    var tappedBook: Observable<Book>
    
    let disposeBag = DisposeBag()
    
    init(bookTapped: Observable<Book>) {
        tappedBook = bookTapped
        
        // TODO:
        category.bind {
            _ = self.getBooksBy(email: "testerlnj@naver.com", category: $0.rawValue).map {
                self.bookModel.onNext($0)
            }
        }.disposed(by: disposeBag)
    }
    
    func getBooksBy(email: String, category: String) -> Observable<[Book]> {
        return BookServices.getBooksBy(email: email, category: category).map { values -> [Book] in
            var books = [Book]()
            
            values.forEach {
                let book = Book(bookModel: $0, searchedInfo: nil)
                books.append(book)
            }
            
            return books
        }
    }
    
    func searchBook(by title: String) {
        if title == "" {
            self.getBooksBy(email: "testerlnj@naver.com", category: BookListType.NOW.rawValue).bind {
                self.bookModel.onNext($0)
            }
            .disposed(by: disposeBag)
            
        } else {
            print(#fileID, #function, #line, "")
            SearchServices.searchBookBy(title: title)
                .bind {
                    self.bookModel.onNext($0)
                }
                .disposed(by: disposeBag)
        }
    }
    
}
