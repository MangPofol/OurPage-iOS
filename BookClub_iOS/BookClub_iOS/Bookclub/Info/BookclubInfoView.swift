//
//  BookclubInfoView.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/05/15.
//

import UIKit

class BookclubInfoView: UIView {
    
    private var metadataView = UIView()
    var levelImageView = UIImageView()
    var levelLabel = UILabel()
    var memberCountLabel = PaddedLabel(padding: UIEdgeInsets(top: 3, left: 5.5.adjustedHeight, bottom: 3, right: 5.5.adjustedHeight))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.addSubview(metadataView)
        self.metadataView.then {
            $0.backgroundColor = UIColor(hexString: "EFF0F3")
            $0.setCornerRadius(radius: 10.0.adjustedHeight)
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.0.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.0.adjustedHeight)
            $0.height.equalTo(94.0.adjustedHeight)
        }
        
        self.metadataView.addSubview(levelImageView)
        self.levelImageView.then {
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.width.height.equalTo(46.0.adjustedHeight)
            $0.top.equalToSuperview().inset(15.0.adjustedHeight)
            $0.left.equalToSuperview().inset(30.0.adjustedHeight)
        }
        
        self.metadataView.addSubview(levelLabel)
        self.levelLabel.then {
            $0.font = .defaultFont(size: 30.81, boldLevel: .bold)
            $0.textColor = .mainColor
        }.snp.makeConstraints {
            $0.centerX.equalTo(self.levelImageView)
            $0.bottom.equalTo(self.levelImageView).offset(3.75.adjustedHeight)
        }
        
        self.metadataView.addSubview(memberCountLabel)
        self.memberCountLabel.then {
            $0.font = .defaultFont(size: 8.0, boldLevel: .regular)
            $0.textColor = .white
            $0.backgroundColor = UIColor(hexString: "7B8099")
            $0.setCornerRadius(radius: 6.adjustedHeight)
            $0.textAlignment = .center
        }.snp.makeConstraints {
            $0.centerX.equalTo(self.levelImageView)
            $0.top.equalTo(self.levelImageView.snp.bottom).offset(9.0.adjustedHeight)
            $0.height.equalTo(12.0.adjustedHeight)
            $0.left.right.equalTo(self.levelLabel)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BookclubMetadataView: UIView {
    var iconView = UIImageView()
    var titleLabel = UILabel()
    var contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(hexString: "EFF0F3")
        
        self.addSubview(iconView)
        self.iconView.then {
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.width.height.equalTo(10.5.adjustedHeight)
        }
        
        self.addSubview(titleLabel)
        self.titleLabel.then {
            $0.font = .defaultFont(size: 12.0, boldLevel: .regular)
            $0.textColor = UIColor(hexString: "7B8099")
        }.snp.makeConstraints {
            $0.left.equalTo(self.iconView.snp.right).offset(7.0.adjustedHeight)
            $0.width.equalTo(76.0.adjustedHeight)
            $0.centerY.equalToSuperview()
        }
        
        self.addSubview(contentLabel)
        self.contentLabel.then {
            $0.font = .defaultFont(size: 12.0, boldLevel: .regular)
            $0.textColor = UIColor(hexString: "7B8099")
        }.snp.makeConstraints {
            $0.left.equalTo(self.titleLabel.snp.right)
            $0.width.equalTo(75.0.adjustedHeight)
            $0.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
