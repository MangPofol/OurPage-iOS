//
//  DeleteAlertView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/17.
//

import UIKit

final class DeleteAlertView: UIView {
    var titleLabel = UILabel()
    var contentLabel = UILabel()
    
    var cancelButton = CMButton()
    var actionButton = CMButton()
    
    convenience init(title: String, content: String, action: String, frame: CGRect = .zero) {
        self.init(frame: frame)
        
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        self.addSubview(cancelButton)
        self.addSubview(actionButton)
        
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
        }
        
        self.cancelButton.then {
            $0.defaultBackgroundColor = .white
            $0.setTitle("취소", for: .normal)
            $0.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
            $0.titleLabel?.font = .defaultFont(size: 14, boldLevel: .regular)
        }.snp.makeConstraints { [unowned self] in
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview().inset(14.adjustedHeight)
            $0.right.equalTo(self.snp.centerX)
            $0.width.equalTo(121.adjustedHeight)
            $0.height.equalTo(34.adjustedHeight)
        }
        
        self.actionButton.then {
            $0.defaultBackgroundColor = .white
            $0.setTitle(action, for: .normal)
            $0.setTitleColor(.mainPink, for: .normal)
            $0.titleLabel?.font = .defaultFont(size: 14, boldLevel: .regular)
        }.snp.makeConstraints { [unowned self] in
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview().inset(14.adjustedHeight)
            $0.left.equalTo(self.snp.centerX)
            $0.width.equalTo(121.adjustedHeight)
            $0.height.equalTo(34.adjustedHeight)
        }
    }
}
