//
//  MyProfileViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/02.
//

import UIKit

import RxSwift
import RxCocoa

class MyProfileViewController: UIViewController {

    let customView = MyProfileView()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = customView
        
        // navigation bar
        self.navigationController?.navigationBar.setDefault()
        self.navigationController?.navigationBar.setBarShadow()
        self.removeBackButtonTitle()
        self.title = "내 정보"
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionLayout.minimumInteritemSpacing = 7
        collectionLayout.minimumLineSpacing = 10
        
        customView.genreCollectionView.setCollectionViewLayout(collectionLayout, animated: false)
        
        Observable.just(["인문", "경제/경영", "소설"])
            .bind(to: customView.genreCollectionView.rx.items) { (collectionView: UICollectionView, row: Int, element: String) -> UICollectionViewCell in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyGenreCollectionViewCell.identifier, for: IndexPath(row: row, section: 0)) as! MyGenreCollectionViewCell
                cell.configure(name: element)
                
                return cell
            }
            .disposed(by: disposeBag)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
