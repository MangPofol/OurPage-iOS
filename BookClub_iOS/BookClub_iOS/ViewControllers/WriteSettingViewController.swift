//
//  WriteSettingViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/20.
//

import UIKit

import RxSwift

class WriteSettingViewController: UIViewController {

    let customView = WriteSettingView()
    
    var disposeBag = DisposeBag()
    var viewModel: WriteSettingViewModel!
    
    convenience init(postToCreate: PostToCreate) {
        self.init()
        setNavigationBar()
        
        viewModel = WriteSettingViewModel(
            input: (
                placeText: customView.placeTextField.rx.text.orEmpty.asObservable(),
                timeText: customView.timeTextField.rx.text.orEmpty.asObservable(),
                linkTitleText: customView.linkTitleTextField.rx.text.orEmpty.asObservable(),
                linkContentText: customView.linkContentTextField.rx.text.orEmpty.asObservable(),
                postButtonTapped: self.navigationController!.navigationItem.rightBarButtonItem!.rx.tap
            )
        )
        viewModel.postToCreate = postToCreate
        print(#fileID, #function, #line, postToCreate)
    }
    
    override func loadView() {
        self.view = customView
        self.title = "글 설정"
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionLayout.minimumInteritemSpacing = 11.adjustedWidth
        
        customView.scopeCollectionView.setCollectionViewLayout(collectionLayout, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.just(["내 서재", "북클럽 1", "북클럽 2"])
            .debug()
            .bind(to: customView.scopeCollectionView.rx.items(cellIdentifier: ScopeCollectionViewCell.identifier, cellType: ScopeCollectionViewCell.self)) { [weak self] (row, element, cell) in
                if row == 0 {
                    self?.customView.scopeCollectionView.selectItem(at: IndexPath(item: row, section: 0), animated: false, scrollPosition: .top)
                    cell.isSelected = true
                }
                cell.configure(name: element)
            }
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
