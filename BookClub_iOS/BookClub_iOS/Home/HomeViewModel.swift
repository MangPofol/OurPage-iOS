//
//  HomeViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/29.
//

import Foundation

import UIKit.UITapGestureRecognizer
import RxSwift
import RxCocoa
import RxGesture

class HomeViewModel {
    var checkListToggle: Observable<Bool>
    var openMyProfileView: Observable<Bool>
    var openModifyGoalView : Observable<Bool>
    var openWriteView: Observable<Bool>
    var totalCount: Observable<Int?>
    var todos = PublishRelay<[Todo?]>()
    
    var createTodoButtonTapped = PublishRelay<()>()
    var newTodoText = PublishRelay<String>()
    var completeTodo = PublishRelay<Todo>()
    var todoCompleted = PublishRelay<Bool>()
    var deleteTodo = PublishRelay<Todo>()
    
    private let disposeBag = DisposeBag()
    
    init(
        checkListButtonTapped: ControlEvent<()>,
        myProfileButtonTapped: ControlEvent<()>,
        goalButtonTapped: Observable<UITapGestureRecognizer>,
        writeButtonTapped: Observable<UITapGestureRecognizer>
    ) {
        checkListToggle = checkListButtonTapped.map { true }
        openMyProfileView = myProfileButtonTapped.map { true }
        openModifyGoalView = goalButtonTapped.map { _ in true }
        openWriteView = writeButtonTapped.map { _ in true }
        totalCount = PostServices.getTotalCount()
        
        self.getTodos()
            .bind(to: self.todos)
            .disposed(by: disposeBag)
        
        newTodoText
            .flatMap {
                TodoServices.createTodo(content: $0)
            }
            .flatMap { [weak self] _ -> Observable<[Todo?]> in
                guard let self = self else { return Observable.just([]) }
                return self.getTodos()
            }
            .bind(to: self.todos)
            .disposed(by: disposeBag)
        
        deleteTodo
            .flatMap {
                TodoServices.deleteTodo(ids: [$0.toDoId])
            }
            .flatMap { [weak self] _ -> Observable<[Todo?]> in
                guard let self = self else { return Observable.just([]) }
                return self.getTodos()
            }
            .bind(to: self.todos)
            .disposed(by: disposeBag)
        
        completeTodo
            .flatMap {
                TodoServices.updateTodo(todo: $0)
            }
            .flatMap { [weak self] _ -> Observable<[Todo?]> in
                guard let self = self else { return Observable.just([]) }
                self.todoCompleted.accept(true)
                return self.getTodos()
            }
            .bind(to: self.todos)
            .disposed(by: disposeBag)
    }
    
    func getTodos() -> Observable<[Todo?]> {
        TodoServices.getTodos()
            .map {
                var todos: [Todo?] = []
                $0.forEach {
                    if !$0.isComplete {
                        todos.append($0)
                    }
                }
                todos = todos + Array(repeating: nil, count: 5 - todos.count)
                return todos
            }
    }
    
    func reloadTodos() {
        self.getTodos()
            .bind(to: self.todos)
            .disposed(by: disposeBag)
    }
}
