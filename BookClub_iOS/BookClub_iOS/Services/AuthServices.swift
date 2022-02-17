//
//  AuthServices.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/29.
//

import Foundation
import Moya
import RxSwift

class AuthServices: Networkable {
    typealias Target = AuthAPI
    static let provider = makeProvider()
    
    static func createUser(user: CreatingUser) -> Observable<Bool> {
        AuthServices.provider
            .rx.request(.createUser(user))
            .asObservable()
            .map {
                guard let result = try? JSONDecoder().decode(CreatingResult.self, from: $0.data) else {
                    return false
                }
                SignUpViewModel.createdUserId = String(result.data.userId)
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

struct CreatingResult: Codable {
    var data: CreatedUser
}
