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

class MyProfileViewController: UIViewController {

    let customView = MyProfileView()
    
    private var viewModel: MyProfileViewModel!
    
    var disposeBag = DisposeBag()
    
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
}
