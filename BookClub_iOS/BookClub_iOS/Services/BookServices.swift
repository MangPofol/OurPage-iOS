//
//  BookServices.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/10.
//

import Foundation
import RxMoya
import Moya
import RxSwift

class BookServices: Networkable {
    typealias Target = BookAPI
    
    static let provider = makeProvider()
    
    struct BooksResponse: Codable {
        var data: [BookModel]
    }
    
    // email, category로 책 목록 받아오기
    static func getBooksBy(category: String) -> Observable<[BookModel]> {
        BookServices.provider
            .rx.request(.getBooksByCurrentUserAndCategory(category))
            .asObservable()
            .map {
                if $0.statusCode == 200 {
                    do {
                        let data = try JSONDecoder().decode(BooksResponse.self, from: $0.data)
                        return data.data
                    } catch {
                        return []
                    }
                } else {
                    return []
                }
            }
    }
    
    // 새 책 생성
    static func createBook(bookToCreate: BookToCreate) -> Observable<BookToCreate?> {
        BookServices.provider
            .rx.request(.createBook(bookToCreate))
            .asObservable()
            .map {
                if $0.statusCode == 201 {
                    let data = try JSONDecoder().decode(BookToCreate.self, from: $0.data)
                    return data
                } else {
                    return nil
                }
            }
            .catchAndReturn(nil)
    }
    
    // 책 업데이트
    static func updateBook(id: String, bookToCreate: BookToCreate) {
        
    }
    
    // 책 삭제
    static func deleteBook(id: String) {
        
    }
    
    // 책 좋아요
    static func doLikeBook(id: String) {
        
    }
    
    // 책 좋아요 취소
    static func undoLikeBook(id: String) {
        
    }
}
