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
        SignUpViewModel.creatingUser = CreatingUser()
        
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
            .observe(on: MainScheduler.instance)
            .skip(1)
            .bind { [weak self] in
                guard let self = self else { return }
                
                if !$0 {
                    self.customView.idConfirmMessageLabel.text = "사용할 수 없는 이메일 입니다."
                } else {
                    self.customView.idConfirmMessageLabel.text = ""
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.passwordConfirmed
            .observe(on: MainScheduler.instance)
            .skip(1)
            .bind {
                print("비밀번호 컨펌: \($0)")
            }
            .disposed(by: disposeBag)
        
        viewModel.passwordVerifyingComfirmed
            .observe(on: MainScheduler.instance)
            .skip(1)
            .bind { [weak self] in
                guard let self = self else { return }
                
                switch $0 {
                case .NotValid:
                    self.customView.passwordConfirmMessageLabel.text = "사용할 수 없는 비밀번호 입니다. (6~12자)"
                case .NotSame:
                    self.customView.passwordConfirmMessageLabel.text = "비밀번호가 일치하지 않습니다."
                case .Okay:
                    self.customView.passwordConfirmMessageLabel.text = ""
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.inputsConfirmed
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in
                self?.navigationItem.rightBarButtonItem?.isEnabled = $0
            }
            .disposed(by: disposeBag)
        
        viewModel.nextConfirmed
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in
                guard let self = self else { return }
                
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
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: .XIcon.resize(to: CGSize(width: 10.adjustedHeight, height: 10.adjustedHeight)), style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem?.tintColor = .mainColor
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "다음", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFont.defaultFont(size: .medium, bold: true)], for: .normal)
        self.navigationItem.rightBarButtonItem?.tintColor = .mainColor
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        self.navigationItem.leftBarButtonItem!
            .rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
}
