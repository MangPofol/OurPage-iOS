//
//  AuthServices.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/29.
//

import Foundation
import Moya
import RxMoya
import RxSwift

class AuthServices: Networkable {
    typealias Target = AuthAPI
    static let provider = makeProvider()
    
    static func createUser(user: CreatingUser) -> Observable<Bool> {
        AuthServices.provider
            .rx.request(.createUser(user))
            .asObservable()
            .map {
                return $0.statusCode == 201
            }
    }
    
    static func login(id: String, password: String) -> Observable<Bool> {
        AuthServices.provider.rx.request(.login(id, password))
            .asObservable()
            .map {
                if let headerFields = $0.response!.allHeaderFields as? [String: String], let URL = $0.request?.url {
                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: URL)
                    print(cookies)
                    let cookieStorage = HTTPCookieStorage.shared
                    cookieStorage.setCookie(cookies.first!)
                }
                if $0.statusCode == 200 {
                    return true
                } else {
                    return false
                }
                
            }
    }
}
