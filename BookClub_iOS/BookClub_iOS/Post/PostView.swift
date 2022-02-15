//
//  PostView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/28.
//

import UIKit

final class PostView: UIView {
    var bookTitleLabel = UILabel().then {
        $0.font = .defaultFont(size: 14, boldLevel: .bold)
        $0.textColor = .mainColor
    }
    
    private var titleUnderLineView = UIView().then {
        $0.backgroundColor = .mainColor
    }
    
    lazy var upperView = UIView().then {
        $0.backgroundColor = .white
        $0.addSubview(bookTitleLabel)
        $0.addSubview(titleUnderLineView)
        $0.setShadow(opacity: 0.5, color: .lightGray)
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
    }
    
    var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .white
        $0.register(PostImageCell.self, forCellWithReuseIdentifier: PostImageCell.identifier)
        $0.isScrollEnabled = false
    }
    
    var placeView = WriteSettingItemView().then {
        $0.iconView.image = .PlaceIcon.withRenderingMode(.alwaysTemplate)
    }
    
    var timeView = WriteSettingItemView().then {
        $0.iconView.image = .ClockIcon.withRenderingMode(.alwaysTemplate)
    }
    
    var linkView = WriteSettingItemView().then {
        $0.iconView.image = .LinkIcon.withRenderingMode(.alwaysTemplate)
    }
    
    private lazy var settingStackView = UIStackView(arrangedSubviews: [placeView, timeView, linkView]).then {
        $0.axis = .vertical
        $0.spacing = 16.adjustedHeight
        $0.alignment = .trailing
    }
    
    private lazy var contentsView = UIScrollView().then {
        $0.backgroundColor = .white
        
        $0.addSubview(postTitleLabel)
        $0.addSubview(postContentTextView)
        $0.addSubview(imageCollectionView)
        $0.addSubview(settingStackView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
    
        self.addSubview(contentsView)
        self.addSubview(upperView)
    
        makeView()
    }
    
    private func makeView() {
        upperView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(63.adjustedHeight)
        }
        titleUnderLineView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.adjustedWidth)
            $0.height.equalTo(2)
            $0.bottom.equalToSuperview().inset(22.adjustedHeight)
        }
        bookTitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(30.adjustedWidth)
            $0.bottom.equalTo(titleUnderLineView.snp.top).offset(-5.5.adjustedHeight)
        }
        
        contentsView.snp.makeConstraints { [unowned self] in
            $0.top.equalTo(upperView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        postTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17.adjustedHeight)
            $0.left.equalToSuperview().inset(24.adjustedWidth)
        }
        
        postContentTextView.snp.makeConstraints {
            $0.top.equalTo(postTitleLabel.snp.bottom).offset(24.5.adjustedHeight)
            $0.left.right.equalToSuperview().inset(24.adjustedWidth)
        }
        
        imageCollectionView.snp.makeConstraints {
            $0.top.equalTo(postContentTextView.snp.bottom).offset(50.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335.adjustedWidth)
            $0.height.equalTo(335.adjustedHeight)
        }
        
        settingStackView.snp.makeConstraints {
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(14.adjustedHeight)
            $0.width.equalTo(335.adjustedWidth)
//            $0.right.equalToSuperview().inset(5.adjustedWidth)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
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
        $0.textColor = UIColor(hexString: "C3C5D1")
    }
    
    var iconView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = UIColor(hexString: "C3C5D1")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(label)
        self.addSubview(iconView)
        
        iconView.snp.makeConstraints {
            $0.width.height.equalTo(13.adjustedHeight)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(5.adjustedWidth)
        }
        label.snp.makeConstraints {
            $0.right.equalTo(iconView.snp.left).offset(-9.adjustedWidth)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
