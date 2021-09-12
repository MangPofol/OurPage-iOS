//
//  SideMenuView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/09.
//

import UIKit

final class SideMenuView: UIView {
    var profileImageView = UIImageView().then {
        $0.image = .defaultProfile
    }
    
    var nameLabel = UILabel().then {
        $0.font = .defaultFont(size: .bigger, bold: true)
        $0.adjustsFontForContentSizeCategory = true
        $0.textColor = .black
        $0.text = "이름"
    }
    
    var idLabel = UILabel().then {
        $0.font = .defaultFont(size: .cellFont)
        $0.adjustsFontForContentSizeCategory = true
        $0.textColor = .black
        $0.text = "아이디: hi06021"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.addSubview(profileImageView)
        self.addSubview(nameLabel)
        self.addSubview(idLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
//        profileImageView.snp.makeConstraints {
//            $0.top.equalToSuperview().inset(<#T##amount: ConstraintInsetTarget##ConstraintInsetTarget#>)
//        }
        
        nameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(Constants.screenSize.height / 20)
        }
        idLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        
    }
}

