//
//  ReadingStyleViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/05.
//

import Foundation

import RxSwift
import RxCocoa

class ReadingStyleViewModel {
    var isStyleSelected: Observable<Bool>
    var isNextConfirmed: Observable<Bool>
    
    init(
        input: (
            styleText: Observable<String>,
            nextButtonTapped: ControlEvent<()>
        )
    ) {
        isStyleSelected = input.styleText
            .do { SignUpViewModel.creatingUser.style = $0 }
            .map { $0.count > 0 }
        isNextConfirmed = input.nextButtonTapped.withLatestFrom(isStyleSelected).map { $0 }
    }
}
