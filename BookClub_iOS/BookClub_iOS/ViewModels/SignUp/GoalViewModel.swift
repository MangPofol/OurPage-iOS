//
//  GoalViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/05.
//

import Foundation

import RxSwift
import RxCocoa

class GoalViewModel {
    var isAbleToProgress: Observable<Bool>
    var isNextConfirmed: Observable<Bool>
    
    init(
        input: (
            period: Observable<String>,
            unit: Observable<String>,
            books: Observable<String>,
            nextButtonTapped: ControlEvent<()>
        )
    ) {
        isAbleToProgress = Observable.combineLatest(input.period, input.unit, input.books)
            .map {
                print($0, $1, $2)
                return true
            }
        isNextConfirmed = input.nextButtonTapped.withLatestFrom(isAbleToProgress).map { $0 }
    }
}
