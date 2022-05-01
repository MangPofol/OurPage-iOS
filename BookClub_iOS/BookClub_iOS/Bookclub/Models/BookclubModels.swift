//
//  BookclubModels.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/30.
//

import Foundation

struct Bookclub: Codable {
    var id: Int
    var name: String
    var level: Int
    var presidentId: Int
    var description: String
    var createdDate: Date
    var modifiedDate: Date
}

struct CreatingBookclub: Codable {
    var name: String
    var colorSet: String = "A"
    var description: String
}

//"userResponseDto": {
//            "userId": 586,
//            "email": "10@gmail.com",
//            "sex": "MALE",
//            "birthdate": "1997-01-01T11:11:11",
//            "nickname": "rabbit",
//            "introduce": "introduce yourself",
//            "style": "once in a week",
//            "goal": "goal",
//            "profileImgLocation": "123somewhere123",
//            "genres": [
//                "Romance",
//                "IT"
//            ],
//            "isDormant": false
//        },
//        "totalPosts": 0,
//        "totalBooks": 1,
//        "totalComments": 0,
//        "invitedDate": "2022-04-07T12:49:09.821278"

struct BookclubUserResponse: Codable {
    var data: [BookclubUser]
}

struct BookclubUser: Codable {
    var userResponseDto: CreatedUser
    var totalPosts: Int
    var totalBooks: Int
    var totalComments: Int
    var invitedDate: Date
}

struct BookclubInfoResponse: Codable {
    var data: BookclubInfo
}

struct BookclubInfo: Codable {
    var id: Int
    var name: String
    var level: Int
    var presidentId: Int
    var description: String
    var createdDate: Date
    var modifiedDate: Date
    var totalUser: Int
    var totalPosts: Int
    var totalBooks: Int
    var totalComments: Int
    var totalLikes: Int
    var userResponseDtos: [CreatedUser]
    var bookAndUserDtos: [BookclubBook]
    var trendingPosts: [PostModel]
}


//"data": {
//        "id": 594,
//        "name": "새로운 클럽 이름4",
//        "level": 1,
//        "presidentId": 586,
//        "description": "클럽 소개",
//        "createdDate": "2022-04-07T12:49:09.766277",
//        "modifiedDate": "2022-04-07T12:49:09.766277",
//        "totalUser": 2,
//        "totalPosts": 0,
//        "totalBooks": 2,
//        "totalComments": 0,
//        "totalLikes": 0,
//        "userResponseDtos": [
//            {
//                "userId": 106,
//                "email": "03@naver.com",
//                "sex": "MALE",
//                "birthdate": "2021-08-22T11:47:31",
//                "nickname": "rabbit",
//                "introduce": "introduce yourself",
//                "style": "once in a week",
//                "goal": "goal",
//                "profileImgLocation": "123somewhere123",
//                "genres": [
//                    "Romance",
//                    "IT"
//                ],
//                "isDormant": false
//            },
//            {
//                "userId": 586,
//                "email": "10@gmail.com",
//                "sex": "MALE",
//                "birthdate": "1997-01-01T11:11:11",
//                "nickname": "rabbit",
//                "introduce": "introduce yourself",
//                "style": "once in a week",
//                "goal": "goal",
//                "profileImgLocation": "123somewhere123",
//                "genres": [
//                    "Romance",
//                    "IT"
//                ],
//                "isDormant": false
//            }
//        ],
//        "bookAndUserDtos": [
//            {
//                "userId": 586,
//                "userNickname": "rabbit",
//                "bookId": 596,
//                "bookName": "죽은 시인의 2회",
//                "isbn": "12341",
//                "category": "AFTER",
//                "createdDate": "2022-04-07T12:52:05.677561",
//                "modifiedDate": "2022-04-07T12:52:05.677561"
//            },
//            {
//                "userId": 586,
//                "userNickname": "rabbit",
//                "bookId": 600,
//                "bookName": "죽은 시인의 3회",
//                "isbn": "123413",
//                "category": "AFTER",
//                "createdDate": "2022-04-07T13:09:31.922713",
//                "modifiedDate": "2022-04-07T13:09:31.922713"
//            }
//        ],
//        "trendingPosts": []
//    }
