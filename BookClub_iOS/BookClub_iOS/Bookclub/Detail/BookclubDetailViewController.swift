//
//  BookclubDetailViewController.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/04/06.
//

import UIKit

import RxSwift
import RxCocoa

class BookclubDetailViewController: UIViewController {
    private let customView = BookclubDetailView()
    private var bookclubId: Int? = nil
    var viewModel: BookclubDetailViewModel!
    
    private let disposeBag = DisposeBag()
    
    convenience init(bookclub: Bookclub) {
        self.init()
        self.bookclubId = bookclub.id
        self.viewModel = BookclubDetailViewModel(bookclub: bookclub)
    }
    
    override func loadView() {
        self.view = UIScrollView()
        self.view.backgroundColor = .white
        self.view.addSubview(customView)
        self.customView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        self.setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setBarMainColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadingHUD.hide()
        
        self.customView.bookclubBooksView.bookCollectionView.rx.itemSelected.map { $0.row }
            .bind(to: self.viewModel.input!.selectedBookIndex)
            .disposed(by: disposeBag)
        
        self.viewModel.output.title
            .drive(self.customView.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.description
            .drive(self.customView.descriptionLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.member
            .map { "total  \($0) members" }
            .drive(self.customView.membersLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.level
            .map { "LV.\($0)" }
            .drive(self.customView.levelLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.viewModel.output.level
            .drive { [weak self] in
                self?.customView.levelCharacterImageView.image = UIImage(named: "BookclubLevel\($0)")
            }
            .disposed(by: disposeBag)
        
        self.viewModel.output.totalPages
            .map { "\($0) pages" }
            .drive(self.customView.pagesLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.viewModel.output.isWelcomeViewHidden
            .drive(self.customView.bookclubWelcomeView.rx.isHidden)
            .disposed(by: disposeBag)
        
        self.viewModel.output.clubBooks
            .do { [weak self] in
                self?.customView.bookclubBooksView.emptyLabel.isHidden = ($0.count != 0)
            }
            .drive(self.customView.bookclubBooksView.bookCollectionView.rx.items(cellIdentifier: BookclubBooksCell.identifier, cellType: BookclubBooksCell.self)) { (row, element, cell) in
                cell.bookclubBook = element
            }
            .disposed(by: disposeBag)
        
        self.viewModel.output.openBookDetail
            .compactMap { $0 }
            .drive { [weak self] in
                let vc = BookclubBookViewController(bookclubBook: $0, bookclubId: self?.bookclubId)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        self.viewModel.output.trendingMemos
            .do { [weak self] in
                self?.customView.bookclubTrendingMemoView.emptyLabel.isHidden = ($0.count != 0)
            }
            .drive(self.customView.bookclubTrendingMemoView.trendingMemoCollectionView.rx.items(cellIdentifier: BookclubTrendingMemoCell.identifier, cellType: BookclubTrendingMemoCell.self)) { (row, element, cell) in
                cell.clubPost = element
            }
            .disposed(by: disposeBag)
        
        // CollectionView 선택
        self.customView.bookclubTrendingMemoView.trendingMemoCollectionView.rx.modelSelected(ClubPost.self)
            .bind { [weak self] in
                let vc = BookclubPostViewController()
                vc.clubPost = $0
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.removeBarShadow()
        self.setBarMainColor()
        self.removeBackButtonTitle()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .updownArrowImage, style: .plain, target: nil, action: nil)
    }
}
