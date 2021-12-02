//
//  HomeViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/29.
//

import UIKit

import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    let customView = HomeView()
    
    var viewModel: HomeViewModel!
    var disposeBag = DisposeBag()
    
    var checkListOpened = false
    
    override func loadView() {
        self.view = customView
        self.navigationController?.navigationBar.setDefault()
        self.setDefaultConfiguration()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeViewModel(
            checkListButtonTapped: customView.checkListHeader.openButton.rx.tap,
            myProfileButtonTapped: customView.myProfileButton.rx.tap
        )
        
    // bind outputs {
        viewModel.checkListToggle
            .withUnretained(self)
            .do {(owner, _) in owner.checkListOpened.toggle()}
            .bind { (owner, _) in
                if owner.checkListOpened {
                    owner.customView.checkListHeader.topRoundCorner(radius: 8.adjustedHeight)
                }
                owner.customView.checkListTableView.snp.updateConstraints {
                    $0.height.equalTo(owner.checkListOpened ? 188.adjustedHeight : 0)
                }
                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                    owner.view.layoutIfNeeded()
                }, completion: { _ in
                    print(#fileID, #function, #line, "")
                    if !owner.checkListOpened {
                        owner.customView.checkListHeader.setCornerRadius(radius: 8.adjustedHeight)
                    }
                    UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                        owner.view.layoutIfNeeded()
                    })
                })
            }
            .disposed(by: disposeBag)
        
        viewModel.openMyProfileView
            .withUnretained(self)
            .bind { (owner, _) in
                let vc = MyProfileViewController()
                let navi = UINavigationController(rootViewController: vc)
                navi.setDefaultConfiguration()
                navi.modalPresentationStyle = .fullScreen
                owner.present(navi, animated: true)
            }
            .disposed(by: disposeBag)
    // }
    }

}


// 6252 3852 0730
