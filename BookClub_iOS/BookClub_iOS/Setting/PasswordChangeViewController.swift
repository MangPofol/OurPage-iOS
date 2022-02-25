//
//  PasswordChangeViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/21.
//

import UIKit

import RxSwift
import RxCocoa
import FFPopup

final class PasswordChangeViewController: UIViewController {
    private let customView = PasswordChangeView()
    private var popup: FFPopup!
    
    private var viewModel: PasswordChangeViewModel!
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = customView
        self.navigationController?.navigationBar.setDefault()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: nil, action: nil).then {
            $0.setTitleTextAttributes([.font: UIFont.defaultFont(size: 14, boldLevel: .bold), .foregroundColor: UIColor.mainColor], for: .normal)
        }
        
        self.title = "비밀번호 변경"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customView.passwordTextField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] in
                guard let self = self else { return }
                self.customView.newPasswordTextField.becomeFirstResponder()
            }
            .disposed(by: disposeBag)
        
        self.customView.newPasswordTextField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] in
                guard let self = self else { return }
                self.customView.newPasswordVerifyingTextField.becomeFirstResponder()
            }
            .disposed(by: disposeBag)
        
        self.customView.newPasswordVerifyingTextField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] in
                guard let self = self else { return }
                self.customView.newPasswordVerifyingTextField.resignFirstResponder()
            }
            .disposed(by: disposeBag)
        
        self.viewModel = PasswordChangeViewModel(
            input: (
                newPassword: self.customView.newPasswordTextField.rx.text.orEmpty.asObservable(),
                newPasswordVerifying: self.customView.newPasswordVerifyingTextField.rx.text.orEmpty.asObservable(),
                finishButtonTapped: self.navigationItem.rightBarButtonItem!.rx.tap
            )
        )
        
        self.navigationItem.rightBarButtonItem!.rx.tap
            .bind { [weak self] in
                self?.view.endEditing(true)
                LoadingHUD.show()
            }
            .disposed(by: disposeBag)
        
        self.viewModel.passwordChanged
            .do { _ in LoadingHUD.hide() }
            .drive { [weak self] in
                switch $0 {
                case .success, .failure:
                    self?.showResultAlert(result: $0)
                case .notValid:
                    self?.showNotCorrectAlert(result: $0)
                case .notCorrect:
                    self?.showNotCorrectAlert(result: $0)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func showResultAlert(result: PasswordChangeResultType) {
        var view: AlertView!
        
        switch result {
        case .success:
            view = AlertView(title: "비밀번호 변경 완료", content: "비밀번호가 변경되었습니다", action: "확인")
        case .failure:
            view = AlertView(title: "비밀번호 변경 실패", content: "잠시 후 다시 시도해주세요", action: "확인")
        default:
            return
        }
        
        view.actionButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                self.popup.dismiss(animated: true)
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        let layout = FFPopupLayout(horizontal: .center, vertical: .center)
        popup = FFPopup(contentView: view, showType: .bounceIn, dismissType: .bounceOut, maskType: .dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)
        
        popup.show(layout: layout)
    }
    
    private func showNotCorrectAlert(result: PasswordChangeResultType) {
        var view: PasswordAlertView!
        
        switch result {
        case .notCorrect:
            view = PasswordAlertView().then { $0.titleLabel.text = "비밀번호가 일치하지 않습니다." }
        case .notValid:
            view = PasswordAlertView().then { $0.titleLabel.text = "규칙에 맞는 비밀번호를 입력해주세요." }
        default:
            return
        }
        
        let layout = FFPopupLayout(horizontal: .center, vertical: .bottom)
        popup = FFPopup(contentView: view, showType: .bounceIn, dismissType: .bounceOut, maskType: .clear, dismissOnBackgroundTouch: false, dismissOnContentTouch: false)
        
        popup.show(layout: layout, duration: 2)
    }
}

final class PasswordChangeView: UIView {
    var passwordTextField = UITextField().then {
        $0.backgroundColor = .textFieldBackgroundGray
        $0.placeholder = "기존 비밀번호"
        $0.font = .defaultFont(size: 14, boldLevel: .bold)
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
        $0.addLeftPadding(value: Constants.getAdjustedWidth(13.0))
        $0.textContentType = .password
        $0.isSecureTextEntry = true
    }
    
    var newPasswordTextField = UITextField().then {
        $0.backgroundColor = .textFieldBackgroundGray
        $0.placeholder = "새로운 비밀번호"
        $0.font = .defaultFont(size: 14, boldLevel: .bold)
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
        $0.addLeftPadding(value: Constants.getAdjustedWidth(13.0))
        $0.textContentType = .password
        $0.isSecureTextEntry = true
    }
    
    var newPasswordVerifyingTextField = UITextField().then {
        $0.backgroundColor = .textFieldBackgroundGray
        $0.placeholder = "새로운 비밀번호 재입력"
        $0.font = .defaultFont(size: 14, boldLevel: .bold)
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
        $0.addLeftPadding(value: Constants.getAdjustedWidth(13.0))
        $0.textContentType = .password
        $0.isSecureTextEntry = true
    }
    
    var passwordRuleInfoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.addSubview(passwordTextField)
        self.addSubview(newPasswordTextField)
        self.addSubview(newPasswordVerifyingTextField)
        self.addSubview(passwordRuleInfoLabel)
        
        self.passwordTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(31.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
            $0.height.equalTo(40.adjustedHeight)
        }
        
        self.newPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
            $0.height.equalTo(40.adjustedHeight)
        }
        
        self.newPasswordVerifyingTextField.snp.makeConstraints {
            $0.top.equalTo(newPasswordTextField.snp.bottom).offset(10.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
            $0.height.equalTo(40.adjustedHeight)
        }
        
        self.passwordRuleInfoLabel.then {
            $0.font = .defaultFont(size: 10, boldLevel: .regular)
            $0.textColor = UIColor(hexString: "C3C5D1")
            $0.text = "영문, 숫자, 특수문자 중 2개 조합 10자 이상"
        }.snp.makeConstraints {
            $0.top.equalTo(newPasswordVerifyingTextField.snp.bottom).offset(4)
            $0.left.equalToSuperview().inset(30.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class PasswordAlertView: UIView {
    private var containerView = UIView()
    var imageView = UIImageView(image: UIImage(named: "CircleExclamationIcon"))
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(containerView)
        
        self.snp.makeConstraints {
            $0.width.equalTo(335.adjustedHeight)
            $0.height.equalTo(120.adjustedHeight)
        }
        
        self.containerView.then {
            $0.addSubview(imageView)
            $0.addSubview(titleLabel)
            $0.setCornerRadius(radius: 10.adjustedHeight)
            $0.backgroundColor = .mainPink
        }.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(40.adjustedHeight)
        }
        
        self.imageView.then {
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.width.height.equalTo(20.adjustedHeight)
            $0.centerY.equalToSuperview()
            $0.left.equalTo(15.adjustedHeight)
        }
        
        self.titleLabel.then {
            $0.font = .defaultFont(size: 12, boldLevel: .medium)
            $0.textColor = .white
            $0.textAlignment = .left
        }.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(10.25.adjustedHeight)
            $0.right.equalToSuperview().inset(5)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
