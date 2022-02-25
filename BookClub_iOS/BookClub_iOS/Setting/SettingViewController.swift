//
//  SettingViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/19.
//

import UIKit

import RxSwift
import RxCocoa
import FFPopup

final class SettingViewController: UIViewController {
    private let customView = SettingView()
    private let disposeBag = DisposeBag()
    
    private var popup: FFPopup!
    
    override func loadView() {
        self.view = customView
        
        // navigation bar
        self.navigationController?.navigationBar.setDefault()
        self.navigationController?.navigationBar.setBarShadow()
        self.removeBackButtonTitle()
        self.title = "설정"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: .leftArrowImage.resize(to: CGSize(width: 6.34, height: 11).resized(basedOn: .height)), style: .plain, target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem?
            .rx.tap
            .bind { [weak self] in
                let transition: CATransition = CATransition()
                transition.duration = 0.3
                transition.type = CATransitionType.moveIn
                transition.subtype = CATransitionSubtype.fromRight
                self?.view.window!.layer.add(transition, forKey: nil)
                self?.dismiss(animated: false, completion: nil)
            }
            .disposed(by: disposeBag)
        
        // button bind {
        // 비밀번호 변경
        self.customView.passwordChangeButton.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.navigationController?.pushViewController(PasswordChangeViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        // 로그아웃
        self.customView.logoutButton.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in
                self?.showLogoutAlert()
            }
            .disposed(by: disposeBag)
        
        // 계정탈퇴
        self.customView.signOutButton.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.navigationController?.pushViewController(SignOutViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        // 1:1 문의
        self.customView.askButton.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.navigationController?.pushViewController(AskViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        // 이용약관
        self.customView.ruleButton.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.navigationController?.pushViewController(RuleViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        // }
    }
    
    private func showLogoutAlert() {
        let view = DeleteAlertView(title: "로그아웃", content: "로그아웃 하시겠습니까?", action: "로그아웃")
        
        let layout = FFPopupLayout(horizontal: .center, vertical: .center)
        self.popup = FFPopup(contentView : view, showType: .bounceIn, dismissType: .shrinkOut, maskType: .dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)
        self.popup.show(layout: layout)
        
        view.actionButton.rx.tap
            .do { _ in LoadingHUD.show() }
            .bind {
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
            .disposed(by: disposeBag)
        
        view.cancelButton.rx.tap
            .bind { [weak self] in
                self?.popup.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
