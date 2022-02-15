//
//  GenreViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/10.
//

import Foundation

import RxSwift
import RxCocoa

class GenreViewModel {
    var isAbleToProgress: Observable<Bool>
    var isNextConfirmed: Observable<Bool>
    var selectedGenres = BehaviorSubject<[String]>(value: [])
    
    init(nextButtonTapped: ControlEvent<()>) {
        isAbleToProgress = selectedGenres
            .do {
                SignUpViewModel.creatingUser.genres = $0
            }
            .map { $0.count > 0 }
        isNextConfirmed = nextButtonTapped.map { true }
    }
}
