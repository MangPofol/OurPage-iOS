//
//  MyProfileViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/02.
//

import UIKit

import RxSwift
import RxCocoa
import Kingfisher
import FFPopup
import ZLPhotoBrowser

class MyProfileViewController: UIViewController {

    let customView = MyProfileView()
    
    private var viewModel: MyProfileViewModel!
    private var popup: FFPopup!
    
    private var disposeBag = DisposeBag()
    private var alertDisposeBag = DisposeBag()
    
    override func loadView() {
        self.view = customView
        
        // navigation bar
        self.navigationController?.navigationBar.setDefault()
        self.navigationController?.navigationBar.setBarShadow()
        self.removeBackButtonTitle()
        self.title = "내 정보"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePhoto()
        self.viewModel = MyProfileViewModel()
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.estimatedItemSize = CGSize(width: 60.adjustedHeight, height: 25.adjustedHeight)
        collectionLayout.minimumInteritemSpacing = 3.adjustedHeight
        collectionLayout.minimumLineSpacing = 3.adjustedHeight
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.sectionInset = .zero
        
        customView.genreCollectionView.setCollectionViewLayout(collectionLayout, animated: false)
        
        self.viewModel.myGenre
            .drive(customView.genreCollectionView.rx.items) { (collectionView: UICollectionView, row: Int, element: String) -> UICollectionViewCell in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyGenreCollectionViewCell.identifier, for: IndexPath(row: row, section: 0)) as! MyGenreCollectionViewCell
                cell.configure(name: element)
                
                return cell
            }
            .disposed(by: disposeBag)
        
        self.viewModel.bookCount
            .drive { [weak self] in
                guard let self = self else { return }
                self.customView.readBookTextField.text  = "읽은 책 \($0) books"
            }
            .disposed(by: disposeBag)
        
        self.viewModel.recordCount
            .drive { [weak self] in
                guard let self = self else { return }
                self.customView.recordTextField.text = "총 기록 \($0) pages"
            }
            .disposed(by: disposeBag)
        
        self.viewModel.uploadedImageUrl
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in
                guard let self = self else { return }
                self.customView.profileImageView.kf.setImage(with: URL(string: $0), options: [.transition(.fade(0.2))])
            }
            .disposed(by: disposeBag)
        
        self.viewModel.profileImageUpdated
            .observe(on: MainScheduler.instance)
            .bind {
                guard $0 == true else { return }
                LoadingHUD.hide()
            }
            .disposed(by: disposeBag)
        
        self.viewModel.introduceUpdated
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in
                self?.customView.introduceLabel.text = $0
                LoadingHUD.hide()
            }
            .disposed(by: disposeBag)
        
        Constants.CurrentUser
            .compactMap { $0 }
            .withUnretained(self)
            .bind { (owner, user) in
                owner.customView.nicknameLabel.text = user.nickname
                owner.customView.idLabel.text = user.email
                owner.customView.introduceLabel.text = user.introduce
                owner.customView.profileImageView.kf.setImage(
                    with: URL(string: user.profileImgLocation ?? ""),
                    placeholder: UIImage.DefaultProfileImage)
            }
            .disposed(by: disposeBag)
        
        customView.profileImageSettingButton.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in
                self?.showPhotoAlert()
            }
            .disposed(by: disposeBag)
        
        customView.introduceLabel.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.showIntroduceUpdateAlert(introduce: self.customView.introduceLabel.text ?? "")
            }
            .disposed(by: disposeBag)
        
        customView.tasteSettingButton
            .rx.tap
            .bind { [weak self] in
                self?.navigationController?.pushViewController(MyTasteViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        customView.readingStyleButton
            .rx.tap
            .bind { [weak self] in
                self?.navigationController?.pushViewController(MyTasteViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    
        customView.goalSettingButton
            .rx.tap
            .bind { [weak self] in
                self?.navigationController?.pushViewController(ModifyGoalViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func showPhotoAlert() {
        let view = PhotoAlertView()
        let layout = FFPopupLayout(horizontal: .center, vertical: .bottom)
        
        popup = FFPopup(contentView: view, showType: .slideInFromBottom, dismissType: .slideOutToBottom, maskType: .dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)
        
        view.takePictureOptionView.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                let camera = ZLCustomCamera()
                camera.takeDoneBlock = { (image, videoUrl) in
                    LoadingHUD.show()
                    self.popup.dismiss(animated: false)
                    self.viewModel.updatingProfileImage.accept(image)
                }
                camera.cancelBlock = {
                    self.popup.dismiss(animated: false)
                }
                self.showDetailViewController(camera, sender: nil)
            }
            .disposed(by: disposeBag)
        
        view.galleryOptionView.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                let ps = ZLPhotoPreviewSheet()
                
                ps.selectImageBlock = { (images, assets, isOriginal) in
                    LoadingHUD.show()
                    self.popup.dismiss(animated: false)
                    self.viewModel.updatingProfileImage.accept(images.first)
                }
                ps.cancelBlock = {
                    self.popup.dismiss(animated: false)
                }
                ps.showPhotoLibrary(sender: self)
            }
            .disposed(by: disposeBag)
        
        popup.show(layout: layout)
    }
    
    private func showIntroduceUpdateAlert(introduce: String) {
        self.alertDisposeBag = DisposeBag()
        let view = IntroduceUpdateAlertView(introduce: introduce)
        let layout = FFPopupLayout(horizontal: .center, vertical: .aboveCenter)
        
        popup = FFPopup(contentView: view, showType: .bounceIn, dismissType: .shrinkOut, maskType: .dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)
        popup.show(layout: layout)
        
        view.cancelButton.rx.tap
            .bind { [weak self] in
                self?.popup.dismiss(animated: true)
            }
            .disposed(by: alertDisposeBag)
        
        view.finishButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.updatingIntroduce.accept(view.introduceTextView.text)
                self?.popup.dismiss(animated: false)
                LoadingHUD.show()
            }
            .disposed(by: alertDisposeBag)
        
        view.introduceTextView.rx.setDelegate(self).disposed(by: alertDisposeBag)
    }
    
    private func configurePhoto() {
        ZLPhotoConfiguration.default().allowRecordVideo = false
        ZLPhotoConfiguration.default().allowSelectGif = false
        ZLPhotoConfiguration.default().maxSelectCount = 1
        ZLPhotoConfiguration.default().allowEditImage = true
        ZLPhotoConfiguration.default().editAfterSelectThumbnailImage = true
        ZLPhotoConfiguration.default().allowSelectOriginal = false
        ZLPhotoConfiguration.default().allowSelectVideo = false
        
        let editConfiguration = ZLEditImageConfiguration()
        editConfiguration.clipRatios = [.wh1x1]
        editConfiguration.tools  = [.clip]
        ZLPhotoConfiguration.default().editImageConfiguration = editConfiguration
        
        let cameraConfig = ZLPhotoConfiguration.default().cameraConfiguration
        cameraConfig.sessionPreset = .hd1920x1080
        cameraConfig.focusMode = .continuousAutoFocus
        cameraConfig.exposureMode = .continuousAutoExposure
        cameraConfig.flashMode = .off
        cameraConfig.videoExportType = .mov
    }
}

extension MyProfileViewController: UITextViewDelegate {
    private func textLimit(existingText: String?, newText: String, limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return self.textLimit(existingText: textView.text,
                              newText: text,
                              limit: 20)
    }
}
