//
//  BookclubBooksView.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/04/13.
//

import UIKit
import RxSwift

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
                $0.sectionInset = UIEdgeInsets(top: 0, left: 15.0.adjustedHeight, bottom: 0, right: 0)
            }
            $0.showsHorizontalScrollIndicator = false
            $0.register(BookclubBooksCell.self, forCellWithReuseIdentifier: BookclubBooksCell.identifier)
            $0.backgroundColor = UIColor(hexString: "EFF0F3")
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
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
    
    var thumbnailImageView = UIImageView()
    var bookTitleLabel = UILabel()
    var ownerLabel = UILabel()
    
    var disposeBag = DisposeBag()
    
    var bookclubBook: BookclubBook? {
        didSet {
            if let bookclubBook = self.bookclubBook {
                self.bookTitleLabel.text = bookclubBook.bookName
                self.ownerLabel.text = bookclubBook.userNickname
                self.getThumbnailImage(isbn: bookclubBook.isbn)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(thumbnailImageView)
        thumbnailImageView.then {
            $0.contentMode = .scaleAspectFit
            $0.setCornerRadius(radius: 9.36.adjustedHeight)
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
            $0.textAlignment = .center
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(1.0)
        }
    }
    
    func getThumbnailImage(isbn: String) {
        if let isbn = isbn.components(separatedBy: " ").first {
            SearchServices.getThumbnailBy(isbn: isbn)
                .observe(on: MainScheduler.instance)
                .compactMap { $0 }
                .bind { [weak self] in
                    self?.thumbnailImageView.kf.setImage(with: URL(string: $0), placeholder: UIImage(named: "DefaultBookImage"))
                }
                .disposed(by: disposeBag)
        }
    }
    
    override func prepareForReuse() {
        self.disposeBag = DisposeBag()
        self.thumbnailImageView.image = UIImage(named: "DefaultBookImage")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
