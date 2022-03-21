//
//  ModifyGoalViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/19.
//

import Foundation

import RxSwift
import RxRelay

class ModifyGoalViewModel {
    var isModified = BehaviorSubject<Bool>(value: false)
    
    var goalSentence = PublishRelay<String>()
    
    var disposeBag = DisposeBag()
    
    init() {
        self.goalSentence
            .flatMap { val -> Observable<Bool> in
                do {
                    if let currentUser = try? Constants.CurrentUser.value() {
                        let updatingUser = UpdatingUser(email: currentUser.email, nickname: currentUser.nickname!, sex: currentUser.sex!, birthdate: currentUser.birthdate!, introduce: currentUser.introduce!, style: currentUser.style ?? "", goal: val, profileImgLocation: currentUser.profileImgLocation ?? "", genres: currentUser.genres)
                        
                        return UserServices.updateUser(user: updatingUser, id: currentUser.userId)
                    } else {
                        return Observable.just(false)
                    }
                }
            }
            .flatMap { [weak self] bool -> Observable<CreatedUser?> in
                if bool {
                    self?.isModified.onNext(true)
                    return UserServices.getCurrentUserInfo()
                } else {
                    return Observable.just(nil)
                }
            }
            .subscribe(onNext: {
                Constants.CurrentUser.onNext($0)
            })
            .disposed(by: disposeBag)
    }
}
