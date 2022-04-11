//
//  BookclubDetailView.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/04/06.
//

import UIKit

final class BookclubDetailView: UIView {
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var membersLabel = UILabel()
    var headerArrowImageView = UIImageView()
    var headerButton = UIButton()
    
    private var headerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(headerView)
        self.headerView.then {
            $0.backgroundColor = .mainColor
        }.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(152.adjustedHeight)
        }
        
        self.headerView.addSubview(titleLabel)
        self.titleLabel.then {
            $0.font = .defaultFont(size: 26.0, boldLevel: .bold)
            $0.textColor = .white
            $0.text = "Bookclub Text"
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(33.0)
            $0.right.equalToSuperview()
            $0.left.equalToSuperview().inset(24.0.adjustedHeight)
        }
        
        self.headerView.addSubview(descriptionLabel)
        self.descriptionLabel.then {
            $0.font = .defaultFont(size: 14.0, boldLevel: .regular)
            $0.textColor = UIColor(hexString: "C3C5D1")
            $0.text = "desription"
        }.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(1.0)
            $0.left.equalToSuperview().inset(24.0.adjustedHeight)
        }
        
        self.headerView.addSubview(membersLabel)
        self.membersLabel.then {
            $0.font = .defaultFont(size: 10.0, boldLevel: .medium)
            $0.textColor = .mainColor
            $0.backgroundColor = .white
            $0.text = "total 1 members"
            $0.setCornerRadius(radius: 10.adjustedHeight)
            $0.textAlignment = .center
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(24.0.adjustedHeight)
            $0.width.equalTo(117.adjustedHeight)
            $0.height.equalTo(20.adjustedHeight)
            $0.bottom.equalToSuperview().inset(27.79.adjustedHeight)
        }
        
        self.headerView.addSubview(headerArrowImageView)
        self.headerArrowImageView.then {
            $0.image = .rightArrowImage
            $0.tintColor = .white
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.right.equalToSuperview().inset(40.52.adjustedHeight)
            $0.bottom.equalToSuperview().inset(82.49.adjustedHeight)
            $0.width.equalTo(5.48.adjustedHeight)
            $0.height.equalTo(9.51.adjustedHeight)
        }
        
        self.headerView.addSubview(headerButton)
        self.headerButton.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.left.top.equalTo(titleLabel)
            $0.bottom.equalTo(membersLabel)
            $0.right.equalTo(headerArrowImageView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
