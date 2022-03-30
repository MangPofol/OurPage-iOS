//
//  BookclubServices.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/31.
//

import Foundation

import Moya
import RxSwift

final class BookclubServices: Networkable {
    typealias Target = BookclubAPI
    
    static let provider = makeProvider()
    
    static func createBookclub(creatingBookclub: CreatingBookclub) -> Observable<BookclubCreatResultType> {
        BookclubServices.provider
            .rx.request(.createBookclub(creatingBookclub: creatingBookclub))
            .asObservable()
            .map {
                switch $0.statusCode {
                case 201:
                    do {
                        let response = try Constants.defaultDecoder.decode(Bookclub.self, from: $0.data)
                        return .success(bookclub: response)
                    } catch {
                        print(error)
                        return .failure
                    }
                    
                case 400:
                    return .nameDuplicated
                default:
                    return .failure
                }
                
            }
    }
}
