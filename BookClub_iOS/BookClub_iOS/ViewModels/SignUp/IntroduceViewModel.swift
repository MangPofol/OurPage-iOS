//
//  IntroduceViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/03.
//

import Foundation

import RxSwift
import RxCocoa

class IntroduceViewModel {
    var isIntroduceConfirmed: Observable<Bool>
    var isNextConfirmed: Observable<Bool>
    
    init(
        input: (
            introduceText: Observable<String>,
            nextButtonTapped: ControlEvent<()>
        )
    ) {
        isIntroduceConfirmed = input.introduceText.map { $0.count > 0 }
        isNextConfirmed = input.nextButtonTapped.withLatestFrom(isIntroduceConfirmed).map { $0 }
    }
}
