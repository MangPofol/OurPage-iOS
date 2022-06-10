//
//  BookclubInfoViewController.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/05/15.
//

import UIKit
import RxSwift

class BookclubInfoViewController: UIViewController {
    private let customView = BookclubInfoView()
    
    var viewModel: BookclubInfoViewModel!
    
    private var disposeBag = DisposeBag()
    
    convenience init(bookclubId: Int?) {
        self.init()
        self.viewModel = BookclubInfoViewModel(input: nil)
        viewModel.bookclubId = bookclubId
    }
    
    override func loadView() {
        self.view = customView
        
        self.removeBackButtonTitle()
        self.navigationController?.navigationBar.setBarShadow()
        self.title = "클럽 정보"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setBarWhite()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.output.bookclubInfo
            .drive { [weak self] in
                guard let self = self, let bookclubInfo = $0 else { return }
                
                self.customView.levelImageView.image = UIImage(named: "BookclubLevel\(bookclubInfo.clubMetadata.level)")
                self.customView.levelLabel.text = "LV.\(bookclubInfo.clubMetadata.level)"
                self.customView.memberCountLabel.text = "멤버 : \(bookclubInfo.totalUser) /  10"
            }
            .disposed(by: disposeBag)
    }
}
