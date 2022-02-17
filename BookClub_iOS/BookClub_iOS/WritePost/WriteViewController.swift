//
//  WriteViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/10.
//

import UIKit

import RxSwift
import RxCocoa
import SideMenu
import ZLPhotoBrowser
import FFPopup

class WriteViewController: UIViewController {
    let disposeBag = DisposeBag()
    let customView = WriteView()
    var viewModel: WriteViewModel!
    
    var selectedBook: Book?
    
    override func loadView() {
        self.view = customView
        setNavigationBar()
        // contentTextView placeholder
        setTextViewPlaceholder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if selectedBook != nil {
            customView.bookSelectionButton.button.setTitle(selectedBook!.bookModel.name, for: .normal)
            if viewModel != nil {
                print(#fileID, #function, #line, self.selectedBook)
                viewModel.selectedBook.onNext(self.selectedBook)
            }
        } else {
            customView.bookSelectionButton.button.setTitle("기록할 책을 선택하세요.", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.uploadedImageCollection.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel = WriteViewModel(
            input: (
                bookSelectionButtonTapped: customView.bookSelectionButton.button.rx.tap.asSignal(),
                imageUploadButtonTapped: customView.imageUploadButton.rx.tap.asSignal(),
                nextButtonTapped: self.navigationItem.rightBarButtonItem!.rx.tap.asSignal(),
                titleText: customView.titleTextField.rx.text.orEmpty.asObservable(),
                contentText: customView.contentTextView.rx.text.orEmpty.asObservable()
            )
        )
        
//        customView.uploadedImageCollection.rx.itemSelected
//            .withUnretained(self)
//            .bind { (owner, val) in
//                let vc = PagesViewController()
//                vc.chooseIdx = val.row
//                vc.pageImages = owner.viewModel.uploadingImages.value
//                vc.modalPresentationStyle = .fullScreen
//                owner.present(vc, animated: true, completion: nil)
//            }
//            .disposed(by: disposeBag)
        
        viewModel.ableToNext
            .observe(on: MainScheduler.instance)
            .bind {
                if $0 {
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    self.navigationItem.rightBarButtonItem?.tintColor = .mainColor
                } else {
                    self.navigationItem.rightBarButtonItem?.isEnabled = false
                    self.navigationItem.rightBarButtonItem?.tintColor = .lightGray
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.openPostSetting
            .compactMap { $0 }
            .withUnretained(self)
            .bind { (owner, post) in
                let vc = WriteSettingViewController(postToCreate: post, bookModel: owner.selectedBook!.bookModel)
                
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.uploadedImagesURLs
            .observe(on: MainScheduler.instance)
            .do { [weak self] in
                self?.customView.imageUploadButton.setTitle("\($0.count)/4", for: .normal)
            }
            .bind(to:
                    customView.uploadedImageCollection
                    .rx
                    .items(cellIdentifier: UploadedImageCollectionViewCell.identifier, cellType: UploadedImageCollectionViewCell.self)) { [weak self] (row, element, cell) in
                cell.imageUrlString = element
                cell.vcViewModel = self?.viewModel
                cell.index = row
            }
            .disposed(by: disposeBag)
        
        
        viewModel.bookSelection
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in
                if $0 {
                    self?.navigationController?.pushViewController(BookSelectViewController(), animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.imageUploading
            .filter { $0 == true }
            .bind { [weak self] _ in
                guard let self = self else { return }
                
                if self.viewModel.uploadedImagesURLs.value.count >= 4 {
                    self.showImageLimitAlert()
                    return
                }
                
                let cameraConfig = ZLPhotoConfiguration.default().cameraConfiguration
                ZLPhotoConfiguration.default().allowRecordVideo = false
                ZLPhotoConfiguration.default().allowSelectGif = false
                ZLPhotoConfiguration.default().maxSelectCount = 4 - self.viewModel.uploadedImagesURLs.value.count
                ZLPhotoConfiguration.default().editImageClipRatios = [.wh1x1]
                ZLPhotoConfiguration.default().allowEditImage = true
                ZLPhotoConfiguration.default().editAfterSelectThumbnailImage = true
                ZLPhotoConfiguration.default().editImageTools = [.clip]
                ZLPhotoConfiguration.default().allowSelectOriginal = false
//                    ZLPhotoConfiguration.default().themeColorDeploy = ZLPhotoThemeColorDeploy().
                
                // All properties of the camera configuration have default value
                cameraConfig.sessionPreset = .hd1920x1080
                cameraConfig.focusMode = .continuousAutoFocus
                cameraConfig.exposureMode = .continuousAutoExposure
                cameraConfig.flashMode = .off
                cameraConfig.videoExportType = .mov
                
                let ps = ZLPhotoPreviewSheet()
                
                ps.selectImageBlock = { [weak self] (images, assets, isOriginal) in
                    self!.viewModel.uploadingImages.onNext(images)
                }
                ps.showPhotoLibrary(sender: self)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private Funcs
    private func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "다음", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = .mainColor
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFont.defaultFont(size: 14, boldLevel: .bold)], for: .normal)
        self.removeBackButtonTitle()
    }
    
    private func setTextViewPlaceholder() {
        customView.contentTextView.rx.didBeginEditing
            .subscribe(onNext: { [weak self] in
                if(self?.customView.contentTextView.text == "내용을 입력하세요." ){
                    self?.customView.contentTextView.text = nil
                    self?.customView.contentTextView.textColor = .black
                            
                        }}).disposed(by: disposeBag)
        
        customView.contentTextView.rx.didEndEditing
            .subscribe(onNext: { [weak self] in
                if(self?.customView.contentTextView.text == nil || self?.customView.contentTextView.text == ""){
                    self?.customView.contentTextView.text = "내용을 입력하세요."
                    self?.customView.contentTextView.textColor = .grayB0
                            
                        }}).disposed(by: disposeBag)
    }
    
    private func showImageLimitAlert() {
        let view = AlertView(title: "알림", content: "이미지는 최대 4장까지 첨부할 수 있습니다", action: "확인")
        let layout = FFPopupLayout(horizontal: .center, vertical: .center)
        let popup = FFPopup(contentView: view, showType: .bounceIn, dismissType: .shrinkOut, maskType: .dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)
        
        view.actionButton.rx.tap
            .bind { _ in
                popup.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        popup.show(layout: layout)
    }
}

extension WriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.getAdjustedHeight(40.0), height: Constants.getAdjustedHeight(40.0))
    }
}
