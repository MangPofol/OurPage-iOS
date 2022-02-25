//
//  AskViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/22.
//

import UIKit

final class AskViewController: UIViewController {
    var titleLabel = UILabel()
    var contentLabel = UILabel()
    var emailButtonImageView = UIImageView()
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .white
        self.title = "1:1 문의 / 요청"
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(contentLabel)
        self.view.addSubview(emailButtonImageView)
        
        self.titleLabel.then {
            $0.font = .defaultFont(size: 16, boldLevel: .bold)
            $0.textColor = .mainColor
            $0.text = "Contact us"
            $0.textAlignment = .center
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().inset(245.adjustedHeight)
        }
        
        self.contentLabel.then {
            $0.font = .defaultFont(size: 12, boldLevel: .light)
            $0.textColor = .mainColor
            $0.numberOfLines = 2
            $0.text = "Our page 사용 중 문의사항이 있다면\n언제든지 편하게 문의해주세요!"
            $0.textAlignment = .center
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20.adjustedHeight)
        }
        
        self.emailButtonImageView.then {
            $0.image = UIImage(named: "EmailSendImage")
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.width.equalTo(126.adjustedHeight)
            $0.height.equalTo(32.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentLabel.snp.bottom).offset(15.5.adjustedHeight)
        }
    }
}
