//
//  BookclubSettingViewController.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/29.
//

import UIKit

import RxSwift

class BookclubSettingViewController: UIViewController {
    private let customView = BookclubSettingView()
    private var viewModel = BookclubSettingViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = customView
        self.navigationItem.title = "북클럽 설정"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.output.ownBookclub
            .drive(self.customView.createdBookclubTableView.rx.items(cellIdentifier: BookclubSettingTableViewCell.identifier, cellType: BookclubSettingTableViewCell.self)) { (row, element, cell) in
                cell.bookclub = element
            }
            .disposed(by: disposeBag)
        
        self.viewModel.output.joinedBookclub
            .drive(self.customView.joinedBookclubTableView.rx.items(cellIdentifier: BookclubSettingTableViewCell.identifier, cellType: BookclubSettingTableViewCell.self)) { (row, element, cell) in
                cell.bookclub = element
            }
            .disposed(by: disposeBag)
    }
}
