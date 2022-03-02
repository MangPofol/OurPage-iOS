//
//  TodoServices.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/01.
//

import Foundation

import Moya
import RxSwift
import RxCocoa

final class TodoServices: Networkable {
    typealias Target = TodoAPI
    
    static let provider = makeProvider()
    
    static func getTodos() -> Observable<[Todo]> {
        TodoServices.provider
            .rx.request(.getTodos)
            .asObservable()
            .map {
                let response = try? Constants.defaultDecoder.decode(TodoResponse.self, from: $0.data)
                return response?.data ?? []
            }
    }
    
    static func createTodo(content: String) -> Observable<Todo?> {
        TodoServices.provider
            .rx.request(.createTodo(content: content))
            .asObservable()
            .map {
                if $0.statusCode != 201 {
                    return nil
                }
                
                let response = try? Constants.defaultDecoder.decode(Todo.self, from: $0.data)
                return response ?? nil
            }
    }
    
    static func createTodo(contents: [String]) -> Observable<Bool> {
        TodoServices.provider
            .rx.request(.createTodos(contents: contents))
            .asObservable()
            .map {
                return $0.statusCode == 204
            }
    }
    
    static func deleteTodo(ids: [Int]) -> Observable<Bool> {
        TodoServices.provider
            .rx.request(.deleteTodos(ids: ids))
            .asObservable()
            .map {
                return $0.statusCode == 204
            }
    }
    
    static func updateTodo(todo: Todo) -> Observable<Bool> {
        TodoServices.provider
            .rx.request(.updateTodo(todo: todo))
            .asObservable()
            .map {
                return $0.statusCode == 204
            }
    }
}
