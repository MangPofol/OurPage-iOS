//
//  Todo.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/01.
//

import Foundation

//"content": "content2",
//            "isComplete": true,
//            "createDate": "2021-12-15T18:51:20.94031",
//            "modifiedDate": "2021-12-15T18:52:58.061572",
//            "toDoId": 90

struct Todo: Codable {
    var content: String
    var isComplete: Bool
    var createDate: Date
    var modifiedDate: Date
    var toDoId: Int
}

struct CreatingTodo: Codable {
    var content: String
    var isComplete: Bool
}

struct CreatingTodos: Codable {
    var contents: [String]
}

struct DeletingTodoIds: Codable {
    var toDoIds: [Int]
}

struct TodoResponse: Codable {
    var data: [Todo]
}

struct UpdatingTodo: Codable {
    var content: String
    var isComplete: Bool
}
