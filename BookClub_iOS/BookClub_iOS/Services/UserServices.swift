//
//  UserServices.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/29.
//

import Foundation

import RxSwift
import Moya

class UserServices: Networkable {
    typealias Target = UserAPI
    
    static let provider = makeProvider()
    
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
    
    static func getCurrentUserInfo() -> Observable<CreatedUser?> {
        UserServices.provider
            .rx.request(.getCurrentUserInfo)
            .asObservable()
            .map {
                if $0.statusCode == 200 {
                    let response = try? Constants.defaultDecoder.decode(CreatedResult.self, from: $0.data)
                    return response?.data
                } else {
                    return nil
                }
            }
    }
    
    static func updateUser(user: UpdatingUser, id: Int) -> Observable<Bool> {
        UserServices.provider
            .rx.request(.updateUser(user: user, id: id))
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .asObservable()
            .map {
                return $0.statusCode == 204
            }
    }
    
    static func validateEmail() -> Observable<Bool> {
        UserServices.provider
            .rx.request(.validateEmail)
            .asObservable()
            .filterSuccessfulStatusCodes()
            .map {
                return $0.statusCode == 204
            }
            .catchAndReturn(false)
    }
    
    static func validateEmailSendCode(emailCode: String) -> Observable<Bool> {
        UserServices.provider
            .rx.request(.validateEmailSendCode(emailCode: emailCode))
            .asObservable()
            .map {
                if $0.statusCode == 204 {
                    return true
                }
                return false
            }
    }
    
    static func changePassword(newPassword: String) -> Observable<Bool> {
        UserServices.provider
            .rx.request(.changePassword(newPassword: newPassword))
            .asObservable()
            .map {
                if $0.statusCode == 204 {
                    return true
                }
                return false
            }
    }
    
    static func changeUserDormant(id: Int) -> Observable<Bool> {
        UserServices.provider
            .rx.request(.changeUserDormant(id: id))
            .asObservable()
            .map {
                if $0.statusCode == 204 {
                    return true
                }
                return false
            }
    }
}

struct CreatedResult: Codable {
    var data: CreatedUser
}
