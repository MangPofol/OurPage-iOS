//
//  SignOutViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/22.
//

import UIKit

import RxSwift
import RxCocoa
import FFPopup

final class SignOutViewController: UIViewController {
    private let customView = SignOutView()
    private let disposeBag = DisposeBag()
    private var popup: FFPopup!
    
    override func loadView() {
        self.view = customView
        self.navigationController?.navigationBar.removeBarShadow()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PostServices.getTotalCount()
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in
                guard let self = self else { return }
                self.customView.titleLabel.text = "Our Page를 떠나면\n\($0)개 기록들이 사라져요."
            }
            .disposed(by: disposeBag)
        
        self.customView.signOutButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                self.showSignOutAlert()
            }
            .disposed(by: disposeBag)
    }
    
    private func showSignOutAlert() {
        let view = DeleteAlertView(title: "회원 탈퇴", content: "정말 탈퇴하시겠습니까?", action: "탈퇴")
        self.popup = FFPopup(contentView: view, showType: .bounceIn, dismissType: .shrinkOut, maskType: .dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)
        let layout = FFPopupLayout(horizontal: .center, vertical: .center)
        
        self.popup.show(layout: layout)
        
        view.actionButton
            .rx.tap
            .do { _ in
                LoadingHUD.show()
            }
            .flatMap {
                Constants.CurrentUser
            }
            .flatMap { user -> Observable<Bool> in
                guard let user = user else {
                    return Observable.just(false)
                }
                return UserServices.changeUserDormant(id: user.userId)
            }
            .bind {
                if $0 {
                    guard let window = UIApplication.shared.windows.first else {
                        return
                    }
                    
                    window.rootViewController = LoginViewController()
                    
                    let options: UIView.AnimationOptions = .transitionCrossDissolve
                    let duration: TimeInterval = 0.3
                    UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
                    { completed in
                        LoadingHUD.hide()
                        KeyChainController.shared.delete(Constants.ServiceString, account: "Token")
                    })
                }
                LoadingHUD.hide()
            }
            .disposed(by: disposeBag)
    }
}
