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
import YPImagePicker

class WriteViewController: UIViewController {
    let disposeBag = DisposeBag()
    let customView = WriteView()
    var viewModel: WriteViewModel!
    
    var selectedBook: Book?
    
    var uploadedImages: [UIImage] = []
    
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
                viewModel.selectedBook.onNext(self.selectedBook)
            }
        } else {
            customView.bookSelectionButton.button.setTitle("기록할 책을 선택하세요.", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.uploadedImageCollection.delegate = self
        
        viewModel = WriteViewModel(
            input: (
                bookSelectionButtonTapped: customView.bookSelectionButton.button.rx.tap.asSignal(),
                isMemoOn: customView.memoButton.isOnRx.asObservable(),
                isTopicOn: customView.topicButton.isOnRx.asObservable(),
                imageUploadButtonTapped: customView.imageUploadButton.rx.tap.asSignal(),
                writeButtonTapped: self.navigationItem.rightBarButtonItem!.rx.tap.asSignal(),
                titleText: customView.titleTextField.rx.text.map { $0 ?? "" },
                contentText: customView.contentTextView.rx.text.map { $0 ?? "" }
            )
        )
        
        customView.uploadedImageCollection.rx.itemSelected
            .bind {
                let vc = PagesViewController()
                vc.chooseIdx = $0.row
                vc.pageImages = self.viewModel.uploadedImages.value
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        viewModel.isWriting
            .filter { $0 == true }
            .bind { _ in
                print("Writing...")
            }
            .disposed(by: disposeBag)
        
        viewModel.uploadedImages
            .debug()
            .do {
                self.customView.imageUploadButton.setTitle("\($0.count)/4", for: .normal)
            }
            .bind(to:
                    self.customView.uploadedImageCollection
                    .rx
                    .items(cellIdentifier: UploadedImageCollectionViewCell.identifier, cellType: UploadedImageCollectionViewCell.self)) { (row, element, cell) in
                cell.imageView.image = element
                cell.deleteButton.rx.tap.bind {
                    var images = self.viewModel.uploadedImages.value
                    images.remove(at: row)
                    self.viewModel.uploadedImages.accept(images)
                    
                }.disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        
        viewModel.bookSelection
            .observeOn(MainScheduler.instance)
            .bind {
                if $0 {
                    self.navigationController?.pushViewController(BookSelectViewController(), animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.isMemo
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .bind {
                print("isMemo", $0)
            }
            .disposed(by: disposeBag)
        
        viewModel.isTopic
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .bind {
                print("isTopic", $0)
            }
            .disposed(by: disposeBag)
        
        viewModel.imageUploading
            .filter { $0 == true }
            .bind { _ in
                var config = YPImagePickerConfiguration()
                // [Edit configuration here ...]
                // Build a picker with y    our configuration
                config.library.maxNumberOfItems = 4
                config.library.defaultMultipleSelection = true
                config.onlySquareImagesFromCamera = false
                config.library.isSquareByDefault = false
                config.showsPhotoFilters = false
                config.startOnScreen = YPPickerScreen.library
                config.library.skipSelectionsGallery = true
                config.library.preselectedItems = nil
    
                YPImagePickerConfiguration.shared = config
                
                // And then use the default configuration like so:
                let picker = YPImagePicker()
                
                picker.didFinishPicking { [unowned picker] items, cancelled in
                    var photos = [UIImage]()
                    for item in items {
                        switch item {
                        case .photo(let photo):
                            photos.append(photo.image)
                        case .video(let video):
                            print(video)
                        }
                    }
                    self.viewModel.uploadedImages.accept(self.viewModel.uploadedImages.value + photos)
                    picker.dismiss(animated: true, completion: nil)
                }
                
                self.present(picker, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private Funcs
    private func setNavigationBar() {
        self.setDefaultConfiguration()
        // navigation bar button
        self.navigationItem.leftBarButtonItem!
            .rx.tap
            .bind {
                let menu = SideMenuNavigationController(rootViewController: SideMenuViewController())
                menu.leftSide = true
                menu.presentationStyle = .menuSlideIn
                menu.menuWidth = CGFloat(Constants.getAdjustedWidth(280.0))
                menu.presentationStyle.presentingEndAlpha = 0.5
                
                self.present(menu, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .uploadIcon, style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = .mainColor
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFont.defaultFont(size: .medium, bold: true)], for: .normal)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFont.defaultFont(size: .medium, bold: true)], for: .selected)
        
        
    }
    
    private func setTextViewPlaceholder() {
        customView.contentTextView.rx.didBeginEditing
            .subscribe(onNext: { [self] in
                        if(customView.contentTextView.text == "내용을 입력하세요." ){
                            customView.contentTextView.text = nil
                            customView.contentTextView.textColor = .black
                            
                        }}).disposed(by: disposeBag)
        
        customView.contentTextView.rx.didEndEditing
            .subscribe(onNext: { [self] in
                        if(customView.contentTextView.text == nil || customView.contentTextView.text == ""){
                            customView.contentTextView.text = "내용을 입력하세요."
                            customView.contentTextView.textColor = .grayB0
                            
                        }}).disposed(by: disposeBag)
    }
}

extension WriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.getAdjustedHeight(40.0), height: Constants.getAdjustedHeight(40.0))
    }
}
