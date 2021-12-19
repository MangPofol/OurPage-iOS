//
//  FirstViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/19.
//

import UIKit
import RxSwift

class FirstViewController: UIViewController {

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .green
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        
        if let window = sceneDelegate.window {
            if let _ = KeyChainController.shared.getAuthorizationString(service: Constants.ServiceString, account: "Token") {
                
                UserServices.getCurrentUserInfo().bind {
                    Constants.CurrentUser.onNext($0)
                    window.rootViewController = MainTabBarController()
                }.disposed(by: disposeBag)
                
            } else {
                window.rootViewController = LoginViewController()
            }
        }
    }

}
