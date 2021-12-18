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
//                    let original = SignUpViewModel.creatingUser.password.data(using: .utf8)!
//                    let sha256 = SHA256.hash(data: original)
//                    SignUpViewModel.creatingUser.password = sha256.compactMap {
//                        String(format: "%02x", $0)
//                    }.joined()
                })
                .flatMap { _ in
                    AuthServices.createUser(user: SignUpViewModel.creatingUser)
                }
    }
}
