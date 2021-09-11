//
//  Book.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/13.
//

import UIKit.UIImage

struct BookModel: Codable {
    var category: String
    var createdDate: String
    var id: Int
    var isbn: String
    var likedList: [Liked]
    var modifiedDate: String
    var name: String
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
