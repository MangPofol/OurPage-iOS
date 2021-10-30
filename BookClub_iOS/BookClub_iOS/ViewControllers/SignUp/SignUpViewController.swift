//
//  SignUpViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/29.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {

    var viewModel: SignUpViewModel!
    var customView = IDPWView()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "회원가입" 
        setNavigationBar()
        
        viewModel = SignUpViewModel(
            input: (
                idText: customView.idTextField.rx.text.asObservable().distinctUntilChanged()
                    .filter { $0 != nil }
                    .map { $0! },
                passwordText: customView.passwordTextField.rx.text.asObservable().distinctUntilChanged()
                    .filter { $0 != nil }
                    .map { $0! },
                passwordVerifyingText: customView.passwordVerifyingTextField.rx.text.asObservable().distinctUntilChanged()
                    .filter { $0 != nil }
                    .map { $0! },
                nextButtonTapped: self.navigationItem.rightBarButtonItem!.rx.tap
            )
        )
        
        // bind outputs {
        viewModel.idConfirmed
            .observeOn(MainScheduler.asyncInstance)
            .skip(1)
            .bind {
                if !$0 {
                    self.customView.idConfirmMessageLabel.text = "사용할 수 없는 아이디 입니다."
                } else {
                    self.customView.idConfirmMessageLabel.text = ""
                }
            }
            .disposed(by: disposeBag)
        
//        viewModel.passwordConfirmed
//            .observeOn(MainScheduler.asyncInstance)
//            .skip(1)
//            .bind {
//                if !$0 {
//                    self.customView.idConfirmMessageLabel.text = "사용할 수 없는 아이디 입니다."
//                } else {
//                    self.customView.idConfirmMessageLabel.text = ""
//                }
//            }
//            .disposed(by: disposeBag)
        
        viewModel.passwordVerifyingComfirmed
            .observeOn(MainScheduler.asyncInstance)
            .skip(1)
            .bind {
                if !$0 {
                    self.customView.passwordConfirmMessageLabel.text = "사용할 수 없는 비밀번호 입니다."
                } else {
                    self.customView.passwordConfirmMessageLabel.text = ""
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.nextConfirmed
            .observeOn(MainScheduler.asyncInstance)
            .bind {
                print(SignUpViewModel.creatingUser)
                if $0 {
                    self.navigationController?.pushViewController(ProfileInformationViewController(), animated: true)
                } else {
                    print(#fileID, #function, #line, "FailToNext")
                }
            }
            .disposed(by: disposeBag)
        // }
    }
    
    private func setNavigationBar() {
        guard let nav = self.navigationController else {
            return
        }
        nav.navigationBar.barTintColor = Constants.navigationbarColor
        nav.navigationBar.tintColor = .black
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.titleTextAttributes = [.font: UIFont.defaultFont(size: .big, bold: true), .foregroundColor: UIColor.mainColor]
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Constants.navigationbarColor
        appearance.titleTextAttributes = [.font: UIFont.defaultFont(size: .big, bold: true), .foregroundColor: UIColor.mainColor]
        
        // 백 버튼 텍스트 지우기
        appearance.setBackIndicatorImage(.backbuttonImage, transitionMaskImage: .leftArrowImage)
        self.navigationItem.backButtonTitle = ""
        
        // bar underline 삭제
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .white
//        nav.navigationBar.standardAppearance = appearance;
        nav.navigationBar.scrollEdgeAppearance = appearance
//        nav.navigationBar.addShadow(location: .bottom, opacity: 0.25)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: .backbuttonImage, style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem?.tintColor = .mainColor
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "다음", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFont.defaultFont(size: .medium, bold: true)], for: .normal)
        self.navigationItem.rightBarButtonItem?.tintColor = .mainColor
        
        self.navigationItem.leftBarButtonItem!
            .rx.tap
            .bind {
                self.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
}
