//
//  CheckListViewModel.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/02.
//

import Foundation

import RxSwift
import RxCocoa

final class CheckListViewModel {
    
    // inputs
    var indexToOpen = PublishRelay<Int>()
    var todoToIncomplete = PublishRelay<Todo>()
    var todoToDelete = PublishRelay<Todo>()
    
    // outputs
    var monthlyTodos = PublishRelay<[[Todo]]>()
    
    private var disposeBag = DisposeBag()
    
    init() {
        self.getMonthlyTodos()
            .bind(to: self.monthlyTodos)
            .disposed(by: disposeBag)
        
        self.todoToIncomplete
            .debug()
            .flatMap {
                TodoServices.updateTodo(todo: $0)
            }
            .flatMap { [weak self] _ -> Observable<[[Todo]]> in
                guard let self = self else { return Observable.just([]) }
                return self.getMonthlyTodos()
            }
            .bind(to: self.monthlyTodos)
            .disposed(by: disposeBag)
        
        self.todoToDelete
            .flatMap {
                TodoServices.deleteTodo(ids: [$0.toDoId])
            }
            .flatMap { [weak self] _ -> Observable<[[Todo]]> in
                guard let self = self else { return Observable.just([]) }
                return self.getMonthlyTodos()
            }
            .bind(to: self.monthlyTodos)
            .disposed(by: disposeBag)
    }
    
    private func getMonthlyTodos() -> Observable<[[Todo]]> {
        TodoServices.getTodos()
            .map { todos -> [[Todo]] in
                var monthlyTodo: [[Todo]] = []
                var arr: [Todo] = []
                todos.forEach {
                    guard $0.isComplete else { return }
                    if arr.count == 0 {
                        arr.append($0)
                    } else {
                        if arr[0].createDate.isInSameMonth(as: $0.createDate) {
                            arr.append($0)
                        } else {
                            monthlyTodo.append(arr)
                            arr = [$0]
                        }
                    }
                }
                monthlyTodo.append(arr)
                return monthlyTodo
            }
    }
}
