//
//  MyProfileViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/13.
//

import Foundation

import RxSwift
import RxCocoa
import UIKit.UIImage

class MyProfileViewModel {
    // outputs
    var myGenre: Driver<[String]>
    var recordCount: Driver<Int>
    var bookCount: Driver<Int>
    var uploadedImageUrl = PublishRelay<String>()
    var profileImageUpdated = PublishRelay<Bool>()
    
    // inputs
    var updatingProfileImage = PublishRelay<UIImage?>()
    
    private let disposeBag = DisposeBag()
    
    init() {
        self.myGenre = Constants.CurrentUser
            .compactMap { $0?.genres }
            .asDriver(onErrorJustReturn: [])
        
        self.recordCount = PostServices.getTotalCount()
            .compactMap{ $0 }
            .asDriver(onErrorJustReturn: 0)
        
        self.bookCount = BookServices.getBooksBy(category: "AFTER")
            .compactMap { $0.count }
            .asDriver(onErrorJustReturn: 0)
        
        updatingProfileImage
            .compactMap { $0 }
            .flatMap {
                FileServices.uploadFile(file: $0.jpegData(compressionQuality: 1)!)
            }
            .flatMap { [weak self] url -> Observable<(UpdatingUser, Int)> in
                self?.uploadedImageUrl.accept(url ?? "")
                return UserServices.getCurrentUserInfo()
                    .compactMap { $0 }
                    .map { user in
                        let newUser = UpdatingUser(email: user.email, nickname: user.nickname ?? "", sex: user.sex!, birthdate: user.birthdate!, introduce: user.introduce!, style: user.style, goal: user.goal, profileImgLocation: url, genres: user.genres)
                        return (newUser, user.userId)
                    }
            }
            .flatMap {
                UserServices.updateUser(user: $0.0, id: $0.1)
            }
            .bind(to: profileImageUpdated)
            .disposed(by: disposeBag)
    }
}
