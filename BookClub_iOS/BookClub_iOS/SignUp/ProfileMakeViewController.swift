//
//  ProfileMakeViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/30.
//

import UIKit

import RxSwift
import RxCocoa
import RxKeyboard
import ZLPhotoBrowser

class ProfileMakeViewController: UIViewController {

    let customView = ProfileMakeView()
    
    var viewModel: ProfileMakeViewModel!
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = customView
        self.navigationItem.backButtonTitle = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ProfileMakeViewModel(
            input: (
                nicknameText: self.customView.nicknameTextField.rx.text
                    .filter { $0 != nil }.map { $0! },
                profileImageButtonTapped: self.customView.profileImageAddButton.rx.tap,
                nextButtonTapped: self.customView.nextButton.rx.tap
                    .do { [weak self] _ in
                        self?.customView.nextButton.animateButton()
                    }.map { true }
            )
        )
        
        // bind outputs {
        viewModel.nicknameConfirmed
            .withUnretained(self)
            .bind { (owner, bool) in
                owner.customView.nextInformationLabel.isHidden = !bool
                owner.customView.nicknameConfirmMessageLabel.isHidden = bool
                if bool {
                    owner.customView.nextButton.isUserInteractionEnabled = true
                    owner.customView.nextButton.backgroundColor = .mainPink
                    owner.customView.nextButton.setTitleColor(.white, for: .normal)
                } else {
                    owner.customView.nextButton.isUserInteractionEnabled = false
                    owner.customView.nextButton.backgroundColor = .textFieldBackgroundGray
                    owner.customView.nextButton.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.addingProfileImage
            .filter { $0 }
            .withUnretained(self)
            .bind { (owner, _) in
                let cameraConfig = ZLPhotoConfiguration.default().cameraConfiguration
                ZLPhotoConfiguration.default().allowRecordVideo = false
                ZLPhotoConfiguration.default().allowSelectGif = false
                ZLPhotoConfiguration.default().maxSelectCount = 1
                ZLPhotoConfiguration.default().allowEditImage = true
                ZLPhotoConfiguration.default().editAfterSelectThumbnailImage = true
                ZLPhotoConfiguration.default().allowSelectOriginal = false
                let editConfiguration = ZLEditImageConfiguration()
                editConfiguration.clipRatios = [.wh1x1]
                editConfiguration.tools  = [.clip]
                ZLPhotoConfiguration.default().editImageConfiguration = editConfiguration
                
                // All properties of the camera configuration have default value
                cameraConfig.sessionPreset = .hd1920x1080
                cameraConfig.focusMode = .continuousAutoFocus
                cameraConfig.exposureMode = .continuousAutoExposure
                cameraConfig.flashMode = .off
                cameraConfig.videoExportType = .mov
                
                let ps = ZLPhotoPreviewSheet()
                
                ps.selectImageBlock = { [weak self] (images, assets, isOriginal) in
                    self!.viewModel.uploadingImage.onNext(images.first)
                }
                ps.showPhotoLibrary(sender: self)
            }
            .disposed(by: disposeBag)
        
        viewModel.uploadedImageUrl
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in
                self?.customView.profileImageView.kf.setImage(with: URL(string: $0), placeholder: UIImage.DefaultProfileImage)
            }
            .disposed(by: disposeBag)
        
        viewModel.nextConfirmed
            .bind { [weak self] in
                if $0 {
                    self?.navigationController?.pushViewController(GenderBirthViewController(), animated: true)
                }
            }
            .disposed(by: disposeBag)
        // }
        
        RxKeyboard.instance.visibleHeight
            .skip(1)
            .drive(onNext: { [weak self] height in
                UIView.animate(withDuration: 0) {
                    if height == 0 {
                        self?.customView.profileTitleLabel.snp.updateConstraints {
                            $0.top.equalToSuperview().inset(70.adjustedHeight)
                        }
                        self?.customView.nextInformationLabel.snp.updateConstraints {
                            $0.bottom.equalToSuperview().inset(Constants.getAdjustedHeight(75.0))
                        }
                    } else {
                        self?.customView.profileTitleLabel.snp.updateConstraints {
                            $0.top.equalToSuperview()
                        }
                        self?.customView.nextInformationLabel.snp.updateConstraints {
                            $0.bottom.equalToSuperview().inset(height)
                        }
                    }
                }
                self?.view.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
    }

}
