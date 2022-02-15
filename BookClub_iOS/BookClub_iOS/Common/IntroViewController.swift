//
//  IntroViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/11.
//

import UIKit

import RxSwift
import RxCocoa
import Gifu

class IntroViewController: UIViewController {

    private let loadingImageView = GIFImageView()
    private let pageImageView = UIImageView()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = UIView().then { $0.backgroundColor = .white }
        
        self.view.addSubview(loadingImageView)
        self.view.addSubview(pageImageView)
        
        loadingImageView.then {
            $0.prepareForAnimation(withGIFNamed: "LoadingImage")
            $0.contentMode = .scaleAspectFit
            $0.startAnimatingGIF()
        }.snp.makeConstraints {
            $0.width.height.equalTo(126.0.adjustedHeight)
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(60.adjustedHeight)
        }
        
        pageImageView.then {
            $0.image = UIImage(named: "Page")
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.left.equalTo(loadingImageView.snp.right)
            $0.top.equalTo(loadingImageView.snp.centerY)
            $0.width.equalTo(122.0.adjustedHeight)
            $0.height.equalTo(39.0.adjustedHeight)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 자동로그인 검사
        UserServices.getCurrentUserInfo()
            .map { user -> Bool in
                if user == nil {
                    return false
                } else {
                    Constants.CurrentUser.onNext(user)
                    return true
                }
            }
            .delay(.seconds(2), scheduler: MainScheduler.instance)
            .bind {
                guard let window = UIApplication.shared.windows.first else {
                    return
                }
                
                var vc: UIViewController!
                
                if $0 {
                    vc = MainTabBarController()
                } else {
                    vc = LoginViewController()
                }
                
                window.rootViewController = vc
                
                let options: UIView.AnimationOptions = .transitionCrossDissolve
                let duration: TimeInterval = 0.3
                UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
                { completed in
                    
                })
            }
            .disposed(by: disposeBag)
          

    }

}

