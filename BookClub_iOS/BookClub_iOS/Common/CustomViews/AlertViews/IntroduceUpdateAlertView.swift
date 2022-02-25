//
//  IntroduceUpdateAlertView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/19.
//

import UIKit

final class IntroduceUpdateAlertView: UIView {
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()
    var textContainer = UIView()
    var plusIconView = UIImageView()
    var introduceTextView = UITextView()
    var finishButton = UIButton()
    var cancelButton = UIButton()
    
    convenience init(introduce: String, frame: CGRect = .zero) {
        self.init(frame: frame)
        
        self.backgroundColor = .white
        self.setCornerRadius(radius: 10.adjustedHeight)
        
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(textContainer)
        self.addSubview(plusIconView)
        self.addSubview(introduceTextView)
        self.addSubview(finishButton)
        self.addSubview(cancelButton)
        
        self.snp.makeConstraints {
            $0.width.equalTo(315.adjustedHeight)
            $0.height.equalTo(160.adjustedHeight)
        }
        
        self.titleLabel.then {
            $0.font = .defaultFont(size: 16, boldLevel: .bold)
            $0.textColor = .mainColor
            $0.text = "자기소개 변경"
            $0.textAlignment = .left
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
        }
        
        self.subtitleLabel.then {
            $0.font = .defaultFont(size: 12, boldLevel: .semiBold)
            $0.textColor = .mainColor
            $0.text = "20자 이내로 입력해주세요."
            $0.textAlignment = .left
        }.snp.makeConstraints {
            $0.left.right.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(0.42.adjustedHeight)
        }
        
        self.textContainer.then {
            $0.makeBorder(color: UIColor(hexString: "C3C5D1").cgColor, width: 1.14, cornerRadius: 14.adjustedHeight)
            $0.backgroundColor = .white
        }.snp.makeConstraints {
            $0.left.equalTo(titleLabel)
            $0.right.equalToSuperview().inset(20.adjustedHeight)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(7.adjustedHeight)
            $0.bottom.equalTo(introduceTextView).offset(8.adjustedHeight)
        }
        
        self.plusIconView.then {
            $0.image = UIImage(named: "PlusIcon")
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.width.height.equalTo(10.24.adjustedHeight)
            $0.top.equalTo(textContainer).inset(11.adjustedHeight)
            $0.left.equalTo(textContainer).inset(16.adjustedHeight)
        }
        
        self.introduceTextView.then {
            $0.font = .defaultFont(size: 12, boldLevel: .light)
            $0.textColor = .mainColor
            $0.text = introduce
            $0.textContainerInset = .zero
            $0.textContainer.lineFragmentPadding = 0
        }.snp.makeConstraints {
            $0.top.equalTo(textContainer).inset(8.adjustedHeight)
            $0.left.equalTo(plusIconView.snp.right).offset(13.76.adjustedHeight)
            $0.right.equalTo(textContainer).inset(16.adjustedHeight)
            $0.height.equalTo(35.adjustedHeight)
        }
        
        self.finishButton.then {
            $0.setTitle("완료", for: .normal)
            $0.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
            $0.titleLabel?.font = .defaultFont(size: 14, boldLevel: .regular)
//            $0.snp.contentCompressionResistanceVerticalPriority = 0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
            $0.bottom.equalToSuperview().inset(6.adjustedHeight)
            $0.top.equalTo(textContainer.snp.bottom).offset(4.adjustedHeight)
        }
        
        self.cancelButton.then {
            $0.setImage(UIImage(named: "XIcon")?.resize(to: CGSize(width: 10.adjustedHeight, height: 10.adjustedHeight)).withRenderingMode(.alwaysTemplate), for: .normal)
            $0.imageView?.tintColor = .mainPink
        }.snp.makeConstraints {
            $0.width.height.equalTo(28.adjustedHeight)
            $0.top.equalToSuperview().inset(10.adjustedHeight)
            $0.right.equalToSuperview().inset(16.adjustedHeight)
        }
    }
}
