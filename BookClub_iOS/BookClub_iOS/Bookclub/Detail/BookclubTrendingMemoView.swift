//
//  BookclubTrendingMemoView.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/05/04.
//

import UIKit

final class BookclubTrendingMemoView: UIView {
    var titleLabel = UILabel()
    var trendingMemoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var emptyLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(hexString: "EFF0F3")
        self.setCornerRadius(radius: 10.0.adjustedHeight)
        
        self.addSubview(titleLabel)
        self.titleLabel.then {
            $0.font = .defaultFont(size: 14.0, boldLevel: .semiBold)
            $0.textColor = .mainColor
            $0.text = "Trending Memo"
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(18.25.adjustedHeight)
            $0.top.equalToSuperview().inset(12.5.adjustedHeight)
        }
        
        self.addSubview(trendingMemoCollectionView)
        self.trendingMemoCollectionView.then {
            _ = (trendingMemoCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).then {
                $0.itemSize = CGSize(width: 301.0, height: 74.0).resized(basedOn: .height)
                $0.minimumInteritemSpacing = 15.0
                $0.scrollDirection = .vertical
            }
            $0.backgroundColor = UIColor(hexString: "EFF0F3")
            $0.register(BookclubTrendingMemoCell.self, forCellWithReuseIdentifier: BookclubTrendingMemoCell.identifier)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(10.0.adjustedHeight)
            $0.bottom.equalToSuperview().inset(10.0.adjustedHeight)
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

final class BookclubTrendingMemoCell: UICollectionViewCell {
    static let identifier = "BookclubTrendingMemoCell"
    
    var profileImageView = UIImageView()
    var nicknameLabel = UILabel()
    var titleLabel = UILabel()
    var contentLabel = UILabel()
    var bookLabel = UILabel()
    private var lineView = UIView()
    
    private var likeCommentStackView = UIStackView()
    var likeImageView = UIImageView()
    var likeLabel = UILabel()
    var commentImageView = UIImageView()
    var commentLabel = UILabel()
    
    var clubPost: ClubPost? {
        didSet {
            guard let clubPost = clubPost else { return }
            self.profileImageView.kf.setImage(with: URL(string: clubPost.profileImgLocation))
            self.nicknameLabel.text = clubPost.nickname
            self.titleLabel.text = clubPost.post.title
            self.commentLabel.text = clubPost.post.content
            self.bookLabel.text = clubPost.bookName
            self.likeLabel.text = "\(clubPost.post.likedList.count)"
            self.commentLabel.text = "\(clubPost.post.commentsDto.count)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = .white
        self.contentView.setCornerRadius(radius: 15.0.adjustedHeight)
        
        self.contentView.addSubview(profileImageView)
        self.profileImageView.then {
            $0.setCornerRadius(radius: 18.0.adjustedHeight)
        }.snp.makeConstraints {
            $0.width.height.equalTo(36.0.adjustedHeight)
            $0.top.equalToSuperview().inset(13.0.adjustedHeight)
            $0.left.equalToSuperview().inset(17.0.adjustedHeight)
        }
        
        self.contentView.addSubview(nicknameLabel)
        self.nicknameLabel.then {
            $0.font = .defaultFont(size: 8.0, boldLevel: .light)
            $0.textColor = .mainColor
            $0.text = "홍길동"
        }.snp.makeConstraints {
            $0.centerX.equalTo(self.profileImageView)
            $0.top.equalTo(self.profileImageView.snp.bottom).offset(4.0.adjustedHeight)
        }
        
        self.contentView.addSubview(titleLabel)
        self.titleLabel.then {
            $0.font = .defaultFont(size: 12.0, boldLevel: .bold)
            $0.textColor = .mainColor
        }.snp.makeConstraints {
            $0.top.equalTo(self.profileImageView)
            $0.left.equalTo(self.profileImageView.snp.right).offset(16.0.adjustedHeight)
            $0.right.equalToSuperview().inset(17.0.adjustedHeight)
        }
        
        self.contentView.addSubview(contentLabel)
        self.contentLabel.then {
            $0.font = .defaultFont(size: 10.0, boldLevel: .light)
            $0.textColor = UIColor(hexString: "646A88")
            $0.text = "한지가 왜 영주랑 사이가 소원해졌을까? 아아 마도 ..."
        }.snp.makeConstraints {
            $0.left.right.equalTo(self.titleLabel)
//            $0.top.equalTo(self.titleLabel.snp.bottom).offset(5.0.adjustedHeight)
            $0.top.equalTo(self.profileImageView.snp.centerY)
        }
        
        self.contentView.addSubview(lineView)
        self.lineView.then {
            $0.backgroundColor = UIColor(hexString: "C3C5D1")
        }.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.bottom.equalTo(self.profileImageView)
            $0.left.right.equalTo(self.contentLabel)
        }
        
        self.contentView.addSubview(bookLabel)
        self.contentView.addSubview(likeCommentStackView)
        self.bookLabel.then {
            $0.font = .defaultFont(size: 10.0, boldLevel: .light)
            $0.textColor = UIColor(hexString: "C3C5D1")
        }.snp.makeConstraints {
            $0.top.equalTo(self.nicknameLabel)
            $0.left.equalTo(self.lineView)
            $0.right.equalTo(self.likeCommentStackView).offset(-15.0.adjustedHeight)
        }
        
        self.likeCommentStackView.then {
            $0.axis = .horizontal
            $0.spacing = 2
        }.snp.makeConstraints {
            $0.height.equalTo(9.0.adjustedHeight)
            $0.centerY.equalTo(self.bookLabel)
            $0.right.equalTo(self.lineView)
        }
        
        self.likeCommentStackView.addArrangedSubview(likeImageView)
        _ = self.likeImageView.then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "LikeImage")
        }
        self.likeCommentStackView.addArrangedSubview(likeLabel)
        _ = self.likeLabel.then {
            $0.font = .defaultFont(size: 8.0, boldLevel: .bold)
            $0.textColor = .mainPink
            $0.text = "0"
        }
        
        self.likeCommentStackView.setCustomSpacing(5.0, after: self.likeLabel)
        self.likeCommentStackView.addArrangedSubview(commentImageView)
        _ = self.commentImageView.then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "CommentImage")
        }
        self.likeCommentStackView.addArrangedSubview(commentLabel)
        _ = self.commentLabel.then {
            $0.font = .defaultFont(size: 8.0, boldLevel: .bold)
            $0.textColor = .mainPink
            $0.text = "0"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
