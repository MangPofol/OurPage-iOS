//
//  WriteSettingView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/20.
//

import UIKit

final class WriteSettingView: UIView {
    var placeTitleLabel = UILabel().then {
        $0.text = "어디서 책을 읽었나요?"
        $0.font = .defaultFont(size: 14, boldLevel: .semiBold)
        $0.textColor = .mainColor
    }
    
    var placeTextField = TextFieldWithPadding(padding: UIEdgeInsets(top: 6.adjustedHeight, left: 27.adjustedHeight, bottom: 6.adjustedHeight, right: 0), frame: .zero).then {
        $0.placeholder = "내용을 입력해주세요"
        $0.font = .defaultFont(size: 12, boldLevel: .regular)
        $0.textColor = .mainColor
        $0.backgroundColor = .white

        $0.leftView = .iconWithPaddingView(iconImage: .PlaceIcon, tintColor: .mainColor, paddingDirection: .Left, padding: 10.adjustedHeight, iconSize: CGSize(width: 9.43.adjustedHeight, height: 12.adjustedHeight))
        $0.leftViewMode = .always
        
        $0.setCornerRadius(radius: 15.adjustedHeight)
    }
    
    private lazy var placeStackView = UIStackView(arrangedSubviews: [placeTitleLabel, placeTextField]).then {
        $0.axis = .vertical
        $0.spacing = 8.adjustedHeight

        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.setCornerRadius(radius: 10.adjustedHeight)

        $0.layoutMargins = UIEdgeInsets(top: 10.adjustedHeight, left: 16.adjustedHeight, bottom: 13.adjustedHeight, right: 17.adjustedHeight)
        $0.isLayoutMarginsRelativeArrangement = true
    }
    
    var timeTitleLabel = UILabel().then {
        $0.text = "책 읽은 시간대는?"
        $0.font = .defaultFont(size: 14, boldLevel: .semiBold)
        $0.textColor = .mainColor
    }
    
    var timeTextField = TextFieldWithPadding(padding: UIEdgeInsets(top: 6.adjustedHeight, left: 27.adjustedHeight, bottom: 6.adjustedHeight, right: 0), frame: .zero).then {
        $0.placeholder = "점심시간 / 13:34"
        $0.font = .defaultFont(size: 12, boldLevel: .regular)
        $0.textColor = .mainColor
        $0.backgroundColor = .white

        $0.leftView = .iconWithPaddingView(iconImage: .ClockIcon, tintColor: .mainColor, paddingDirection: .Left, padding: 10.adjustedHeight, iconSize: CGSize(width: 9.97.adjustedHeight, height: 9.63.adjustedHeight))
        $0.leftViewMode = .always
        
        $0.setCornerRadius(radius: 15.adjustedHeight)
    }
    
    private lazy var timeStackView = UIStackView(arrangedSubviews: [timeTitleLabel, timeTextField]).then {
        $0.axis = .vertical
        $0.spacing = 8.adjustedHeight

        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.setCornerRadius(radius: 10.adjustedHeight)

        $0.layoutMargins = UIEdgeInsets(top: 10.adjustedHeight, left: 16.adjustedHeight, bottom: 13.adjustedHeight, right: 17.adjustedHeight)
        $0.isLayoutMarginsRelativeArrangement = true
    }
    
    var linkTitleLabel = UILabel().then {
        $0.text = "함께 첨부하고 싶은 링크가 있다면?"
        $0.font = .defaultFont(size: 14, boldLevel: .semiBold)
        $0.textColor = .mainColor
    }
    
    var linkTitleTextField = TextFieldWithPadding(padding: UIEdgeInsets(top: 6.adjustedHeight, left: 27.adjustedHeight, bottom: 6.adjustedHeight, right: 0), frame: .zero).then {
        $0.placeholder = "링크 제목"
        $0.font = .defaultFont(size: 10, boldLevel: .regular)
        $0.textColor = .mainColor
        $0.backgroundColor = .white

        $0.leftView = .iconWithPaddingView(iconImage: .LinkIcon, tintColor: .mainColor, paddingDirection: .Left, padding: 10.adjustedHeight, iconSize: CGSize(width: 13.adjustedHeight, height: 13.adjustedHeight))
        $0.leftViewMode = .always
    }
    
    var linkContentTextField = TextFieldWithPadding(padding: UIEdgeInsets(top: 6.adjustedHeight, left: 27.adjustedHeight, bottom: 6.adjustedHeight, right: 0), frame: .zero).then {
        $0.placeholder = "https://링크"
        $0.font = .defaultFont(size: 12, boldLevel: .regular)
        $0.textColor = .mainColor
        $0.backgroundColor = .white
    }
    
    private lazy var linkContainerStack = UIStackView(arrangedSubviews: [linkTitleTextField, linkContentTextField]).then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.backgroundColor = .white
        $0.setCornerRadius(radius: 10.adjustedHeight)
    }
    
    private lazy var linkStackView = UIStackView(arrangedSubviews: [linkTitleLabel, linkContainerStack]).then {
        $0.axis = .vertical
        $0.spacing = 8.adjustedHeight

        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.setCornerRadius(radius: 10.adjustedHeight)

        $0.layoutMargins = UIEdgeInsets(top: 10.adjustedHeight, left: 16.adjustedHeight, bottom: 13.adjustedHeight, right: 17.adjustedHeight)
        $0.isLayoutMarginsRelativeArrangement = true
    }
    
    var scopeTitleLabel = UILabel().then {
        $0.text = "공개설정"
        $0.font = .defaultFont(size: 14, boldLevel: .semiBold)
        $0.textColor = .white
        $0.backgroundColor = .mainPink
    }
    
    var scopeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .mainPink
        $0.register(ScopeCollectionViewCell.self, forCellWithReuseIdentifier: ScopeCollectionViewCell.identifier)
        $0.allowsMultipleSelection = true
        $0.snp.contentHuggingVerticalPriority = .infinity
    }
    
    private lazy var scopeStackView = UIStackView(arrangedSubviews: [scopeTitleLabel, scopeCollectionView]).then {
        $0.axis = .vertical
        $0.spacing = 8.adjustedHeight
        
        $0.distribution = .fillEqually
        
        $0.backgroundColor = .mainPink
        $0.setCornerRadius(radius: 10.adjustedHeight)

        $0.layoutMargins = UIEdgeInsets(top: 10.adjustedHeight, left: 16.adjustedHeight, bottom: 13.adjustedHeight, right: 17.adjustedHeight)
        $0.isLayoutMarginsRelativeArrangement = true
        $0.isHidden = true
    }
    
    private lazy var contentsStackView = UIStackView(arrangedSubviews: [placeStackView, timeStackView, linkStackView]).then {
        $0.axis = .vertical
        $0.spacing = 11.adjustedHeight
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(contentsStackView)
        self.addSubview(scopeStackView)
        
        makeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeView() {
        contentsStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedWidth)
        }
        scopeStackView.snp.makeConstraints {
            $0.top.equalTo(contentsStackView.snp.bottom).offset(11.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedWidth)
            $0.height.equalTo(90.adjustedHeight)
        }
    }
}

final class ScopeCollectionViewCell: UICollectionViewCell {
    static let identifier = "ScopeCollectionViewCell"
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.contentView.backgroundColor = .white
                self.titleLabel.textColor = UIColor(hexString: "C3C5D1")
                self.titleLabel.font = .defaultFont(size: 10, boldLevel: .bold)
            } else {
                self.contentView.backgroundColor = .mainPink
                self.titleLabel.textColor = .white
                self.titleLabel.font = .defaultFont(size: 10, boldLevel: .medium)
            }
        }
    }

    var titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .defaultFont(size: 10, boldLevel: .medium)
    }
    
    func configure(name: String?) {
        titleLabel.text = name
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .mainPink
        self.contentView.makeBorder(color: UIColor.white.cgColor, width: 1, cornerRadius: 10.adjustedHeight)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(5)
            $0.left.right.equalToSuperview().inset(15)
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()

        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)

        var frame = layoutAttributes.frame
        frame.size.height = 28.0.adjustedHeight
        frame.size.width = ceil(size.width)

        layoutAttributes.frame = frame
//        self.layer.cornerRadius = 10.0 / min(frame.width, frame.height)
        self.layer.cornerRadius = 10.0.adjustedHeight
        self.layer.masksToBounds = true
        return layoutAttributes
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
