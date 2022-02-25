//
//  SignOutView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/22.
//

import UIKit

final class SignOutView: UIView {
    var titleLabel = UILabel()
    private var backgroundImageView = UIImageView()
    var signOutButton = UIButton()
    private var noticeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(titleLabel)
        self.addSubview(backgroundImageView)
        self.addSubview(signOutButton)
        self.addSubview(noticeLabel)
        
        self.titleLabel.then {
            $0.numberOfLines = 2
            $0.font = .defaultFont(size: 24, boldLevel: .bold)
            $0.textColor = .mainColor
            $0.textAlignment = .center
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(61.adjustedHeight)
        }
        
        self.backgroundImageView.then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "SingOutBackgroundImage")
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(-15.5.adjustedHeight)
            $0.height.equalTo(585.adjustedHeight)
            $0.bottom.equalToSuperview().inset(-24.adjustedHeight)
        }
        
        self.signOutButton.then {
            $0.backgroundColor = .mainPink
            $0.setTitle("탈퇴하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .defaultFont(size: 18, boldLevel: .bold)
            $0.setCornerRadius(radius: 8.adjustedHeight)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(27.5.adjustedHeight)
            $0.height.equalTo(52.adjustedHeight)
            $0.bottom.equalTo(noticeLabel.snp.top).offset(-9.adjustedHeight)
        }
        
        self.noticeLabel.then {
            $0.font = .defaultFont(size: 10, boldLevel: .regular)
            $0.textColor = .mainPink
            $0.text = "* 회원 탈퇴 시 ID와 개인정보, 기록이 삭제됩니다."
            $0.textAlignment = .center
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(71.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
