//
//  EmptyTodoTableViewCell.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/01.
//

import UIKit

class EmptyTodoTableViewCell: UITableViewCell {
    static let identifier = "EmptyTodoTableViewCell"
    
    private var containerView = UIView()
    var createButton = UIImageView()
    var contentLabel = UILabel()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.containerView.addSubview(createButton)
        self.containerView.addSubview(contentLabel)
        
        self.contentView.addSubview(containerView)
        self.contentView.backgroundColor = UIColor(hexString: "EFF0F3")
        
        self.containerView.then {
            $0.backgroundColor = .white
            $0.setCornerRadius(radius: 12.adjustedHeight)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(14.adjustedHeight)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10.adjustedHeight)
        }
        
        self.createButton.then {
            $0.image = UIImage(named: "CreateTodoImage")
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.width.height.equalTo(9.48.adjustedHeight)
            $0.left.equalToSuperview().inset(11.adjustedHeight)
            $0.centerY.equalToSuperview()
        }
        
        self.contentLabel.then {
            $0.font = .defaultFont(size: 12, boldLevel: .light)
            $0.textColor = UIColor(hexString: "E5949D")
            $0.text = "눌러서 작성하세요."
            $0.textAlignment = .left
        }.snp.makeConstraints {
            $0.left.equalTo(createButton.snp.right).offset(14.52.adjustedHeight)
            $0.right.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(2.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
