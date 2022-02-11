//
//  GoalViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/05.
//

import Foundation

import RxSwift
import RxCocoa
import CryptoKit

class GoalViewModel {
    var isNextConfirmed: Observable<Bool>
    
    var periodText = BehaviorSubject<String>(value: "1")
    var unitText = BehaviorSubject<String>(value: "개월")
    var booksText = BehaviorSubject<String>(value: "10")
    
    init(nextButtonTapped: Observable<Void>) {
        let goalSentence = Observable.combineLatest(periodText, unitText, booksText)
            .map {
                "\($0)\($1) 동안 \($2)권의 책을 기록하기"
            }
        
        isNextConfirmed = nextButtonTapped.withLatestFrom(goalSentence)
                .do(onNext: {
                    SignUpViewModel.creatingUser.goal = $0
                })
                .flatMap { _ -> Observable<Bool> in
                    let user = SignUpViewModel.creatingUser
                    let updatingUser = UpdatingUser(email: user.email, nickname: user.nickname!, sex: user.sex!, birthdate: user.birthdate!, introduce: user.introduce!, style: user.style, goal: user.goal, profileImgLocation: user.profileImgLocation, genres: user.genres)
                    
                    return UserServices.updateUser(user: updatingUser, id: SignUpViewModel.createdUserId)
                }
    }
}
