//
//  BookclubHomeCollectionViewCell.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/28.
//

import UIKit

class BookclubHomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "BookclubHomeCollectionViewCell"
    
    var titleLabel = UILabel()
    var introduceLabel = UILabel()
    var memberProfileImageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var pointLabel = UILabel()
    var pointCharacterimageView = UIImageView()
    var newBadgeImageView = UIImageView()
    
    private var pointBackgroundImageView = UIImageView()
    private var backgroundImageView = UIImageView()
    private var containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(containerView)
        containerView.then {
            $0.backgroundColor = .mainColor
            $0.setCornerRadius(radius: 20.adjustedHeight)
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.containerView.addSubview(titleLabel)
        titleLabel.then {
            $0.textColor = .white
            $0.textAlignment = .left
            $0.font = .defaultFont(size: 16.0, boldLevel: .bold)
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(23.0.adjustedHeight)
            $0.left.equalToSuperview().inset(21.0.adjustedHeight)
            $0.right.equalToSuperview().inset(30.0.adjustedHeight)
        }
        
        self.containerView.addSubview(introduceLabel)
        introduceLabel.then {
            $0.textColor = UIColor(hexString: "C3C5D1")
            $0.textAlignment = .left
            $0.font = .defaultFont(size: 12.0, boldLevel: .regular)
        }.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3.adjustedHeight)
            $0.left.right.equalTo(titleLabel)
        }
        
        self.containerView.addSubview(backgroundImageView)
        backgroundImageView.then {
            $0.image = UIImage(named: "BackgroundImage")
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(-60.0.adjustedHeight)
            $0.bottom.equalToSuperview().inset(-30.8.adjustedHeight)
            $0.right.equalToSuperview().inset(29.84.adjustedHeight)
            $0.height.equalTo(135.8.adjustedHeight)
        }
        
        self.containerView.addSubview(newBadgeImageView)
        newBadgeImageView.then {
            $0.image = UIImage(named: "NewBadge")
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.width.height.equalTo(9.0)
            $0.top.equalToSuperview().inset(29.0.adjustedHeight)
            $0.right.equalToSuperview().inset(20.0.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
