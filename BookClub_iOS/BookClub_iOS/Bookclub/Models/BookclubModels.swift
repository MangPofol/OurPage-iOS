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
    //"id": 8,
    //    "name": "새로운 클럽 이름",
    //    "colorSet": "A",
    //    "level": 1,
    //    "presidentId": 1,
    //    "description": "클럽 소개",
    //    "createdDate": "2021-09-16T16:39:21.8062928",
    //    "modifiedDate": "2021-09-16T16:39:21.8062928"
}

struct CreatingBookclub: Codable {
    var name: String
    var colorSet: String = "A"
    var description: String
}
