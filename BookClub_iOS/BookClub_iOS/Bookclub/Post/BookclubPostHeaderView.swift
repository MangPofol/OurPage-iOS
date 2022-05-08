//
//  BookclubPostHeaderView.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/05/08.
//

import UIKit

class BookclubPostHeaderView: UICollectionReusableView {
    static let identifier = "BookclubPostHeaderView"
    
    var postTitleLabel = UILabel()
    
    var postContentTextView = UITextView()
    
    var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var imagePageControl = UIPageControl()
    
    var placeView = WriteSettingItemView()
    
    var timeView = WriteSettingItemView()
    
    var linkView = WriteSettingItemView()
    
    private var contentView = UIView()
    
    var lineView = UIView()
    private var likeCommentStackView = UIStackView()
    private var likeImageView = UIImageView()
    var likeCountLabel = UILabel()
    private var commentImageView = UIImageView()
    var commentCountLabel = UILabel()
    
    var post: PostModel? {
        didSet {
            guard let post = self.post else { return }
            
            self.postTitleLabel.text = post.title
            self.postContentTextView.text = post.content
            self.placeView.label.text = post.location
            self.timeView.label.text = post.readTime
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
            let underlineAttributedString = NSAttributedString(string: post.linkResponseDtos.first?.hyperlinkTitle ?? "", attributes: underlineAttribute)
            self.linkView.label.attributedText = underlineAttributedString
            self.likeCountLabel.text = "\(post.likedList.count)"
            self.commentCountLabel.text = "\(post.commentsDto.count)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(contentView)
        self.contentView.then {
            $0.backgroundColor = .white
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.contentView.addSubview(postTitleLabel)
        self.postTitleLabel.then {
            $0.font = .defaultFont(size: 16, boldLevel: .bold)
            $0.textColor = .mainColor
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17.adjustedHeight)
            $0.left.equalToSuperview().inset(24.adjustedHeight)
        }
        
        self.contentView.addSubview(postContentTextView)
        self.postContentTextView.then {
            $0.isUserInteractionEnabled = false
            $0.backgroundColor = .white
            $0.font = .defaultFont(size: 14, boldLevel: .light)
            $0.textColor = UIColor(hexString: "646A88")
            $0.isScrollEnabled = false
            $0.textContainerInset = .zero
            $0.textContainer.lineFragmentPadding = 0.0
        }.snp.makeConstraints {
            $0.top.equalTo(postTitleLabel.snp.bottom).offset(22.adjustedHeight)
            $0.left.right.equalToSuperview().inset(24.adjustedHeight)
        }
        
        self.contentView.addSubview(imageCollectionView)
        self.imageCollectionView.then {
            $0.backgroundColor = .white
            $0.register(PostImageCell.self, forCellWithReuseIdentifier: PostImageCell.identifier)
            $0.isScrollEnabled = true
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = false
            _ = ($0.collectionViewLayout as! UICollectionViewFlowLayout).then { flowLayout in
                flowLayout.sectionInset = .zero
                flowLayout.minimumInteritemSpacing = 0
                flowLayout.minimumLineSpacing = 0
                flowLayout.scrollDirection = .horizontal
                flowLayout.itemSize = CGSize(width: 335.adjustedHeight, height: 335.adjustedHeight)
            }
        }.snp.makeConstraints {
            $0.top.equalTo(postContentTextView.snp.bottom).offset(50.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335.adjustedHeight)
            $0.height.equalTo(335.adjustedHeight)
        }
        
        self.contentView.addSubview(imagePageControl)
        self.imagePageControl.then {
            $0.pageIndicatorTintColor = UIColor(hexString: "FFFFFF").withAlphaComponent(0.5)
            $0.currentPageIndicatorTintColor  = UIColor(hexString: "FFFFFF")
            $0.currentPage = 0
            $0.hidesForSinglePage = true
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(imageCollectionView).offset(-15.7.adjustedHeight)
        }
        
        self.contentView.addSubview(placeView)
        self.placeView.then {
            $0.iconView.image = .PlaceIcon.withRenderingMode(.alwaysTemplate)
        }.snp.makeConstraints {
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(16.adjustedHeight)
            $0.right.equalTo(self).inset(23.adjustedHeight)
        }
        
        self.contentView.addSubview(timeView)
        self.timeView.then {
            $0.iconView.image = .ClockIcon.withRenderingMode(.alwaysTemplate)
        }.snp.makeConstraints {
            $0.top.equalTo(placeView.snp.bottom).offset(16.adjustedHeight)
            $0.right.equalTo(self).inset(23.adjustedHeight)
        }
        
        self.contentView.addSubview(linkView)
        self.linkView.then {
            $0.iconView.image = .LinkIcon.withRenderingMode(.alwaysTemplate)
            $0.isUserInteractionEnabled = true
        }.snp.makeConstraints {
            $0.top.equalTo(timeView.snp.bottom).offset(16.adjustedHeight)
            $0.right.equalTo(self).inset(23.adjustedHeight)
        }
        
        self.contentView.addSubview(lineView)
        self.lineView.then {
            $0.backgroundColor = UIColor(hexString: "C3C5D1")
        }.snp.makeConstraints {
            $0.height.equalTo(1.0)
            $0.left.right.equalToSuperview().inset(20.0)
            $0.top.equalTo(self.linkView.snp.bottom).offset(13.adjustedHeight)
        }
        
        self.contentView.addSubview(likeCommentStackView)
        self.likeCommentStackView.then {
            $0.axis = .horizontal
            $0.spacing = 7.0.adjustedHeight
        }.snp.makeConstraints {
            $0.height.equalTo(17.0.adjustedHeight)
            $0.top.equalTo(self.lineView.snp.bottom).offset(12.0.adjustedHeight)
            $0.left.equalTo(self.lineView)
            $0.bottom.equalToSuperview().inset(13.0.adjustedHeight)
        }
        
        self.likeCommentStackView.addArrangedSubview(likeImageView)
        self.likeImageView.then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "LikeImage")
        }.snp.makeConstraints {
            $0.width.equalTo(16.0.adjustedHeight)
        }
        
        self.likeCommentStackView.addArrangedSubview(likeCountLabel)
        _ = self.likeCountLabel.then {
            $0.font = .defaultFont(size: 12.0, boldLevel: .bold)
            $0.textColor = .mainPink
            $0.text = "0"
        }
        
        self.likeCommentStackView.setCustomSpacing(11.0, after: self.likeCountLabel)
        self.likeCommentStackView.addArrangedSubview(commentImageView)
        self.commentImageView.then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "CommentImage")
        }.snp.makeConstraints {
            $0.width.equalTo(17.0.adjustedHeight)
        }
        
        self.likeCommentStackView.addArrangedSubview(commentCountLabel)
        _ = self.commentCountLabel.then {
            $0.font = .defaultFont(size: 12.0, boldLevel: .bold)
            $0.textColor = .mainPink
            $0.text = "0"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
