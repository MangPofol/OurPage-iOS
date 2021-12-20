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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.removeBarShadow()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeViewModel(
            checkListButtonTapped: customView.checkListHeader.openButton.rx.tap,
            myProfileButtonTapped: customView.myProfileButton.rx.tap,
            goalButtonTapped: customView.goalButton.rx.tap,
            writeButtonTapped: customView.writeButton.writeButton.rx.tap
        )
        
    // bind outputs {
        Constants.CurrentUser
            .debug()
            .compactMap { $0 }
            .withUnretained(self)
            .bind { (owner, user) in
                owner.customView.userNameLabel.text = "\(user.nickname)님"
                if user.goal != "" {
                    owner.customView.goalButton.setTitle(user.goal, for: .normal)
                }
                
            }
            .disposed(by: disposeBag)
        
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
                    if owner.checkListOpened {
                        owner.customView.checkListHeader.openButton.rotateWithoutAnimation(degree: Double.pi)
                    } else {
                        owner.customView.checkListHeader.openButton.transform = CGAffineTransform.identity
                    }
                    
                }, completion: { _ in
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
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.openModifyGoalView
            .withUnretained(self)
            .bind { (owner, _) in
                owner.navigationController?.pushViewController(ModifyGoalViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.openWriteView
            .withUnretained(self)
            .bind { (owner, _) in
                owner.navigationController?.pushViewController(WriteViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    // }
    }

}
