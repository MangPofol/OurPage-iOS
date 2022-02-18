//
//  PhotoAlertView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/18.
//

import UIKit

final class PhotoAlertView: UIView {
    var titleLabel = UILabel()
    var takePictureOptionView = LabelWithIcon(iconImage: .cameraIcon, title: "사진 촬영하기")
    private var lineView = UIView()
    var galleryOptionView = LabelWithIcon(iconImage: UIImage(named: "GalleryIcon"), title: "사진첩에서 가져오기")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLabel)
        self.addSubview(takePictureOptionView)
        self.addSubview(lineView)
        self.addSubview(galleryOptionView)
        
        self.backgroundColor = .white
        self.topRoundCorner(radius: 10.adjustedHeight)
        
        self.snp.makeConstraints {
            $0.height.equalTo(199.adjustedHeight)
            $0.width.equalTo(Constants.screenSize.width)
        }
        
        self.titleLabel.then {
            $0.font = .defaultFont(size: 18, boldLevel: .bold)
            $0.text = "프로필 사진 변경"
            $0.textColor = .mainColor
            $0.textAlignment = .center
            $0.snp.contentHuggingVerticalPriority = .infinity
        }.snp.makeConstraints {
            $0.left.right.top.equalToSuperview().inset(15.adjustedHeight)
        }
        
        self.takePictureOptionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(29.adjustedHeight)
            $0.left.right.equalToSuperview().inset(25.adjustedHeight)
            $0.height.equalTo(46.adjustedHeight)
        }
        
        self.lineView.then {
            $0.backgroundColor = UIColor(hexString: "EFF0F3")
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(25.adjustedHeight)
            $0.height.equalTo(1)
            $0.top.equalTo(takePictureOptionView.snp.bottom).offset(2.adjustedHeight)
        }
        
        self.galleryOptionView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(2.adjustedHeight)
            $0.left.right.equalToSuperview().inset(25.adjustedHeight)
            $0.height.equalTo(46.adjustedHeight)
            $0.bottom.equalToSuperview().inset(42.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class LabelWithIcon: UIView {
    var iconView = UIImageView()
    var label = UILabel()
    
    convenience init(iconImage: UIImage?, title: String, frame: CGRect = .zero) {
        self.init(frame: frame)
        
        self.addSubview(iconView)
        self.addSubview(label)
        
        self.iconView.then {
            $0.image = iconImage?.withRenderingMode(.alwaysTemplate)
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .mainPink
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(13.adjustedHeight)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(17.adjustedHeight)
        }
        
        self.label.then {
            $0.text = title
            $0.font = .defaultFont(size: 16, boldLevel: .medium)
            $0.textColor = UIColor(hexString: "646A88")
            $0.textAlignment = .left
        }.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(16.adjustedHeight)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(13.adjustedHeight)
        }
    }
}
