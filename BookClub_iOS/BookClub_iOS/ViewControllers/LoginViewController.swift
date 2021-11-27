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
            .bind {
                let firstVC = SignUpViewController()
                let nav = UINavigationController(rootViewController: firstVC)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        viewModel.isLoginConfirmed
            .bind {
                if $0 {
                    let vc = MainTabBarController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
            .disposed(by: disposeBag)
    }
}