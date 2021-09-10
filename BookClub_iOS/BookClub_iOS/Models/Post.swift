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
    var id: Int
    var type: String
    var scope: String
    var isIncomplete: Bool
    var imgLocation: String
    var title: String
    var content: String
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
