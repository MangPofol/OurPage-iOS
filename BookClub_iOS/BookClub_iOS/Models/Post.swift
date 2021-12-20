//
//  Post.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/11.
//

import Foundation

struct PostModel: Codable {
    var id: Int
    var type: String
    var scope: String
    var isIncomplete: Bool
    var imgLocation: String
    var title: String
    var content: String
    var createdDate: String
    var modifiedDate: String
    var likedList: [Liked]
    var commentDto: [Comment]
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
    var clubIdListForScope: [String]
    
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
    
    static func fromPost(_ post: PostModel) -> PostToUpdate {
        return PostToUpdate(type: post.type, scope: post.scope, isIncomplete: post.isIncomplete, imgLocation: post.imgLocation, title: post.title, content: post.content)
        
    }
}

struct Comment: Codable {
    var userNickname: String
    var content: String
    var createdDate: String
    var modifiedDate: String
}
