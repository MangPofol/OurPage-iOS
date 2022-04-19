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
    var viewModel: BookclubDetailViewModel!
    
    private let disposeBag = DisposeBag()
    
    convenience init(bookclub: Club) {
        self.init()
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
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadingHUD.hide()
        
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
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.removeBarShadow()
        self.setBarMainColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .updownArrowImage, style: .plain, target: nil, action: nil)
    }
}
