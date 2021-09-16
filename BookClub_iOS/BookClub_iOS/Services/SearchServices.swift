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
        SearchServices.provider
            .rx.request(.searchBookByisbn(isbn))
            .asObservable()
            .map {
                if $0.statusCode == 200 {
//                    print(try $0.mapJSON())
                    let data = try JSONDecoder().decode(SearchedResult.self, from: $0.data)
                    return data.documents
                } else {
                    print($0.description)
                    return []
                }
            }
            .catchErrorJustReturn([])
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
            .catchErrorJustReturn(nil)
    }
    
    static func searchBookBy(title: String) {
        
    }
}
