//
//  User.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/29.
//

import Foundation

//{
//    "email": "8@naver.com",
//    "nickname": "rabbit",
//    "password": "1234",
//    "sex": "MALE",
//    "birthdate": "2021-08-22T11:47:31",
//    "introduce": "introduce yourself",
//    "style": "once in a week",
//    "goal": "goal",
//    "profileImgLocation": "123somewhere123",
//    "genres": [
//        "Romance",
//        "IT"
//    ]
//th
//}

struct CreatingUser: Codable {
    var email: String = ""
    var nickname: String? = nil
    var password: String = ""
    var sex: String? = "MALE"
    var birthdate: String? = "1996-07-01T11:11:11"
    var introduce: String? = nil
    var style: String? = nil
    var goal: String? = nil
    var profileImgLocation: String? = nil
    var genres: [String] = []
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(email, forKey: .email)
        try container.encode(nickname, forKey: .nickname)
        try container.encode(password, forKey: .password)
        try container.encode(sex, forKey: .sex)
        try container.encode(birthdate, forKey: .birthdate)
        try container.encode(introduce, forKey: .introduce)
        try container.encode(style, forKey: .style)
        try container.encode(goal, forKey: .goal)
        try container.encode(profileImgLocation, forKey: .profileImgLocation)
        try container.encode(genres, forKey: .genres)
    }
}

struct UpdatingUser: Codable {
    var email: String = ""
    var nickname: String = ""
    var sex: String = ""
    var birthdate: String = ""
    var introduce: String = ""
    var style: String? = nil
    var goal: String? = nil
    var profileImgLocation: String? = nil
    var genres: [String] = []
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(email, forKey: .email)
        try container.encode(nickname, forKey: .nickname)
        try container.encode(sex, forKey: .sex)
        try container.encode(birthdate, forKey: .birthdate)
        try container.encode(introduce, forKey: .introduce)
        try container.encode(style, forKey: .style)
        try container.encode(goal, forKey: .goal)
        try container.encode(profileImgLocation, forKey: .profileImgLocation)
        try container.encode(genres, forKey: .genres)
    }
}

struct LoginUser: Codable {
    var email: String
    var password: String
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
    }
}

struct CreatedUser: Codable {
    var userId: Int = -1
    var email: String = ""
    var nickname: String?
    var sex: String?
    var birthdate: String?
    var introduce: String?
    var style: String?
    var goal: String?
    var profileImgLocation: String?
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
