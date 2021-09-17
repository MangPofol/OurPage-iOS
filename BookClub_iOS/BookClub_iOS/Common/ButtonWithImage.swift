//
//  ButtonWithImage.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/17.
//

import UIKit

class ButtonWithImage: UIView {

    var button = UIButton().then {
        $0.contentHorizontalAlignment = .leading
    }
    var imageView = UIImageView().then {
        $0.isUserInteractionEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(button)
        self.addSubview(imageView)
        
        self.button.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
        self.imageView.snp.makeConstraints {
            $0.right.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
