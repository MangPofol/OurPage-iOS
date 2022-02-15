//
//  IDPWView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/29.
//

import UIKit

final class IDPWView: UIView {
    
    var idTextField = UITextField().then {
        $0.backgroundColor = .textFieldBackgroundGray
        $0.placeholder = "실제 사용중인 이메일 주소를 입력해 주세요."
        $0.font = .defaultFont(size: 16.0, boldLevel: .bold)
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
        $0.addLeftPadding(value: Constants.getAdjustedWidth(13.0))
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.textContentType = .emailAddress
        $0.keyboardType = .emailAddress
    }
    
    var idConfirmMessageLabel = UILabel().then {
        $0.backgroundColor = .white
        $0.textColor = UIColor(hexString: "E5949D")
        $0.font = .defaultFont(size: .small)
    }
    
    var passwordTextField = UITextField().then {
        $0.backgroundColor = .textFieldBackgroundGray
        $0.placeholder = "비밀번호"
        $0.font = .defaultFont(size: 16.0)
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
        $0.addLeftPadding(value: Constants.getAdjustedWidth(13.0))
        $0.textContentType = .password
        $0.isSecureTextEntry = true
    }
    
    var passwordVerifyingTextField = UITextField().then {
        $0.backgroundColor = .textFieldBackgroundGray
        $0.placeholder = "비밀번호 확인"
        $0.font = .defaultFont(size: 16.0)
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
        $0.addLeftPadding(value: Constants.getAdjustedWidth(13.0))
        $0.textContentType = .password
        $0.isSecureTextEntry = true
    }
    
    var passwordConfirmMessageLabel = UILabel().then {
        $0.backgroundColor = .white
        $0.textColor = UIColor(hexString: "E5949D")
        $0.font = .defaultFont(size: .small)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(idTextField)
        self.addSubview(idConfirmMessageLabel)
        self.addSubview(passwordTextField)
        self.addSubview(passwordVerifyingTextField)
        self.addSubview(passwordConfirmMessageLabel)
        
        makeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeView() {
        idTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.getAdjustedHeight(50.0))
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constants.getAdjustedWidth(320.0))
            $0.height.equalTo(Constants.getAdjustedHeight(40.0))
        }
        
        idConfirmMessageLabel.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(Constants.getAdjustedHeight(4.0))
            $0.left.equalTo(idTextField).offset(Constants.getAdjustedWidth(9.0))
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(30.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constants.getAdjustedWidth(320.0))
            $0.height.equalTo(Constants.getAdjustedHeight(40.0))
        }
        passwordVerifyingTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(Constants.getAdjustedHeight(10.0))
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constants.getAdjustedWidth(320.0))
            $0.height.equalTo(Constants.getAdjustedHeight(40.0))
        }
        passwordConfirmMessageLabel.snp.makeConstraints {
            $0.top.equalTo(passwordVerifyingTextField.snp.bottom).offset(Constants.getAdjustedHeight(4.0))
            $0.left.equalTo(passwordVerifyingTextField).offset(Constants.getAdjustedWidth(9.0))
        }
    }
}
