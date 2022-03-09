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
    var createdDate: Date
    var modifiedDate: Date
    var location: String
    var readTime: String
    var linkResponseDtos: [PostHyperlink]
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
        try container.encode(linkResponseDtos, forKey: .linkResponseDtos)
        try container.encode(postImgLocations, forKey: .postImgLocations)
        try container.encode(clubIdListForScope, forKey: .clubIdListForScope)
        try container.encode(likedList, forKey: .likedList)
        try container.encode(commentsDto, forKey: .commentsDto)
    }
}

struct PostHyperlink: Codable {
    var linkId: Int
    var hyperlinkTitle: String
    var hyperLink: String
    
    func toCreatingPostHyperlink() -> CreatingPostHyperlink {
        return CreatingPostHyperlink(hyperlinkTitle: self.hyperlinkTitle, hyperlink: self.hyperLink)
    }
}


struct CreatingPostHyperlink: Codable {
    var hyperlinkTitle: String
    var hyperlink: String
}

struct PostToCreate: Codable {
    var bookId: Int
    var scope: String
    var isIncomplete: Bool
    var location: String
    var readTime: String
    var title: String
    var content: String
    var postImgLocations: [String]
    var linkRequestDtos: [CreatingPostHyperlink]
    var clubIdListForScope: [Int]
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(bookId, forKey: .bookId)
        try container.encode(scope, forKey: .scope)
        try container.encode(isIncomplete, forKey: .isIncomplete)
        try container.encode(location, forKey: .location)
        try container.encode(readTime, forKey: .readTime)
        try container.encode(linkRequestDtos, forKey: .linkRequestDtos)
        try container.encode(title, forKey: .title)
        try container.encode(content, forKey: .content)
        try container.encode(postImgLocations, forKey: .postImgLocations)
        try container.encode(clubIdListForScope, forKey: .clubIdListForScope)
    }
}

struct PostToUpdate: Codable {
    var scope: String
    var isIncomplete: Bool
    var location: String
    var readTime: String
    var title: String
    var content: String
    var postImgLocations: [String]
    var linkRequestDtos: [CreatingPostHyperlink]
    var clubIdListForScope: [Int]
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(scope, forKey: .scope)
        try container.encode(isIncomplete, forKey: .isIncomplete)
        try container.encode(location, forKey: .location)
        try container.encode(readTime, forKey: .readTime)
        try container.encode(linkRequestDtos, forKey: .linkRequestDtos)
        try container.encode(title, forKey: .title)
        try container.encode(content, forKey: .content)
        try container.encode(postImgLocations, forKey: .postImgLocations)
        try container.encode(clubIdListForScope, forKey: .clubIdListForScope)
    }
}

struct Comment: Codable {
    var userNickname: String
    var content: String
    var createdDate: String
    var modifiedDate: String
}
