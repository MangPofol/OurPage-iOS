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
            self.getBooksBy(email: "k@naver.com", category: $0.rawValue)
        }.disposed(by: disposeBag)
    }
    
    func getBooksBy(email: String, category: String){
//        let bookModel = BookModel(category: BookListType.NOW.rawValue, createdDate: "2021.11.28", id: 1, isbn: "8959895598", likedList: [], modifiedDate: "2021.11.28", name: "트렌드 인사이트 2030")
//        let searchedInfo = SearchedBook(authors: ["로렌스 새뮤얼"], contents: "미래의 지형은 끊임없이 변주되고 있다. 빠르게 변화하는 미래의 예측 불가능성을 뛰어넘어 지금 당장 비즈니스에 적용할 수 있는 미래 트렌드는 무엇인가. 문화 비즈니스 컨설턴트이자 문화 역사학자인 저자는 문화인류학적 분석을 바탕으로 20년 후를 내다보고, 이를 60개의 트렌드 키워드에 압축적으로 담아낸다. 또한 지금 바로 적용 가능한 미래 활용법을 과감하고 명확하게 제시한다. 당장 눈에 보이는 유행에만 치우친 트렌드를 말하는 것이 아니다. 저자의 컨설팅", datetime: "2018-12-05T00:00:00.000+09:00", isbn: "8959895598 9788959895595", price: 17000, publisher: "미래의창", sale_price: 15300, status: "정상판매", thumbnail: "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F4812234%3Ftimestamp%3D20211104154117", title: "트렌드 인사이트 2030", translators: ["서유라"], url: "https://search.daum.net/search?w=bookpage&bookId=4812234&q=%ED%8A%B8%EB%A0%8C%EB%93%9C+%EC%9D%B8%EC%82%AC%EC%9D%B4%ED%8A%B8+2030")
//
//        let book = Book(bookModel: bookModel, searchedInfo: searchedInfo)
//        self.fetchedBooks.accept([book, book, book, book, book, book, book, book, book, book, book, book, book, book, book])
//        self.books.accept([book, book, book, book, book, book, book, book, book, book, book, book, book, book, book])
        
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
            self.getBooksBy(email: "k@naver.com", category: BookListType.NOW.rawValue)
            
        } else {
            print(#fileID, #function, #line, "")
            SearchServices.searchBookBy(title: title)
                .bind {
                    self.books.accept($0)
                }
                .disposed(by: disposeBag)
        }
    }
    
    func allFilterDisable() {
        self.books.accept(self.fetchedBooks.value)
    }
    
    func filterBySearching(with text: String) {
        var books = self.fetchedBooks.value
        books = books.filter {
            return $0.bookModel.name.hasPrefix(text)
        }
        self.books.accept(books)
    }
    
    func filterBySorting(with sortType: SortBy) {
        var books = self.fetchedBooks.value
        print(sortType)
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
            self.books.accept(self.fetchedBooks.value)
            return
        }
        self.books.accept(books)
    }
}
