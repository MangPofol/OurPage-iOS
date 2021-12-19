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
    var isLoginConfirmed: Observable<Bool>
    
    init(idText: Observable<String>, passwordText: Observable<String>, loginButtonTapped: ControlEvent<()>) {
        let idAndPassword = Observable.combineLatest(idText, passwordText)
        isLoginConfirmed = loginButtonTapped.withLatestFrom(idAndPassword)
            .flatMap {
                AuthServices.login(id: $0, password: $1)
            }
    }
}
