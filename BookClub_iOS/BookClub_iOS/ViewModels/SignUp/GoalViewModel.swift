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
    
    init(nextButtonTapped: ControlEvent<()>) {
        let goalSentence = Observable.combineLatest(periodText, unitText, booksText)
            .map {
                "\($0)\($1) 동안 \($2)권의 책을 기록하기"
            }
        
        isNextConfirmed = nextButtonTapped.withLatestFrom(goalSentence)
                .do(onNext: {
                    SignUpViewModel.creatingUser = CreatingUser(email: "dlskawns96@gmail.com", nickname: "테스터", password: "alswp12sk!", sex: "MALE", birthdate: "1996-07-01T11:11:11", introduce: "테스터입니다", style: "아침을 먹고 아이패드로 책을 보는 타입", goal: "1개월 동안 10권의 책을 기록하기", profileImgLocation: "", genres: ["소설", "과학"])
                    SignUpViewModel.creatingUser.goal = $0
                    let original = SignUpViewModel.creatingUser.password.data(using: .utf8)!
                    let sha256 = SHA256.hash(data: original)
                    SignUpViewModel.creatingUser.password = sha256.compactMap {
                        String(format: "%02x", $0)
                    }.joined()
                })
                .flatMap { _ in
                    UserServices.createUser(user: SignUpViewModel.creatingUser)
                }
                .map {
                    return $0 != nil
                }
    }
}
