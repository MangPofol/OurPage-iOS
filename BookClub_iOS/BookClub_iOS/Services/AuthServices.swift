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
                if $0.statusCode == 200 {
                    let token = try? JSONDecoder().decode(LoginResult.self, from: $0.data)
                    if let token = token {
                        KeyChainController.shared.create(Constants.ServiceString, account: "Token", value: token.token)
                    }
                    return true
                } else {
                    return false
                }
                
            }
    }
}

struct LoginResult: Codable {
    var token: String
}
