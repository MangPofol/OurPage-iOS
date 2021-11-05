//
//  IntroduceView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/03.
//

import UIKit

final class IntroduceView: UIView {
    var titleLabel = UILabel().then {
        $0.text = "나를 30자로 표현해 본다면?"
        $0.textColor = .mainColor
        $0.font = .defaultFont(size: .big, bold: true)
    }
    
    var introduceTextField = UITextField().then {
        $0.backgroundColor = .textFieldBackgroundGray
        $0.placeholder = "당신의 책 취향을 소개해주세요."
        $0.font = .defaultFont(size: 16.0)
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
        $0.addLeftPadding(value: Constants.getAdjustedWidth(10.0))
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.textContentType = .username
    }
    
    var nextButton = UIButton().then {
        $0.isUserInteractionEnabled = false
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
        $0.backgroundColor = .textFieldBackgroundGray
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(8.0))
    }
    
    var nextInformationLabel = UILabel().then {
        $0.isHidden = true
        $0.backgroundColor = .white
        $0.textColor = UIColor(hexString: "E5949D")
        $0.font = .defaultFont(size: .small)
        $0.text = "입력한 정보는 추후 북클럽 내 ‘나의 프로필’에 표시됩니다."
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.addSubview(titleLabel)
        self.addSubview(introduceTextField)
        self.addSubview(nextButton)
        self.addSubview(nextInformationLabel)
        
        makeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeView() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.getAdjustedHeight(33.0))
            $0.left.equalToSuperview().inset(Constants.getAdjustedWidth(20.0))
        }
        introduceTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.getAdjustedHeight(24.0))
            $0.left.right.equalToSuperview().inset(Constants.getAdjustedWidth(20.0))
            $0.height.equalTo(Constants.getAdjustedHeight(40.0))
        }
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(nextInformationLabel.snp.top).offset(-Constants.getAdjustedHeight(9.0))
            $0.width.equalTo(Constants.getAdjustedWidth(320.0))
            $0.height.equalTo(Constants.getAdjustedHeight(52.0))
        }
        nextInformationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Constants.getAdjustedHeight(75.0))
        }
    }
}

