//
//  SignUpViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/29.
//

import Foundation
import RxSwift
import RxCocoa

class SignUpViewModel {
    
    static var creatingUser = CreatingUser()
    
    var inputsConfirmed = Observable<Bool>.just(false)
    var idConfirmed: Observable<Bool>
    var passwordConfirmed: Observable<PasswordConfirmType>
    var passwordVerifyingComfirmed: Observable<PasswordConfirmType>
    var nextConfirmed: Observable<Bool>
    
    init(
        input: (
            idText: Observable<String>,
            passwordText: Observable<String>,
            passwordVerifyingText: Observable<String>,
            nextButtonTapped: ControlEvent<()>
        )
    ) {
        SignUpViewModel.creatingUser = CreatingUser()
        
        idConfirmed = input.idText
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMap { id -> Observable<Bool> in
                SignUpViewModel.creatingUser.email = id
                
                if !Constants.isValidString(str: id, regEx: Constants.USEREMAIL_RULE) {
                    return Observable.just(false)
                }
                
                return UserServices.validateDuplicate(email: id)
            }
        
        passwordConfirmed = input.passwordText
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .map { password -> PasswordConfirmType in
                if Constants.isValidString(str: password, regEx: Constants.USERPW_RULE) {
                    return .Okay
                }
                return .NotValid
            }
        
        passwordVerifyingComfirmed = Observable.combineLatest(passwordConfirmed, input.passwordText, input.passwordVerifyingText)
            .map { pwConfirmed, password, verifying -> PasswordConfirmType in
                SignUpViewModel.creatingUser.password = verifying
                
                if pwConfirmed == .NotValid {
                    return .NotValid
                }
                
                if password == verifying {
                    return .Okay
                } else {
                    return .NotSame
                }
            }
        
        inputsConfirmed = Observable.combineLatest(idConfirmed, passwordConfirmed.map { $0 == .Okay }, passwordVerifyingComfirmed.map { $0 == .Okay })
            .map { id, pw, verifying -> Bool in
                return id && pw && verifying
            }
            .distinctUntilChanged()
        
        nextConfirmed = input.nextButtonTapped.withLatestFrom(inputsConfirmed)
            .map { _ in
                return true
            }
    }
}

enum PasswordConfirmType {
    case NotValid
    case NotSame
    case Okay
}
