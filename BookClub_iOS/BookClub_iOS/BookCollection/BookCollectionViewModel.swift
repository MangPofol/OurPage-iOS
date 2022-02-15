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
        
        category.bind { [weak self] in
            self?.getBooksBy(category: $0.rawValue)
        }.disposed(by: disposeBag)
    }
    
    func getBooksBy(category: String) {
        
        BookServices.getBooksBy(category: category).map { values -> [Book] in
            var books = [Book]()
            
            values.forEach {
                let book = Book(bookModel: $0, searchedInfo: nil)
                books.append(book)
            }
            
            return books
        }.bind { [weak self] in
            print(#fileID, #function, #line, $0)
            self?.fetchedBooks.accept($0)
            self?.books.accept($0)
        }.disposed(by: disposeBag)
    }
    
    func searchBook(by title: String) {
        if title == "" {
            self.getBooksBy(category: BookListType.NOW.rawValue)
            
        } else {
            SearchServices.searchBookBy(title: title)
                .bind { [weak self] in
                    self?.books.accept($0)
                }
                .disposed(by: disposeBag)
        }
    }
    
    func allFilterDisable() {
        self.books.accept(fetchedBooks.value)
    }
    
    func filterBySearching(with text: String) {
        var books = fetchedBooks.value
        books = books.filter {
            return $0.bookModel.name.hasPrefix(text)
        }
        self.books.accept(books)
    }
    
    func filterBySorting(with sortType: SortBy) {
        var books = self.fetchedBooks.value
        switch sortType {
        case .byNew:
            books.sort {
                $0.bookModel.modifiedDate < $1.bookModel.modifiedDate
            }
        case .byOld:
            books.sort {
                $0.bookModel.modifiedDate > $1.bookModel.modifiedDate
            }
        case .byName:
            books.sort {
                $0.bookModel.name < $1.bookModel.name
            }
        case .none:
            self.books.accept(fetchedBooks.value)
            return
        }
        self.books.accept(books)
    }
}
