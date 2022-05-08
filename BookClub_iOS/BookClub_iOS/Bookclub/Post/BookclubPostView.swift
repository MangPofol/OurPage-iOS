//
//  BookclubPostView.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/05/05.
//

import UIKit

class BookclubPostView: UIView {
    var bookTitleLabel = PaddedLabel(padding: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14))
    
    var dateLabel = UILabel()
    
    var modifyButton = UIButton()
    
    var deleteButton = UIButton()
    
    var upperView = UIView()
    
    var commentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.addSubview(upperView)
        self.upperView.then {
            $0.backgroundColor = .white
            $0.setShadow(opacity: 0.25, color: .lightGray)
        }.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
        }
        
        self.upperView.addSubview(dateLabel)
        self.dateLabel.then {
            $0.font = .defaultFont(size: 12, boldLevel: .light)
            $0.textColor = .mainColor
            $0.text = "2022/02/15 12:13"
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(26.adjustedHeight)
            $0.bottom.equalToSuperview().inset(12.adjustedHeight)
        }
        
        self.upperView.addSubview(bookTitleLabel)
        self.bookTitleLabel.then {
            $0.font = .defaultFont(size: 14, boldLevel: .bold)
            $0.textColor = .white
            $0.backgroundColor = .mainColor
            $0.setCornerRadius(radius: 10.adjustedHeight)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
            $0.height.equalTo(35.adjustedHeight)
            $0.top.equalToSuperview().inset(20.adjustedHeight)
            $0.bottom.equalTo(dateLabel.snp.top).offset(-13.adjustedHeight)
        }
        
        self.upperView.addSubview(deleteButton)
        self.deleteButton.then {
            $0.makeBorder(color: UIColor.mainPink.cgColor, width: 1, cornerRadius: 10.5.adjustedHeight)
            $0.setTitle("삭제", for: .normal)
            $0.setTitleColor(.mainPink, for: .normal)
            $0.titleLabel?.font = .defaultFont(size: 10, boldLevel: .regular)
        }.snp.makeConstraints {
            $0.right.equalToSuperview().inset(30.adjustedHeight)
            $0.centerY.equalTo(dateLabel)
            $0.width.equalTo(37.adjustedHeight)
            $0.height.equalTo(21.adjustedHeight)
        }
        
        self.upperView.addSubview(modifyButton)
        self.modifyButton.then {
            $0.makeBorder(color: UIColor.mainColor.cgColor, width: 1, cornerRadius: 10.5.adjustedHeight)
            $0.setTitle("수정하기", for: .normal)
            $0.setTitleColor(.mainColor, for: .normal)
            $0.titleLabel?.font = .defaultFont(size: 10, boldLevel: .regular)
        }.snp.makeConstraints {
            $0.right.equalTo(deleteButton.snp.left).offset(-6.adjustedHeight)
            $0.centerY.equalTo(dateLabel)
            $0.width.equalTo(55.adjustedHeight)
            $0.height.equalTo(21.adjustedHeight)
        }
        
        self.addSubview(commentCollectionView)
        self.commentCollectionView.then {
//            _ = ($0.collectionViewLayout as! UICollectionViewFlowLayout).then {
////                $0.sectionInset = UIEdgeInsets(top: 18.0.adjustedHeight, left: 0, bottom: 0, right: 0)
//                $0.estimatedItemSize = CGSize(width: Constants.screenSize.width - 40.0.adjustedHeight, height: 120.adjustedHeight)
//            }
            $0.bounces = false
            $0.register(BookclubPostHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BookclubPostHeaderView.identifier)
            $0.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.identifier)
            $0.backgroundColor = UIColor(hexString: "EFF0F3")
        }.snp.makeConstraints {
            $0.top.equalTo(self.upperView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
