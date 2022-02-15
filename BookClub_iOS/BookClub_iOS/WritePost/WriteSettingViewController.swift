//
//  WriteSettingViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/20.
//

import UIKit

import RxSwift
import RxCocoa

class WriteSettingViewController: UIViewController {

    let customView = WriteSettingView()
    
    var disposeBag = DisposeBag()
    var viewModel: WriteSettingViewModel!
    
    var postToCreate: PostToCreate!
    var bookModel: BookModel!
    
    convenience init(postToCreate: PostToCreate, bookModel: BookModel) {
        self.init()
        self.postToCreate = postToCreate
        self.bookModel = bookModel
    }
    
    override func loadView() {
        self.view = customView
        self.title = "글 설정"
        
        let collectionLayout = CollectionViewLeftAlignFlowLayout()
        collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionLayout.cellSpacing = 11.adjustedWidth
        
        customView.scopeCollectionView.setCollectionViewLayout(collectionLayout, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
        viewModel = WriteSettingViewModel(
            input: (
                placeText: customView.placeTextField.rx.text.orEmpty.asObservable(),
                timeText: customView.timeTextField.rx.text.orEmpty.asObservable(),
                linkTitleText: customView.linkTitleTextField.rx.text.orEmpty.asObservable(),
                linkContentText: customView.linkContentTextField.rx.text.orEmpty.asObservable(),
                postButtonTapped: self.navigationItem.rightBarButtonItem!.rx.tap,
                postToCreate: postToCreate
            )
        )
        
        viewModel.clubs
            .observe(on: MainScheduler.instance)
            .bind(to: customView.scopeCollectionView.rx.items(cellIdentifier: ScopeCollectionViewCell.identifier, cellType: ScopeCollectionViewCell.self)) { [weak self] (row, element, cell) in
                if row == 0 {
                    self?.customView.scopeCollectionView.selectItem(at: IndexPath(item: row, section: 0), animated: false, scrollPosition: .top)
                    cell.isSelected = true
                }
                cell.configure(name: element.name)
            }
            .disposed(by: disposeBag)
        
        viewModel.postSuccess
            .observe(on: MainScheduler.instance)
            .bind { [weak self] post in
                if post != nil {
                    let vc = PostViewController(post_: post, book_: self?.bookModel)
                    self?.navigationController?.viewControllers.insert(vc, at: 1)
                    self?.navigationController?.popToViewController(vc, animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        customView.scopeCollectionView
            .rx.modelSelected(Club.self)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.selectedClub.onNext($0)
            })
            .disposed(by: disposeBag)
        
        customView.scopeCollectionView
            .rx.modelDeselected(Club.self)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.deselectedClub.onNext($0)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private Funcs
    private func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = .mainColor
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFont.defaultFont(size: 14, boldLevel: .bold)], for: .normal)
        self.navigationController?.navigationBar.setShadow(opacity: 0.5, color: .lightGray)
    }
}
