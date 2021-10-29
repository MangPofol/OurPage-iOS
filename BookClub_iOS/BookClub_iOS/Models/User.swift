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
//
//}

struct CreatingUser: Codable {
    var email: String = ""
    var nickname: String = ""
    var password: String = ""
    var sex: String = ""
    var birthdate: String = ""
    var introduce: String = ""
    var style: String = ""
    var goal: String = ""
    var profileImgLocation: String = ""
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
