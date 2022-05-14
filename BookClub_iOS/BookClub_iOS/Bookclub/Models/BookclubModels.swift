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

struct ClubResponseDto: Codable {
    var id: Int
    var name: String
    var level: Int
    var presidentId: Int
    var description: String
    var lastAddBookDate: Date?
    var createdDate: Date
    var modifiedDate: Date
}

struct BookclubInfo: Codable {
    var totalUser: Int
    var totalPosts: Int
    var totalBooks: Int
    var totalComments: Int
    var totalLikes: Int
    
    var clubMetadata: ClubResponseDto
    
    var users: [CreatedUser]
    var bookclubBook: [BookclubBook]
    var trendingPosts: [ClubPost]
    
    enum CodingKeys: String, CodingKey {
        case totalUser
        case totalPosts
        case totalBooks
        case totalComments
        case totalLikes
        case clubMetadata = "clubResponseDto"
        case users = "userResponseDtos"
        case bookclubBook = "bookAndUserDtos"
        case trendingPosts = "trendingPostDtos"
    }
}


//{
//    "data": {
//        "totalUser": 3,
//        "totalPosts": 10,
//        "totalBooks": 6,
//        "totalComments": 7,
//        "totalLikes": 2,
//        "clubResponseDto": {
//            "id": 2649,
//            "name": "클럽이름 1",
//            "level": 1,
//            "presidentId": 2637,
//            "description": "tester-1이 클럽장인 클럽",
//            "lastAddBookDate": null,
//            "createdDate": "2022-04-27T11:58:57",
//            "modifiedDate": "2022-04-27T11:58:57"
//        },
//        "userResponseDtos": [
//            {
//                "userId": 2637,
//                "email": "tester-1",
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
//            },
//            {
//                "userId": 2641,
//                "email": "tester-2",
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
//            },
//            {
//                "userId": 2645,
//                "email": "tester-3",
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
//                "userId": 2637,
//                "userNickname": "rabbit",
//                "bookId": 2651,
//                "bookName": "죽은 시인의 사회",
//                "isbn": "898802740X",
//                "category": "AFTER",
//                "createdDate": "2022-04-27T11:59:46",
//                "modifiedDate": "2022-04-27T11:59:46"
//            },
//            {
//                "userId": 2637,
//                "userNickname": "rabbit",
//                "bookId": 2654,
//                "bookName": "긴긴밤(보름달문고 83)",
//                "isbn": "8954677150",
//                "category": "AFTER",
//                "createdDate": "2022-04-27T11:59:54",
//                "modifiedDate": "2022-04-27T11:59:54"
//            },
//            {
//                "userId": 2641,
//                "userNickname": "rabbit",
//                "bookId": 2679,
//                "bookName": "둥실이네 떡집",
//                "isbn": "8949162180",
//                "category": "AFTER",
//                "createdDate": "2022-04-27T12:02:59",
//                "modifiedDate": "2022-04-27T12:02:59"
//            },
//            {
//                "userId": 2641,
//                "userNickname": "rabbit",
//                "bookId": 2682,
//                "bookName": "내가 틀릴 수도 있습니다",
//                "isbn": "1130689891",
//                "category": "AFTER",
//                "createdDate": "2022-04-27T12:03:06",
//                "modifiedDate": "2022-04-27T12:03:06"
//            },
//            {
//                "userId": 2645,
//                "userNickname": "rabbit",
//                "bookId": 2717,
//                "bookName": "긴긴밤(보름달문고 83)",
//                "isbn": "8954677150",
//                "category": "AFTER",
//                "createdDate": "2022-04-27T12:11:49",
//                "modifiedDate": "2022-04-27T12:11:49"
//            },
//            {
//                "userId": 2645,
//                "userNickname": "rabbit",
//                "bookId": 2720,
//                "bookName": "죽은 시인의 사회",
//                "isbn": "898802740X",
//                "category": "AFTER",
//                "createdDate": "2022-04-27T12:11:56",
//                "modifiedDate": "2022-04-27T12:11:56"
//            }
//        ],
//        "trendingPostDtos": [
//            {
//                "nickname": "rabbit",
//                "profileImgLocation": "123somewhere123",
//                "bookName": "죽은 시인의 사회",
//                "postResponseDto": {
//                    "postId": 2727,
//                    "scope": "PUBLIC",
//                    "isIncomplete": false,
//                    "title": "죽과죽과-6",
//                    "content": "꿀잼10",
//                    "createdDate": "2022-04-27T12:12:32",
//                    "modifiedDate": "2022-04-27T12:12:32",
//                    "location": "내 방1218",
//                    "readTime": "해질녘",
//                    "linkResponseDtos": [
//                        {
//                            "linkId": 2728,
//                            "hyperlink": "www.mangpo.com1",
//                            "hyperlinkTitle": "망포링크1"
//                        },
//                        {
//                            "linkId": 2729,
//                            "hyperlink": "www.mangpo.com2",
//                            "hyperlinkTitle": "망포링크2"
//                        }
//                    ],
//                    "postImgLocations": [
//                        "image3",
//                        "image4"
//                    ],
//                    "clubIdListForScope": [],
//                    "likedList": [
//                        {
//                            "userNickname": "rabbit",
//                            "isLiked": true
//                        },
//                        {
//                            "userNickname": "rabbit",
//                            "isLiked": true
//                        }
//                    ],
//                    "commentsDto": [
//                        {
//                            "commentId": 2735,
//                            "parentCommentId": null,
//                            "userNickname": "rabbit",
//                            "content": "this is content10.",
//                            "createdDate": "2022-04-27T12:14:44",
//                            "modifiedDate": "2022-04-27T12:14:44"
//                        },
//                        {
//                            "commentId": 2736,
//                            "parentCommentId": null,
//                            "userNickname": "rabbit",
//                            "content": "this is content11.",
//                            "createdDate": "2022-04-27T12:14:49",
//                            "modifiedDate": "2022-04-27T12:14:49"
//                        },
//                        {
//                            "commentId": 2737,
//                            "parentCommentId": null,
//                            "userNickname": "rabbit",
//                            "content": "this is content12.",
//                            "createdDate": "2022-04-27T12:14:54",
//                            "modifiedDate": "2022-04-27T12:14:54"
//                        },
//                        {
//                            "commentId": 2738,
//                            "parentCommentId": null,
//                            "userNickname": "rabbit",
//                            "content": "this is content13.",
//                            "createdDate": "2022-04-27T12:14:57",
//                            "modifiedDate": "2022-04-27T12:14:57"
//                        },
//                        {
//                            "commentId": 2740,
//                            "parentCommentId": null,
//                            "userNickname": "rabbit",
//                            "content": "this is content13.",
//                            "createdDate": "2022-04-27T12:15:14",
//                            "modifiedDate": "2022-04-27T12:15:14"
//                        },
//                        {
//                            "commentId": 2741,
//                            "parentCommentId": null,
//                            "userNickname": "rabbit",
//                            "content": "this is content14.",
//                            "createdDate": "2022-04-27T12:15:18",
//                            "modifiedDate": "2022-04-27T12:15:18"
//                        },
//                        {
//                            "commentId": 2742,
//                            "parentCommentId": null,
//                            "userNickname": "rabbit",
//                            "content": "this is content16.",
//                            "createdDate": "2022-04-27T12:15:21",
//                            "modifiedDate": "2022-04-27T12:15:21"
//                        }
//                    ]
//                }
//            }
//        ]
//    }
//}
