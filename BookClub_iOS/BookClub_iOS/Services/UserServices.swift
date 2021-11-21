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
}

struct CreatedResult: Codable {
    var data: CreatedUser
}

struct CreatedUser: Codable {
    var userId: Int = -1
    var email: String = ""
    var nickname: String = ""
    var sex: String = ""
    var birthdate: String = ""
    var introduce: String = ""
    var style: String = ""
    var goal: String = ""
    var profileImgLocation: String = ""
    var genres: [String] = []
    var isDormant: Bool = false
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userId, forKey: .userId)
        try container.encode(email, forKey: .email)
        try container.encode(nickname, forKey: .nickname)
        try container.encode(sex, forKey: .sex)
        try container.encode(birthdate, forKey: .birthdate)
        try container.encode(introduce, forKey: .introduce)
        try container.encode(style, forKey: .style)
        try container.encode(goal, forKey: .goal)
        try container.encode(profileImgLocation, forKey: .profileImgLocation)
        try container.encode(genres, forKey: .genres)
        try container.encode(isDormant, forKey: .isDormant)
    }
}
