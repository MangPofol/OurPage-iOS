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
}
