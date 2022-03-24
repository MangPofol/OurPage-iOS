//
//  LoginViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/29.
//

import UIKit

import RxSwift
import RxCocoa
import FFPopup

class LoginViewController: UIViewController {

    var customView = LoginView()
    var viewModel: LoginViewModel!
    var disposeBag = DisposeBag()
    
    private var popup: FFPopup!
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = LoginViewModel(idText: self.customView.idTextField.rx.text.orEmpty.asObservable(), passwordText: self.customView.passwordTextField.rx.text.orEmpty.asObservable(), loginButtonTapped: self.customView.loginButton.rx.tap)
        
        // bind outputs
        customView.signUpButton.rx.tap
            .bind { [weak self] in
                let firstVC = IDPWViewController()
                let nav = UINavigationController(rootViewController: firstVC)
                nav.modalPresentationStyle = .fullScreen
                self?.present(nav, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        viewModel.isLoginConfirmed
            .bind { [weak self] in
                guard let self = self else { return }
                LoadingHUD.hide()
                
                switch $0 {
                case .success:
                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                    if let window = sceneDelegate.window {
                        window.rootViewController = MainTabBarController()
                    }
                case .failed:
                    self.showLoginReulstAlert(title: "로그인 실패", content: "이메일 / 비밀번호를 확인해 주세요.")
                case .deleted:
                    self.showLoginReulstAlert(title: "로그인 실패", content: "탈퇴한 계정입니다.")
                case .error:
                    self.showLoginReulstAlert(title: "에러 발생", content: "잠시 후 다시 시도해 주세요.")
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func showLoginReulstAlert(title: String, content: String) {
        let view = AlertView(title: title, content: content, action: "확인")
        
        let layout = FFPopupLayout(horizontal: .center, vertical: .center)
        self.popup = FFPopup(contentView : view, showType: .shrinkIn, dismissType: .shrinkOut, maskType: .dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)
        self.popup.show(layout: layout)
        
        view.actionButton.rx.tap
            .bind { [weak self] in
                self?.popup.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
