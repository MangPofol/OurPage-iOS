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

class AuthServices {
    static let provider = MoyaProvider<AuthAPI>()
    
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
