//
//  CheckListView.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/02.
//

import UIKit

final class CheckListView: UIScrollView {
    private var contentView = UIView()
    var monthlyCheckListTableView = SelfSizedTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
    }
    
    func makeView() {
        self.addSubview(contentView)
        
        self.contentView.then {
            $0.backgroundColor = .white
            $0.addSubview(monthlyCheckListTableView)
        }.snp.makeConstraints {
            $0.edges.equalTo(contentLayoutGuide)
            $0.width.equalTo(frameLayoutGuide)
        }
        
        self.monthlyCheckListTableView.then {
            $0.backgroundColor = .white
            $0.separatorStyle = .none
            $0.register(MonthlyCheckListCell.self, forCellReuseIdentifier: MonthlyCheckListCell.identifier)
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
            $0.bottom.equalToSuperview().inset(26.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
