//
//  MemberProfileCollectionViewCell.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/26.
//

import UIKit

class MemberProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = "MemberProfileCollectionViewCell"
    
    var profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = Constants.profileImageSize().height / 2.0
//        $0.layer.borderWidth = 1
//        $0.layer.borderColor = UIColor.clear.cgColor
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
