//
//  EmailAuthViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/01.
//

import UIKit

import RxSwift
import RxCocoa

class EmailAuthViewController: UIViewController {

    private let customView = EmailAuthView()
    private var viewModel: EmailAuthViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = customView
        
        self.title = "이메일 인증"
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.defaultFont(size: .big, bold: true), .foregroundColor: UIColor.mainColor]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customView.emailLabel.text = SignUpViewModel.creatingUser.email
        
        self.viewModel = EmailAuthViewModel(
            input: EmailAuthViewModel.Input(
                sendButtonTapped: self.customView.sendButton.rx.tap,
                nextButtonTapped: self.customView.nextButton.rx.tap,
                authText: self.customView.authTextField.rx.text.orEmpty.asObservable()
            )
        )
        
        // bind outputs {
        self.customView.sendButton.rx.tap
            .bind {
                LoadingHUD.show()
            }
            .disposed(by: disposeBag)
        
        self.viewModel.output.isSentAuthCode
            .drive { [weak self] in
                LoadingHUD.hide()
                guard let self = self else { return }
                if $0 {
                    self.customView.authTextField.isEnabled = true
                    self.customView.sendButton.backgroundColor = .white
                    self.customView.sendButton.setTitle("재전송", for: .normal)
                    self.customView.sendButton.setTitleColor(.mainPink, for: .normal)
                    self.customView.sendButton.drawBorder(color: UIColor.mainPink.cgColor, width: 2.0)
                }
            }
            .disposed(by: disposeBag)
        
        self.viewModel.output.isNextButtonEnabled
            .drive { [weak self] in
                guard let self = self else { return }
                
                self.customView.nextButton.isEnabled = $0
            }
            .disposed(by: disposeBag)
        
        self.viewModel.output.authState
            .drive { [weak self] in
                guard let self = self else { return }
                
                switch $0 {
                case .fail:
                    self.customView.authAlertLabel.isHidden = false
                case .success:
                    self.navigationController?.pushViewController(ProfileInformationViewController(), animated: true)
                }
            }
            .disposed(by: disposeBag)
        // }
    }
    

}
