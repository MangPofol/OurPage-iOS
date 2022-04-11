//
//  BookclubHomeEmptyCell.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/04/07.
//

import UIKit

class BookclubHomeEmptyCell: UICollectionViewCell {
    static let identifier = "BookclubHomeEmptyCell"
    
    private var emptyImageView = UIImageView()
    private var containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(containerView)
        containerView.then {
            $0.backgroundColor = UIColor(hexString: "EFF0F3")
            $0.setCornerRadius(radius: 20.adjustedHeight)
        }.snp.makeConstraints {
            
            $0.edges.equalToSuperview()
        }
        
        self.containerView.addSubview(emptyImageView)
        emptyImageView.then {
            $0.image = UIImage(named: "BookClubEmptyImage")
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
