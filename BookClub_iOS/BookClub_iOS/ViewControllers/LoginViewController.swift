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
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customView.signUpButton.rx.tap
            .bind {
                let firstVC = SignUpViewController()
                let nav = UINavigationController(rootViewController: firstVC)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
}
