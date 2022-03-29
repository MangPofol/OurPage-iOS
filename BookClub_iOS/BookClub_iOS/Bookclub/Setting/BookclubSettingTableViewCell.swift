//
//  BookclubSettingTableViewCell.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/29.
//

import UIKit

class BookclubSettingTableViewCell: UITableViewCell {
    static let identifier = "BookclubSettingTableViewCell"
    
    var titleLabel = UILabel()
    var createdDateLabel = UILabel()
    var removeButton = CMButton()
    
    private var containerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(containerView)
        self.containerView.then {
            $0.backgroundColor = UIColor(hexString: "EFF0F3")
            $0.setCornerRadius(radius: 10.0.adjustedHeight)
        }.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10.0.adjustedHeight)
        }
        
        self.containerView.addSubview(titleLabel)
        self.titleLabel.then {
            $0.font = .defaultFont(size: 14.0, boldLevel: .bold)
            $0.textColor = .mainColor
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12.5.adjustedHeight)
            $0.left.equalToSuperview().inset(17.0.adjustedHeight)
        }
        
        self.containerView.addSubview(createdDateLabel)
        self.createdDateLabel.then {
            $0.font = .defaultFont(size: 10.0, boldLevel: .medium)
            $0.textColor = UIColor(hexString: "646A88")
        }.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(1.0)
            $0.left.equalToSuperview().inset(17.0.adjustedHeight)
        }
        
        self.containerView.addSubview(removeButton)
        self.removeButton.then {
            $0.defaultBackgroundColor = UIColor(hexString: "EFF0F3")
            $0.makeBorder(color: UIColor.mainPink.cgColor, width: 1.0, cornerRadius: 7.0.adjustedHeight)
            $0.setTitle("삭제하기", for: .normal)
            $0.setTitleColor(.mainPink, for: .normal)
            $0.titleLabel?.font = .defaultFont(size: 12.0, boldLevel: .regular)
        }.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(16.0.adjustedHeight)
            $0.width.equalTo(60.0.adjustedHeight)
            $0.height.equalTo(24.0.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
