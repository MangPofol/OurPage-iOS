//
//  LoginViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/21.
//

import Foundation

import RxSwift
import RxCocoa

class LoginViewModel {
    var isLoginConfirmed: Observable<LoginResultType>
    
    init(idText: Observable<String>, passwordText: Observable<String>, loginButtonTapped: ControlEvent<()>) {
        let idAndPassword = Observable.combineLatest(idText, passwordText)
        
        
        isLoginConfirmed = loginButtonTapped.withLatestFrom(idAndPassword)
            .do { _ in LoadingHUD.show() }
            .flatMap {
                AuthServices.login(id: $0, password: $1)
            }
            .flatMap { bool -> Observable<CreatedUser?> in
                if bool {
                    return UserServices.getCurrentUserInfo()
                } else {
                    return Observable.just(nil)
                }
                
            }
            .delay(.milliseconds(1500), scheduler: MainScheduler.instance)
            .map {
                guard let user = $0 else { return .failed }
                
                if user.isDormant {
                    return .deleted
                } else {
                    Constants.CurrentUser.onNext($0)
                    return .success
                }
            }
    }
}

enum LoginResultType {
    case success
    case failed
    case deleted
    case error
}
