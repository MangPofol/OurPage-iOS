//
//  BookclubCreateViewModel.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/30.
//

import Foundation

import RxSwift
import RxCocoa

class BookclubCreateViewModel: ViewModelType {
    struct Input {
        var nameText: Observable<String>
        var descriptionText: Observable<String>
        var finishButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        var bookclubCreated: Driver<BookclubCreatResultType>!
    }
    
    var input: Input?
    var output: Output = Output()
    
    init(input: Input) {
        self.input = input
        
        guard let input = self.input else {
            return
        }
        
        let nameAndIntroduce = Observable.combineLatest(input.nameText, input.descriptionText)
        
        self.output.bookclubCreated = input.finishButtonTapped.withLatestFrom(nameAndIntroduce)
            .flatMap { value -> Observable<BookclubCreatResultType> in
                let creatingBookclub = CreatingBookclub(name: value.0, description: value.1)
                return BookclubServices.createBookclub(creatingBookclub: creatingBookclub)
            }
            .asDriver(onErrorJustReturn: BookclubCreatResultType.failure)
    }
}

enum BookclubCreatResultType {
    case success(bookclub: Bookclub)
    case failure
    case nameDuplicated
}
