//
//  ProfileMakeViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/30.
//

import Foundation

import RxSwift
import RxCocoa
import UIKit.UIImage

class ProfileMakeViewModel {
    
    var nicknameConfirmed = Observable<Bool>.just(false)
    var addingProfileImage: Observable<Bool>
    var nextConfirmed = Observable<Bool>.just(false)
    
    var uploadingImage = BehaviorSubject<UIImage?>(value: nil)
    var uploadedImageUrl = BehaviorSubject<String?>(value: nil)
    
    var disposeBag = DisposeBag()
    
    init(
        input: (
            nicknameText: Observable<String>,
            profileImageButtonTapped: ControlEvent<()>,
            nextButtonTapped: Observable<Bool>
        )
    ) {
        nicknameConfirmed = input.nicknameText
            .map {
                SignUpViewModel.creatingUser.nickname = $0
                return Constants.isValidString(str: $0, regEx: Constants.USERNICKNAME_RULE)
            }
        
        addingProfileImage = input.profileImageButtonTapped.map { _ in true }
        
        nextConfirmed = input.nextButtonTapped.map { _ in true }
        
        uploadingImage
            .compactMap { $0 }
            .flatMap {
                FileServices.uploadFile(file: $0.jpegData(compressionQuality: 1)!)
            }
            .bind { [weak self] in
                self?.uploadedImageUrl.onNext($0)
                if let url = $0 {
                    SignUpViewModel.creatingUser.profileImgLocation = url
                }
            }
            .disposed(by: disposeBag)
    }
}
