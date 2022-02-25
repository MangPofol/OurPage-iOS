//
//  HomeViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/29.
//

import UIKit

import RxSwift
import RxCocoa
import RxGesture

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
            goalButtonTapped: customView.goalButton.rx.tapGesture().when(.recognized),
            writeButtonTapped: customView.writeButton.rx.tapGesture().when(.recognized)
        )
        
    // bind outputs {
        self.navigationItem.leftBarButtonItem!.rx.tap
            .bind { [weak self] in
                let transition = CATransition()
                transition.duration = 0.3
                transition.type = CATransitionType.moveIn
                transition.subtype = CATransitionSubtype.fromLeft
                self?.view.window!.layer.add(transition, forKey: kCATransition)
                
                let vc = UINavigationController(rootViewController: SettingViewController())
                vc.modalPresentationStyle = .fullScreen
        
                self?.present(vc, animated: false, completion: nil)
                
            }
            .disposed(by: disposeBag)
        
        Constants.CurrentUser
            .debug()
            .compactMap { $0 }
            .withUnretained(self)
            .bind { (owner, user) in
                owner.customView.userNameLabel.text = "\(user.nickname!)님"
                if user.goal != "" {
                    owner.customView.goalButton.titleLabel.text = user.goal
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
        
        viewModel.totalCount
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { (owenr, count) in
                if count == nil {
                    owenr.customView.totalPageLabel.text = "total \(0) pages"
                } else {
                    owenr.customView.totalPageLabel.text = "total \(count!) pages"
                }
            }
            .disposed(by: disposeBag)
    // }
    }

}
