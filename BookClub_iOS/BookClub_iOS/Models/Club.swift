//
//  Club.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/25.
//

import Foundation

struct Club: Codable {
    var id: Int
    var name: String
    var colorSet: String
    var level: Int
    var presidentId: Int
    var description: String
    var createdDate: String
    var modifiedDate: String
}


//"id": 110,
//            "name": "새로운 클럽 이름",
//            "colorSet": "A",
//            "level": 1,
//            "presidentId": 1,
//            "description": "클럽소개",
//            "createdDate": "2021-08-22T11:47:31",
//            "modifiedDate": "2021-08-22T11:47:31"
