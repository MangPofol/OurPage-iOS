//
//  BookclubBookViewController.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/05/01.
//

import UIKit
import RxSwift

final class BookclubBookViewController: UIViewController {
    let customView = BookView()
    private var bookclubBook : BookclubBook?
    private var bookclubId: Int? = nil
    private var viewModel: BookclubBookViewModel!
    private var disposeBag = DisposeBag()
    
    convenience init(bookclubBook: BookclubBook?, bookclubId: Int?) {
        self.init()
        
        if let bookclubBook = bookclubBook, let bookclubId = bookclubId {
            self.bookclubBook = bookclubBook
            self.bookclubId = bookclubId
            self.viewModel = BookclubBookViewModel(bookclubBook: bookclubBook, bookclubId: bookclubId)
        }
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.addSubview(customView)
        customView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        self.removeBackButtonTitle()
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.defaultFont(size: 18, boldLevel: .extraBold)]
        
        customView.makeView()
        
        customView.bookTitleLabel.text = self.bookclubBook?.bookName ?? ""
        customView.readingButton.isOn = (self.bookclubBook?.category == "NOW")
        customView.finishButton.isOn = (self.bookclubBook?.category == "AFTER")
        customView.memoTitleLabel.text = "CLUB MEMO LIST"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBarWhite()
//        self.viewModel.refreshPosts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.output.searchedInfo
            .compactMap { $0 }
            .drive { [weak self] info in
                self?.customView.bookImageView.kf.setImage(with: URL(string: info.thumbnail), placeholder: UIImage.DefaultBookImage)
            }
            .disposed(by: disposeBag)
        
        
        self.viewModel.output.posts
            .drive(customView.memoTableView.rx.items(cellIdentifier: MemoTableViewCell.identifier, cellType: MemoTableViewCell.self)) { (row, element, cell) in
                cell.post = element
            }
            .disposed(by: disposeBag)
    }
}
