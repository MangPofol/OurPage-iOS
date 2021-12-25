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
    
    convenience init(postToCreate: PostToCreate) {
        self.init()
        self.postToCreate = postToCreate
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
            .bind { [weak self] in
                if $0 != nil {
                    print(#fileID, #function, #line, $0)
                    self?.dismiss(animated: true, completion: nil)
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
