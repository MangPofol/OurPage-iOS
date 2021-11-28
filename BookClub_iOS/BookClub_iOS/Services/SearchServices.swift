//
//  SearchServices.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/16.
//

import Foundation
import RxSwift
import Moya
import RxMoya

class SearchServices {
    static let provider = MoyaProvider<SearchAPI>()
    
    static func searchBookBy(isbn: String) -> Observable<[SearchedBook]> {
        var isbn = isbn
        if isbn.contains(" ") {
            isbn = isbn.components(separatedBy: " ").first!
        }
        
        return SearchServices.provider
            .rx.request(.searchBookByisbn(isbn))
            .asObservable()
            .map {
                if $0.statusCode == 200 {
//                    print(try $0.mapJSON())
                    let data = try JSONDecoder().decode(SearchedResult.self, from: $0.data)
                    return data.documents
                } else {
                    return []
                }
            }
            .catchAndReturn([])
    }
    
    static func getThumbnailBy(isbn: String) -> Observable<String?> {
        SearchServices.provider
            .rx.request(.searchBookByisbn(isbn))
            .asObservable()
            .map {
                if $0.statusCode == 200 {
                    let data = try JSONDecoder().decode(SearchedResult.self, from: $0.data)
                    return data.documents.first?.thumbnail
                } else {
                    print($0.description)
                    return nil
                }
            }
            .catchAndReturn(nil)
    }
    
    static func searchBookBy(title: String) -> Observable<[Book]> {
        return SearchServices.provider
            .rx.request(.searchBookByTitle(title))
            .asObservable()
            .map {
                if $0.statusCode == 200 {
                    let data = try JSONDecoder().decode(SearchedResult.self, from: $0.data)
                    
                    var books = [Book]()
                    for (index, value) in data.documents.enumerated() {
                        let book = Book(bookModel: BookModel(category: "NOW", createdDate: "", id: index, isbn: value.isbn, modifiedDate: "", name: value.title), searchedInfo: value)
                        
                        books.append(book)
                    }
                    return books
                } else {
                    print($0.description)
                    return []
                }
            }
            .catchAndReturn([])
    }
}
