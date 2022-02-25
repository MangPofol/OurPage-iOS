//
//  PasswordChangeViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/21.
//

import Foundation

import RxSwift
import RxCocoa

final class PasswordChangeViewModel {
    
    private let disposeBag = DisposeBag()
    
    // outputs
    var passwordChanged: Driver<PasswordChangeResultType>
    
    init(
        input: (
            newPassword: Observable<String>,
            newPasswordVerifying: Observable<String>,
            finishButtonTapped: ControlEvent<Void>
        )
    ) {
        let passwordAndVerifying = Observable.combineLatest(input.newPassword, input.newPasswordVerifying)
        
        self.passwordChanged = input.finishButtonTapped
            .withLatestFrom(passwordAndVerifying)
            .delay(.seconds(2), scheduler: MainScheduler.instance)
            .flatMap { val -> Observable<PasswordChangeResultType> in
                if val.0 != val.1 {
                    return Observable.just(.notCorrect)
                }
                
                if !(Constants.isValidString(str: val.0, regEx: Constants.USERPW_RULE) &&
                     Constants.isValidString(str: val.1, regEx: Constants.USERPW_RULE)) {
                    return Observable.just(.notValid)
                }
                
                return UserServices.changePassword(newPassword: val.0).map { bool -> PasswordChangeResultType in
                    if bool {
                        return .success
                    } else {
                        return .failure
                    }
                }
            }
            .asDriver(onErrorJustReturn: .failure)
    }
}

enum PasswordChangeResultType {
    case success
    case failure
    case notCorrect
    case notValid
}
