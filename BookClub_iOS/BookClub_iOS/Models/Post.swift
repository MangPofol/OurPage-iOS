//
//  Post.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/11.
//

import Foundation

//{
//    "id": 353,
//    "scope": "CLUB",
//    "isIncomplete": false,
//    "imgLocation": null,
//    "title": "죽과죽과",
//    "content": "꿀잼10",
//    "createdDate": "2021-11-20T10:06:48.7811308",
//    "modifiedDate": "2021-11-20T10:06:48.7811308",
//    "location": "내 방",
//    "readTime": "해질녘",
//    "hyperlinkTitle": "망포링크",
//    "hyperlink": "www.mangpo.com",
//    "postImgLocations": [
//        "image3",
//        "image4"
//    ],
//    "postScopeClub": {},
//    "likedList": [],
//    "commentsDto": []
//}

struct PostModel: Codable {
    var postId: Int
    var scope: String
    var isIncomplete: Bool
    var title: String
    var content: String
    var createdDate: String
    var modifiedDate: String
    var location: String
    var readTime: String
    var hyperlinkTitle: String
    var hyperlink: String
    var postImgLocations: [String]
    var clubIdListForScope: [Int]
    var likedList: [Liked]
    var commentsDto: [Comment]
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(postId, forKey: .postId)
        try container.encode(scope, forKey: .scope)
        try container.encode(isIncomplete, forKey: .isIncomplete)
        try container.encode(title, forKey: .title)
        try container.encode(content, forKey: .content)
        try container.encode(createdDate, forKey: .createdDate)
        try container.encode(modifiedDate, forKey: .modifiedDate)
        try container.encode(location, forKey: .location)
        try container.encode(readTime, forKey: .readTime)
        try container.encode(hyperlinkTitle, forKey: .hyperlinkTitle)
        try container.encode(hyperlink, forKey: .hyperlink)
        try container.encode(postImgLocations, forKey: .postImgLocations)
        try container.encode(clubIdListForScope, forKey: .clubIdListForScope)
        try container.encode(likedList, forKey: .likedList)
        try container.encode(commentsDto, forKey: .commentsDto)
    }
}

struct PostToCreate: Codable {
    var bookId: Int
    var scope: String
    var isIncomplete: Bool
    var location: String
    var readTime: String
    var hyperlinkTitle: String
    var hyperlink: String
    var title: String
    var content: String
    var postImgLocations: [String]
    var clubIdListForScope: [Int]
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(bookId, forKey: .bookId)
        try container.encode(scope, forKey: .scope)
        try container.encode(isIncomplete, forKey: .isIncomplete)
        try container.encode(location, forKey: .location)
        try container.encode(readTime, forKey: .readTime)
        try container.encode(hyperlinkTitle, forKey: .hyperlinkTitle)
        try container.encode(hyperlink, forKey: .hyperlink)
        try container.encode(title, forKey: .title)
        try container.encode(content, forKey: .content)
        try container.encode(postImgLocations, forKey: .postImgLocations)
        try container.encode(clubIdListForScope, forKey: .clubIdListForScope)
    }
}

struct PostToUpdate: Codable {
    var type: String
    var scope: String
    var isIncomplete: Bool
    var imgLocation: String
    var title: String
    var content: String
}

struct Comment: Codable {
    var userNickname: String
    var content: String
    var createdDate: String
    var modifiedDate: String
}
