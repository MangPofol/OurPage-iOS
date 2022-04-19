//
//  BookclubBooksView.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/04/13.
//

import UIKit

final class BookclubBooksView: UIView {
    var titleLabel = UILabel()
    var moreButtonImageView = UIImageView()
    var bookCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var emptyLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hexString: "EFF0F3")
        self.setCornerRadius(radius: 10.0.adjustedHeight)
        
        self.addSubview(titleLabel)
        self.titleLabel.then {
            $0.font = .defaultFont(size: 14.0, boldLevel: .semiBold)
            $0.textColor = .mainColor
            $0.text = "Club Books"
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(18.25.adjustedHeight)
            $0.top.equalToSuperview().inset(12.5.adjustedHeight)
        }
        
        self.addSubview(moreButtonImageView)
        self.moreButtonImageView.then {
            $0.image = UIImage(named: "BookclubBooksMoreButtonImage")
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15.78.adjustedHeight)
            $0.right.equalToSuperview().inset(16.0.adjustedHeight)
            $0.width.equalTo(36.adjustedHeight)
            $0.height.equalTo(15.adjustedHeight)
        }
        
        self.addSubview(bookCollectionView)
        self.bookCollectionView.then {
            _ = (bookCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).then {
                $0.itemSize = CGSize(width: 61.0, height: 119.0).resized(basedOn: .height)
                $0.minimumInteritemSpacing = 14.0.adjustedHeight
                $0.scrollDirection = .horizontal
            }
            $0.showsHorizontalScrollIndicator = false
            $0.register(BookclubBooksCell.self, forCellWithReuseIdentifier: BookclubBooksCell.identifier)
            $0.backgroundColor = UIColor(hexString: "EFF0F3")
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(6.0.adjustedHeight)
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10.0.adjustedHeight)
            $0.height.equalTo(120.adjustedHeight)
        }
        
        self.addSubview(emptyLabel)
        emptyLabel.then {
            $0.font = .defaultFont(size: 14.0, boldLevel: .regular)
            $0.textColor = UIColor(hexString: "C3C5D1")
            $0.text = "클럽원들의 메모가 없습니다"
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class BookclubBooksCell: UICollectionViewCell {
    static let identifier = "BookclubBooksCell"
    
    // TODO: 북클럽 책 셀 구현 / BookclubBook 모델을 받아서 각 셀에서 검색 날려서 썸네일 이미지 가져오기
    var thumbnailImageView = UIImageView()
    var bookTitleLabel = UILabel()
    var ownerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(thumbnailImageView)
        thumbnailImageView.then {
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(60.adjustedHeight)
            $0.height.equalTo(90.adjustedHeight)
        }
        
        self.contentView.addSubview(bookTitleLabel)
        bookTitleLabel.then {
            $0.font = .defaultFont(size: 10.0, boldLevel: .regular)
            $0.textColor = .mainColor
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(6.0.adjustedHeight)
        }
        
        self.contentView.addSubview(ownerLabel)
        ownerLabel.then {
            $0.font = .defaultFont(size: 8.0, boldLevel: .regular)
            $0.textColor = .mainColor.withAlphaComponent(0.5)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(1.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
