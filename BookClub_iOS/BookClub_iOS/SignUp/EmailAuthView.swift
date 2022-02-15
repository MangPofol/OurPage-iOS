//
//  EmailAuthView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/01.
//

import UIKit

final class EmailAuthView: UIView {
    var emailLabel = PaddingLabel(padding: UIEdgeInsets(top: 0, left: 16.0, bottom: 0.0, right: 0.0))
    var sendButton = UIButton()
    var authTextField = UITextField()
    var authAlertLabel = UILabel()
    var nextButton = CMButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(emailLabel)
        self.addSubview(sendButton)
        self.addSubview(authTextField)
        self.addSubview(authAlertLabel)
        self.addSubview(nextButton)
        
        self.emailLabel.then {
            $0.backgroundColor = .textFieldBackgroundGray
            $0.font = .defaultFont(size: 16.0, boldLevel: .bold)
            $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
            $0.textColor = UIColor(hexString: "C3C5D1")
            $0.text = "dlapdlf@asdsa.com"
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.getAdjustedHeight(50.0))
            $0.left.equalToSuperview().inset(21.adjustedWidth)
            $0.height.equalTo(Constants.getAdjustedHeight(40.0))
        }
        
        self.sendButton.then {
            $0.backgroundColor = .mainPink
            $0.setTitle("전송", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .defaultFont(size: 16.0, boldLevel: .bold)
            $0.setCornerRadius(radius: 10.adjustedHeight)
        }.snp.makeConstraints {
            $0.left.equalTo(emailLabel.snp.right).offset(10.adjustedWidth)
            $0.right.equalToSuperview().inset(20.adjustedWidth)
            $0.width.equalTo(70.0.adjustedWidth)
            $0.top.bottom.equalTo(emailLabel)
        }
        
        self.authTextField.then {
            $0.backgroundColor = .textFieldBackgroundGray
            $0.font = .defaultFont(size: 16.0, boldLevel: .bold)
            $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
            $0.textColor = UIColor(hexString: "C3C5D1")
            $0.placeholder = "인증코드를 입력해주세요."
            $0.clearButtonMode = .whileEditing
            $0.addLeftPadding(value: 16.0)
            $0.isEnabled = false
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(21.adjustedWidth)
            $0.top.equalTo(emailLabel.snp.bottom).offset(10.adjustedHeight)
            $0.height.equalTo(emailLabel)
            $0.right.equalToSuperview().inset(20.0.adjustedWidth)
        }
        
        self.authAlertLabel.then {
            $0.font = .defaultFont(size: 10, boldLevel: .regular)
            $0.textColor = .mainPink
            $0.text = "인증코드가 틀렸습니다."
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.left.equalTo(authTextField).inset(8.0.adjustedWidth)
            $0.top.equalTo(authTextField.snp.bottom).offset(10.adjustedHeight)
        }
        
        self.nextButton.then {
            $0.setTitle("다음", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.setTitleColor(UIColor(hexString: "C3C5D1"), for: .disabled)
            $0.backgroundColor = .mainPink
            
            $0.titleLabel?.font = .defaultFont(size: 18, boldLevel: .bold)
            $0.setCornerRadius(radius: Constants.getAdjustedHeight(8.0))
            $0.isEnabled = false
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Constants.getAdjustedHeight(89.0))
            $0.width.equalTo(Constants.getAdjustedWidth(320.0))
            $0.height.equalTo(Constants.getAdjustedHeight(52.0))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
