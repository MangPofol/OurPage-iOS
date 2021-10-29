//
//  LoginView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/29.
//

import UIKit

final class LoginView: UIView {
    var titleLabel = UILabel().then {
        $0.text = "Our page"
        $0.font = .defaultFont(size: .name_20, bold: true)
        $0.textColor = .mainColor
    }
    
    var logoImageView = UIImageView().then {
        $0.image = .mainLogo
        $0.backgroundColor = .white
        $0.contentMode = .scaleAspectFit
    }
    
    var idTextField = UITextField().then {
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.placeholder = "아이디"
        $0.font = .defaultFont(size: .cellFont)
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
        $0.addLeftPadding(value: Constants.getAdjustedWidth(13.0))
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.textContentType = .username
    }
    
    var passwordTextField = UITextField().then {
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.placeholder = "비밀번호"
        $0.font = .defaultFont(size: .cellFont)
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
        $0.addLeftPadding(value: Constants.getAdjustedWidth(13.0))
        $0.textContentType = .password
        $0.isSecureTextEntry = true
    }
    
    var loginButton = UIButton().then {
        $0.backgroundColor = UIColor(hexString: "E5949D")
        $0.setTitle("LOG IN", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .medium, bold: true)
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(20.0))
    }
    
    var signUpButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
    }
    var signUpLineView = LineView().then {
        $0.backgroundColor = UIColor(hexString: "C3C5D1")
    }
    var findPasswordButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(titleLabel)
        self.addSubview(logoImageView)
        self.addSubview(idTextField)
        self.addSubview(passwordTextField)
        self.addSubview(loginButton)
        self.addSubview(signUpButton)
        self.addSubview(signUpLineView)
        self.addSubview(findPasswordButton)
        
        makeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(Constants.getAdjustedHeight(140.0))
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.getAdjustedHeight(30.0))
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constants.getAdjustedWidth(134.0))
            $0.height.equalTo(Constants.getAdjustedHeight(49.99))
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(Constants.getAdjustedHeight(46.1))
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constants.getAdjustedWidth(211.0))
            $0.height.equalTo(Constants.getAdjustedHeight(26.0))
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(Constants.getAdjustedHeight(22.0))
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constants.getAdjustedWidth(211.0))
            $0.height.equalTo(Constants.getAdjustedHeight(26.0))
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(Constants.getAdjustedHeight(34.0))
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constants.getAdjustedWidth(206.0))
            $0.height.equalTo(Constants.getAdjustedHeight(40.0))
        }
        
        signUpLineView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(signUpButton)
            $0.width.equalTo(1.0)
            $0.height.equalTo(11.0)
        }
        
        signUpButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(Constants.getAdjustedHeight(178.0))
            $0.right.equalTo(signUpLineView.snp.left).offset(-Constants.getAdjustedWidth(9.0))
        }
        
        findPasswordButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(Constants.getAdjustedHeight(178.0))
            $0.left.equalTo(signUpLineView.snp.right).offset(Constants.getAdjustedWidth(9.0))
        }
    }
}
