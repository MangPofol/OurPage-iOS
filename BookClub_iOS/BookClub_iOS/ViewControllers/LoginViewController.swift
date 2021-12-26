//
//  LoginViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/29.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    var customView = LoginView()
    var viewModel: LoginViewModel!
    var disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = LoginViewModel(idText: self.customView.idTextField.rx.text.orEmpty.asObservable(), passwordText: self.customView.passwordTextField.rx.text.orEmpty.asObservable(), loginButtonTapped: self.customView.loginButton.rx.tap)
        
        // bind outputs
        customView.signUpButton.rx.tap
            .bind { [weak self] in
                let firstVC = SignUpViewController()
                let nav = UINavigationController(rootViewController: firstVC)
                nav.modalPresentationStyle = .fullScreen
                self?.present(nav, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        viewModel.isLoginConfirmed
            .bind {
                LoadingHUD.hide()
                if $0 {
                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                    if let window = sceneDelegate.window {
                        window.rootViewController = MainTabBarController()
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
