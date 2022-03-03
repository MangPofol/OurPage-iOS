//
//  TodoAPI.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/01.
//

import Foundation
import Moya

enum TodoAPI {
    case getTodos
    case createTodos(contents: [String])
    case createTodo(content: String)
    case deleteTodos(ids: [Int])
    case updateTodo(todo: Todo)
}

extension TodoAPI: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .bearer
    }
    
    var baseURL: URL {
        return URL(string: Constants.APISource + "/todos")!
    }
    
    var path: String {
        switch self {
        case .getTodos:
            return ""
        case .createTodo(_):
            return ""
        case .createTodos(_):
            return "create-todos"
        case .deleteTodos(_):
            return "delete-todos"
        case .updateTodo(let todo):
            return "\(todo.toDoId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTodos:
            return .get
        case .createTodo(_), .createTodos(_), .deleteTodos(_):
            return .post
        case .updateTodo(_):
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .getTodos:
            return .requestPlain
        case .createTodo(let content):
            return .requestJSONEncodable(CreatingTodo(content: content, isComplete: false))
        case .createTodos(let contents):
            return .requestJSONEncodable(CreatingTodos(contents: contents))
        case .deleteTodos(let ids):
            return .requestJSONEncodable(DeletingTodoIds(toDoIds: ids))
        case .updateTodo(let todo):
            return .requestJSONEncodable(UpdatingTodo(content: todo.content, isComplete: !todo.isComplete))
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
