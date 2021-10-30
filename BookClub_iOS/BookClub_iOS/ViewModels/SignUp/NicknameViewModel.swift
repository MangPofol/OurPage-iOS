//
//  NicknameViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/30.
//

import Foundation

import RxSwift
import RxCocoa

class NicknameViewModel {
    
    var nicknameConfirmed = Observable<Bool>.just(false)
    var nextConfirmed = Observable<Bool>.just(false)
    
    init(
        input: (
            nicknameText: Observable<String>,
            nextButtonTapped: ControlEvent<()>
        )
    ) {
        nicknameConfirmed = input.nicknameText
            .map {
                SignUpViewModel.creatingUser.nickname = $0
                return Constants.isValidString(str: $0, regEx: Constants.USERNICKNAME_RULE)
            }
        
        nextConfirmed = input.nextButtonTapped.map { true }
    }
}
