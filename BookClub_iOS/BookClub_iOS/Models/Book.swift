//
//  Book.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/13.
//

import UIKit.UIImage

struct BookModel: Codable {
    var id: String
    var name: String
    var isbn: String
    var category: String
    var createdDate: String
    var modifiedDate: String
    var likedList: [Liked]
}

struct Liked: Codable {
    var userNickname: String
    var isLiked: Bool
}

struct BookToCreate: Codable {
    var name: String
    var isbn: String
    var category: String
}
