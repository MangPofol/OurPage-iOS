//
//  EmptyView.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/17.
//

import UIKit

final class EmptyView: UIView {
    var imageView = UIImageView()
    var contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        self.addSubview(contentLabel)
        
        self.imageView.then {
            $0.image = UIImage(named: "SingOutBackgroundImage")
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(-15.5.adjustedHeight)
            $0.height.equalTo(585.adjustedHeight)
        }
        
        self.contentLabel.then {
            $0.numberOfLines = 2
            $0.font = .defaultFont(size: 24, boldLevel: .bold)
            $0.textColor = .mainColor
            $0.textAlignment = .center
            $0.text = "내용이 없습니다."
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(61.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
