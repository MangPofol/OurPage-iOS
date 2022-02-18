//
//  ButtonWithRightIcon.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/08.
//

import Foundation
import UIKit

final class ButtonWithRightIcon: UIButton {
    var textLabel = UILabel()
    var iconView = UIImageView()
    
    convenience init(frame: CGRect = .zero, image: UIImage, title: String, iconPadding: Double, textPadding: Double, iconSize: CGSize) {
        self.init(frame: frame)
    
        self.addSubview(iconView)
        iconView.image = image
        iconView.contentMode = .scaleAspectFit
        iconView.snp.makeConstraints {
            $0.right.equalToSuperview().inset(iconPadding)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(iconSize.width)
            $0.height.equalTo(iconSize.height)
        }
        
        self.addSubview(textLabel)
        textLabel.text = title
        
        textLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(textPadding)
        }
    }
}
