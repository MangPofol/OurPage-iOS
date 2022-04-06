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
    var colorSet: String
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
