//
//  AlertView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/17.
//

import UIKit

final class AlertView: UIView {
    var titleLabel = UILabel()
    var contentLabel = UILabel()
    
    private var lineView = UIView()
    
    var actionButton = CMButton()
    
    convenience init(title: String, content: String, action: String, frame: CGRect = .zero) {
        self.init(frame: frame)
        
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        self.addSubview(lineView)
        self.addSubview(actionButton)
        
        self.backgroundColor = .white
        self.setCornerRadius(radius: 10.adjustedHeight)
        
        self.snp.contentCompressionResistanceHorizontalPriority = .infinity
        self.snp.makeConstraints {
            $0.width.equalTo(268.adjustedHeight)
        }
        
        self.titleLabel.then {
            $0.font = .defaultFont(size: 16, boldLevel: .bold)
            $0.textColor = .mainColor
            $0.textAlignment = .center
            $0.text = title
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13.adjustedHeight)
            $0.left.right.equalToSuperview()
        }
        
        self.contentLabel.then {
            $0.font = .defaultFont(size: 12, boldLevel: .regular)
            $0.textColor = .mainColor
            $0.textAlignment = .center
            $0.text = content
        }.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(2.adjustedHeight)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(lineView.snp.top).offset(-15.adjustedHeight)
        }
        
        self.lineView.then {
            $0.backgroundColor = UIColor(hexString: "C3C5D1")
        }.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview().inset(14.adjustedHeight)
            $0.bottom.equalTo(actionButton.snp.top)
        }
        
        self.actionButton.then {
            $0.defaultBackgroundColor = .white
            $0.setTitle(action, for: .normal)
            $0.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
            $0.titleLabel?.font = .defaultFont(size: 14, boldLevel: .regular)
        }.snp.makeConstraints {
            $0.height.equalTo(34.adjustedHeight)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(14.adjustedHeight)
        }
    }
}
