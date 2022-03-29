//
//  BookclubSettingView.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/29.
//

import UIKit

class BookclubSettingView: UIView {
    var createdBookclubLabel = UILabel()
    var createdBookclubTableView = UITableView()
    
    var joinedBookclubLabel = UILabel()
    var joinedBookclubTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.addSubview(createdBookclubLabel)
        self.createdBookclubLabel.then {
            $0.font = .defaultFont(size: 16.0, boldLevel: .bold)
            $0.textColor = .mainColor
            $0.text = "내가 만든 북클럽"
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(29.0.adjustedHeight)
            $0.left.equalToSuperview().inset(30.0.adjustedHeight)
        }
        
        self.addSubview(createdBookclubTableView)
        self.createdBookclubTableView.then {
            $0.separatorStyle = .none
            $0.backgroundColor = .white
            $0.register(BookclubSettingTableViewCell.self, forCellReuseIdentifier: BookclubSettingTableViewCell.identifier)
        }.snp.makeConstraints {
            $0.top.equalTo(createdBookclubLabel.snp.bottom).offset(14.0.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.0.adjustedHeight)
            $0.height.equalTo(200.0.adjustedHeight)
        }
        
        self.addSubview(joinedBookclubLabel)
        self.joinedBookclubLabel.then {
            $0.font = .defaultFont(size: 16.0, boldLevel: .bold)
            $0.textColor = .mainColor
            $0.text = "가입한 북클럽"
        }.snp.makeConstraints {
            $0.top.equalTo(createdBookclubTableView.snp.bottom).offset(24.0.adjustedHeight)
            $0.left.equalToSuperview().inset(30.0.adjustedHeight)
        }
        
        self.addSubview(joinedBookclubTableView)
        self.joinedBookclubTableView.then {
            $0.separatorStyle = .none
            $0.backgroundColor = .white
            $0.register(BookclubSettingTableViewCell.self, forCellReuseIdentifier: BookclubSettingTableViewCell.identifier)
        }.snp.makeConstraints {
            $0.top.equalTo(joinedBookclubLabel.snp.bottom).offset(14.0.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.0.adjustedHeight)
            $0.height.equalTo(200.0.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
