//
//  SettingView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/19.
//

import UIKit

final class SettingView: UIView {
    var passwordChangeButton = SettingButton(title: "비밀번호 변경")
    private var lineView = UIView()
    
    var noticeButton = SettingButton(title: "공지사항")
    var askButton = SettingButton(title: "1:1 문의 / 요청")
    var ruleButton = SettingButton(title: "이용약관")
    var licenseButton = SettingButton(title: "오픈소스 라이선스")
    var versionButton = SettingButton(title: "버전 1.0.0")
    
    private var lineView2 = UIView()
    var logoutButton = SettingButton(title: "로그아웃")
    var signOutButton = SettingButton(title: "계정 탈퇴하기")
    
    var helpButton = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(passwordChangeButton)
        self.addSubview(lineView)
        
        self.addSubview(noticeButton)
        self.addSubview(askButton)
        self.addSubview(ruleButton)
        self.addSubview(licenseButton)
        self.addSubview(versionButton)
        
        self.addSubview(lineView2)
        self.addSubview(logoutButton)
        self.addSubview(signOutButton)
        
        self.addSubview(helpButton)
        
        self.passwordChangeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
        }
        
        self.lineView.then {
            $0.backgroundColor = UIColor(hexString: "EFF0F3")
        }.snp.makeConstraints {
            $0.top.equalTo(passwordChangeButton.snp.bottom).offset(6.adjustedHeight)
            $0.height.equalTo(1.13)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
        }
        
        self.noticeButton.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(6.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
        }
        
        self.askButton.snp.makeConstraints {
            $0.top.equalTo(noticeButton.snp.bottom).offset(1.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
        }
        self.ruleButton.snp.makeConstraints {
            $0.top.equalTo(askButton.snp.bottom).offset(1.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
        }
        self.licenseButton.snp.makeConstraints {
            $0.top.equalTo(ruleButton.snp.bottom).offset(1.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
        }
        self.versionButton.then {
            $0.imageView.image = nil
        }.snp.makeConstraints {
            $0.top.equalTo(licenseButton.snp.bottom).offset(1.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
        }
        
        self.lineView2.then {
            $0.backgroundColor = UIColor(hexString: "EFF0F3")
        }.snp.makeConstraints {
            $0.top.equalTo(versionButton.snp.bottom).offset(6.adjustedHeight)
            $0.height.equalTo(1.13)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
        }
        self.logoutButton.then {
            $0.imageView.image = nil
            $0.titleView.textColor = .mainPink
        }.snp.makeConstraints {
            $0.top.equalTo(lineView2.snp.bottom).offset(6.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
        }
        self.signOutButton.then {
            $0.imageView.image = nil
            $0.titleView.textColor = .mainPink
        }.snp.makeConstraints {
            $0.top.equalTo(logoutButton.snp.bottom).offset(1.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
        }
        
        self.helpButton.then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "HelpImage")
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(274.adjustedHeight)
            $0.height.equalTo(46.33.adjustedHeight)
            $0.bottom.equalToSuperview().inset(60.67.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class SettingButton: UIView {
    var titleView = UILabel()
    var imageView = UIImageView()
    
    convenience init(title: String, frame: CGRect = .zero) {
        self.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(titleView)
        self.addSubview(imageView)
        
        self.snp.makeConstraints {
            $0.height.equalTo(40.adjustedHeight)
        }
        
        self.titleView.then {
            $0.text = title
            $0.font = .defaultFont(size: 14, boldLevel: .regular)
            $0.textColor = .mainColor
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(10.adjustedHeight)
            $0.centerY.equalToSuperview()
        }
        
        self.imageView.then {
            $0.image = .rightArrowImage
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .mainColor
        }.snp.makeConstraints {
            $0.right.equalToSuperview().inset(11.5.adjustedHeight)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(4.5)
            $0.height.equalTo(9.5)
        }
    }
}
