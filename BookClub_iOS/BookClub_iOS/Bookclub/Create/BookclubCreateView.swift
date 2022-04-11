//
//  BookclubCreateView.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/30.
//

import UIKit

class BookclubCreateView: UIView {
    var nameLabel = UILabel()
    var nameTextField = UITextField()
    
    var introduceLabel = UILabel()
    var descriptionTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(nameLabel)
        self.nameLabel.then {
            $0.font = .defaultFont(size: 16.0, boldLevel: .bold)
            $0.textColor = .mainColor
            $0.text = "클럽명"
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(29.0.adjustedHeight)
            $0.left.equalToSuperview().inset(30.0.adjustedHeight)
        }
        
        self.addSubview(nameTextField)
        self.nameTextField.then {
            $0.backgroundColor = .textFieldBackgroundGray
            $0.placeholder = "클럽명을 입력해주세요. (10자 제한)"
            $0.font = .defaultFont(size: 14.0, boldLevel: .medium)
            $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
            $0.addLeftPadding(value: 10.0.adjustedHeight)
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
        }.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10.5.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.0.adjustedHeight)
            $0.height.equalTo(40.0.adjustedHeight)
        }
        
        self.addSubview(introduceLabel)
        self.introduceLabel.then {
            $0.font = .defaultFont(size: 16.0, boldLevel: .bold)
            $0.textColor = .mainColor
            $0.text = "클럽 한줄 소개 및 다짐"
        }.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(30.0.adjustedHeight)
            $0.left.equalToSuperview().inset(30.0.adjustedHeight)
        }
        
        self.addSubview(descriptionTextField)
        self.descriptionTextField.then {
            $0.backgroundColor = .textFieldBackgroundGray
            $0.placeholder = "목표 등 클럽 소개글을 입력해 주세요.(20자 제한)"
            $0.font = .defaultFont(size: 14.0, boldLevel: .medium)
            $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
            $0.addLeftPadding(value: 10.0.adjustedHeight)
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
        }.snp.makeConstraints {
            $0.top.equalTo(introduceLabel.snp.bottom).offset(10.5.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.0.adjustedHeight)
            $0.height.equalTo(40.0.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
