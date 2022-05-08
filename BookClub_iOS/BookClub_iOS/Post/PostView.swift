//
//  PostView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/28.
//

import UIKit

final class PostView: UIView {
    var bookTitleLabel = PaddedLabel(padding: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)).then {
        $0.font = .defaultFont(size: 14, boldLevel: .bold)
        $0.textColor = .white
        $0.backgroundColor = .mainColor
        $0.setCornerRadius(radius: 10.adjustedHeight)
    }
    
    var dateLabel = UILabel().then {
        $0.font = .defaultFont(size: 12, boldLevel: .light)
        $0.textColor = .mainColor
        $0.text = "2022/02/15 12:13"
    }
    
    var modifyButton = UIButton().then {
        $0.makeBorder(color: UIColor.mainColor.cgColor, width: 1, cornerRadius: 10.5.adjustedHeight)
        $0.setTitle("수정하기", for: .normal)
        $0.setTitleColor(.mainColor, for: .normal)
        $0.titleLabel?.font = .defaultFont(size: 10, boldLevel: .regular)
    }
    
    var deleteButton = UIButton().then {
        $0.makeBorder(color: UIColor.mainPink.cgColor, width: 1, cornerRadius: 10.5.adjustedHeight)
        $0.setTitle("삭제", for: .normal)
        $0.setTitleColor(.mainPink, for: .normal)
        $0.titleLabel?.font = .defaultFont(size: 10, boldLevel: .regular)
    }
    
    lazy var upperView = UIView().then {
        $0.backgroundColor = .white
        $0.addSubview(bookTitleLabel)
        $0.addSubview(dateLabel)
        $0.addSubview(modifyButton)
        $0.addSubview(deleteButton)
        $0.setShadow(opacity: 0.25, color: .lightGray)
    }
    
    var postTitleLabel = UILabel().then {
        $0.font = .defaultFont(size: 16, boldLevel: .bold)
        $0.textColor = .mainColor
    }
    
    var postContentTextView = UITextView().then {
        $0.isUserInteractionEnabled = false
        $0.backgroundColor = .white
        $0.font = .defaultFont(size: 14, boldLevel: .light)
        $0.textColor = UIColor(hexString: "646A88")
        $0.isScrollEnabled = false
        $0.textContainerInset = .zero
        $0.textContainer.lineFragmentPadding = 0.0
    }
    
    var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .white
        $0.register(PostImageCell.self, forCellWithReuseIdentifier: PostImageCell.identifier)
        $0.isScrollEnabled = true
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    var imagePageControl = UIPageControl().then {
        $0.pageIndicatorTintColor = UIColor(hexString: "FFFFFF").withAlphaComponent(0.5)
        $0.currentPageIndicatorTintColor  = UIColor(hexString: "FFFFFF")
        $0.currentPage = 0
        $0.hidesForSinglePage = true
    }
    
    var placeView = WriteSettingItemView().then {
        $0.iconView.image = .PlaceIcon.withRenderingMode(.alwaysTemplate)
    }
    
    var timeView = WriteSettingItemView().then {
        $0.iconView.image = .ClockIcon.withRenderingMode(.alwaysTemplate)
    }
    
    var linkView = WriteSettingItemView().then {
        $0.iconView.image = .LinkIcon.withRenderingMode(.alwaysTemplate)
        $0.isUserInteractionEnabled = true
    }
    
    var contentsView = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
    
        self.addSubview(contentsView)
        self.addSubview(upperView)
    }
    
    func makeView() {
        // upperView {
        upperView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(26.adjustedHeight)
            $0.bottom.equalToSuperview().inset(12.adjustedHeight)
        }
        
        deleteButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(30.adjustedHeight)
            $0.centerY.equalTo(dateLabel)
            $0.width.equalTo(37.adjustedHeight)
            $0.height.equalTo(21.adjustedHeight)
        }
        
        modifyButton.snp.makeConstraints {
            $0.right.equalTo(deleteButton.snp.left).offset(-6.adjustedHeight)
            $0.centerY.equalTo(dateLabel)
            $0.width.equalTo(55.adjustedHeight)
            $0.height.equalTo(21.adjustedHeight)
        }

        bookTitleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
            $0.height.equalTo(35.adjustedHeight)
            $0.top.equalToSuperview().inset(20.adjustedHeight)
            $0.bottom.equalTo(dateLabel.snp.top).offset(-13.adjustedHeight)
        }
        // }
        
        contentsView.then {
            $0.backgroundColor = .white
            
            $0.addSubview(postTitleLabel)
            $0.addSubview(postContentTextView)
            $0.addSubview(imageCollectionView)
            $0.addSubview(imagePageControl)
            $0.addSubview(placeView)
            $0.addSubview(timeView)
            $0.addSubview(linkView)
        }.snp.makeConstraints { [unowned self] in
            $0.top.equalTo(upperView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        postTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17.adjustedHeight)
            $0.left.equalToSuperview().inset(24.adjustedHeight)
        }
        
        postContentTextView.snp.makeConstraints {
            $0.top.equalTo(postTitleLabel.snp.bottom).offset(22.adjustedHeight)
            $0.left.right.equalToSuperview().inset(24.adjustedHeight)
        }
        
        imageCollectionView.snp.makeConstraints {
            $0.top.equalTo(postContentTextView.snp.bottom).offset(50.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335.adjustedHeight)
            $0.height.equalTo(335.adjustedHeight)
        }
        
        imagePageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(imageCollectionView).offset(-15.7.adjustedHeight)
        }
        
        placeView.snp.makeConstraints {
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(16.adjustedHeight)
            $0.right.equalTo(self).inset(23.adjustedHeight)
        }
        
        timeView.snp.makeConstraints {
            $0.top.equalTo(placeView.snp.bottom).offset(16.adjustedHeight)
            $0.right.equalTo(self).inset(23.adjustedHeight)
        }
        
        linkView.snp.makeConstraints {
            $0.top.equalTo(timeView.snp.bottom).offset(16.adjustedHeight)
            $0.right.equalTo(self).inset(23.adjustedHeight)
            $0.bottom.equalToSuperview().inset(43.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class PostImageCell: UICollectionViewCell {
    static let identifier = "PostImageCell"
    
    var imageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.kf.indicatorType = .activity
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(imageView)
        self.contentView.backgroundColor = .white
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class WriteSettingItemView: UIView {
    var label = UILabel().then {
        $0.font = .defaultFont(size: 12, boldLevel: .regular)
        $0.text = "-"
        $0.textAlignment = .right
        $0.textColor = .mainColor
    }
    
    var iconView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .mainColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(label)
        self.addSubview(iconView)
        
        iconView.snp.makeConstraints {
            $0.width.height.equalTo(13.adjustedHeight)
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview()
        }
        label.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalTo(iconView.snp.left).offset(-9.adjustedWidth)
            $0.centerY.equalTo(iconView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
