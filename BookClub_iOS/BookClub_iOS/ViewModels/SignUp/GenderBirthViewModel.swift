//
//  GenderBirthViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/03.
//

import Foundation
import RxSwift
import RxCocoa

class GenderBirthViewModel {
    var genderConfirmed: Observable<Bool>
    var birthConfirmed: Observable<Bool>
    var isAbleToProgress: Observable<Bool>
    
    init(
        input: (
            gender: Observable<String>,
            birth: Observable<String>
        )
    ) {
        genderConfirmed = Observable.just(true)
        birthConfirmed = Observable.just(true)
        
        isAbleToProgress = Observable.combineLatest(genderConfirmed, birthConfirmed).map { $0 && $1 }
    }
}
