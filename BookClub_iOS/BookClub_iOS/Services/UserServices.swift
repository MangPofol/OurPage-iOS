//
//  UserServices.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/29.
//

import Foundation

import RxSwift
import RxMoya
import Moya

class UserServices {
    static let provider = MoyaProvider<UserAPI>()
    
    static func validateDuplicate(email: String) -> Observable<Bool> {
        UserServices.provider
            .rx.request(.validateDuplicate(email: EmailStruct(email: email)))
            .asObservable()
            .map {
                print($0)
                if $0.statusCode == 204 {
                    return true
                } else {
                    return false
                }
            }
    }
    
    static func createUser(user: CreatingUser) -> Observable<CreatedUser?> {
        UserServices.provider
            .rx.request(.createUser(user: user))
            .asObservable()
            .map {
                print($0)
                print(try $0.mapJSON())
                if $0.statusCode == 201 {
                    let result = try JSONDecoder().decode(CreatedResult.self, from: $0.data)
                    print(result)
                    return result.data
                }
                return nil
            }
    }
    
    static func login(email: String, password: String) -> Observable<Bool> {
        UserServices.provider
            .rx.request(.login(email: email, password: password))
            .asObservable()
            .map {
                if $0.statusCode == 200 {
                    if let headerFields = $0.response!.allHeaderFields as? [String: String], let URL = $0.request?.url {
                        let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: URL)
                        HTTPCookieStorage.shared.setCookie(cookies.first!)
                    }
                    return true
                }
                
                return false
            }
    }
    
    static func getUserInfo(userID: String) {
        UserServices.provider
            .rx.request(.getUserInfor(userID: userID))
            .asObservable()
            .map {
                if $0.statusCode == 200 {
                    
                }
            }
    }
}

struct CreatedResult: Codable {
    var data: CreatedUser
}
