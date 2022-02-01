//
//  EmailAuthViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/01.
//

import Foundation

import RxSwift
import RxCocoa

final class EmailAuthViewModel {
    struct Input {
        var sendButtonTapped: ControlEvent<Void>
        var nextButtonTapped: ControlEvent<Void>
        var authText: Observable<String>
    }
    
    struct Output {
        var isSentAuthCode: Driver<Bool>!
        var authState: Driver<AuthStateType>!
        var isNextButtonEnabled: Driver<Bool>!
    }
    
    var input: Input!
    var output = Output()
    
    private let disposeBag = DisposeBag()
    
    init(input: Input) {
        self.input = input
        
        self.output.isSentAuthCode = self.input.sendButtonTapped
            .flatMap {
                return UserServices.validateEmail()
            }
            .asDriver(onErrorJustReturn: false)
        
        self.output.isNextButtonEnabled = self.input.authText.map {
            $0.count >= 2
        }.asDriver(onErrorJustReturn: false)
        
        self.output.authState = self.input.nextButtonTapped.withLatestFrom(self.input.authText)
            .flatMap { authText -> Observable<Bool> in
                return UserServices.validateEmailSendCode(emailCode: authText)
            }
            .map {
                if $0 {
                    return AuthStateType.success
                } else {
                    return AuthStateType.fail
                }
            }
            .asDriver(onErrorJustReturn: .fail)
    }
}

enum AuthStateType {
    case fail
    case success
}
