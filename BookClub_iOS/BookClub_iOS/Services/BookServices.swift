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

class BookServices {
    static let provider = MoyaProvider<BookAPI>()
    
    struct BooksResponse: Codable {
        var data: [BookModel]
    }
    
    // email, category로 책 목록 받아오기
    static func getBooksBy(email: String, category: String) -> Observable<[BookModel]> {
        BookServices.provider
            .rx.request(.getBooksByEmailAndCategory(email, category))
            .asObservable()
            .map {
                if $0.statusCode == 200 {
                    do {
                        let data = try JSONDecoder().decode(BooksResponse.self, from: $0.data)
                        return data.data
                    } catch {
                        print(error.localizedDescription)
                        return []
                    }
                } else {
                    print("Failed with Status Code: \($0.statusCode)")
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
                    print("Failed with Status Code: \($0.statusCode)")
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
