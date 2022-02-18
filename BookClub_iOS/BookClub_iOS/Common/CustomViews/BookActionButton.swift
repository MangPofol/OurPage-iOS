//
//  BookActionButton.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/17.
//

import UIKit

import RxSwift
import RxGesture

final class BookActionButton: UIView {
    var iconImageView = UIImageView()
    var titleLabel = UILabel()
    
    var offColor: UIColor = UIColor(hexString: "C3C5D1")
    
    var defaultColor: UIColor = .mainColor {
        didSet {
            self.iconImageView.tintColor = defaultColor
            self.titleLabel.textColor = defaultColor
        }
    }
    
    var isOn: Bool = false {
        didSet {
            if isOn {
                self.iconImageView.tintColor = defaultColor
                self.titleLabel.textColor = defaultColor
            } else {
                self.iconImageView.tintColor = offColor
                self.titleLabel.textColor = offColor
            }
        }
    }
    
    convenience init(iconImage: UIImage?, title: String, frame: CGRect = .zero) {
        self.init(frame: frame)
        
        self.addSubview(iconImageView)
        self.addSubview(titleLabel)
        
        self.iconImageView.then {
            $0.image = iconImage?.withRenderingMode(.alwaysTemplate)
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.width.height.equalTo(13.adjustedHeight)
            $0.top.equalToSuperview().inset(5.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        self.titleLabel.then {
            $0.font = .defaultFont(size: 12, boldLevel: .bold)
            $0.textColor = .mainColor
            $0.textAlignment = .center
            $0.text = title
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(iconImageView.snp.bottom).offset(6.5.adjustedHeight)
            $0.bottom.equalToSuperview().inset(3.4.adjustedHeight)
        }
    }
}
