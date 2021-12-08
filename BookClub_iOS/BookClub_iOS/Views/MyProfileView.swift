//
//  MyProfileView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/02.
//

import UIKit

final class MyProfileView: UIView {
    
    var profileImageView = UIImageView().then {
        $0.setCornerRadius(radius: 30.adjustedHeight)
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "SampleProfile")
    }
    
    var profileImageSettingButton = UIButton().then {
        $0.setImage(.SettingIconWithBackground.resize(to: CGSize(width: 15.adjustedHeight, height: 15.adjustedHeight), isAlwaysTemplate: false), for: .normal)
        $0.backgroundColor = .clear
    }
    
    var nicknameLabel = UILabel().then {
        $0.font = .defaultFont(size: 20, boldLevel: .bold)
        $0.text = "홍길동"
        $0.textColor = .mainColor
    }
    
    var idLabel = UILabel().then {
        $0.font = .defaultFont(size: 12, boldLevel: .regular)
        $0.text = "myidisawsome"
        $0.textColor = .mainColor
    }
    
    var introduceLabel = UILabel().then {
        $0.font = .defaultFont(size: 12, boldLevel: .semiBold)
        $0.text = "저는 책을 좋아하는 사람입니다."
        $0.textColor = .mainColor
        
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.textAlignment = .center
        
        $0.setCornerRadius(radius: 10.adjustedHeight)
    }
    
    
// {
    var tasteTitleLabel = UILabel().then {
        $0.font = .defaultFont(size: 12, boldLevel: .bold)
        $0.text = "책 취향"
        $0.textColor = .mainColor
    }
    
    var genreTitleLabel = UILabel().then {
        $0.font = .defaultFont(size: 10, boldLevel: .bold)
        $0.text = "좋아하는 장르"
        $0.textColor = .mainColor
    }
    
    var genreCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .white
        $0.register(MyGenreCollectionViewCell.self, forCellWithReuseIdentifier: MyGenreCollectionViewCell.identifier)
        $0.allowsSelection = false
    }
    
    var tasteSettingButton = UIButton().then {
        $0.setImage(.RightArrowBoldIcon.resize(to: CGSize(width: 4.28, height: 7).resized(basedOn: .height)), for: .normal)
        $0.backgroundColor = .clear
        $0.tintColor = .mainColor
    }
    
    lazy var genreContainerView = UIView().then {
        $0.addSubview(genreTitleLabel)
        $0.addSubview(genreCollectionView)
        $0.addSubview(tasteSettingButton)
        
        $0.backgroundColor = .white
        $0.setCornerRadius(radius: 10.adjustedHeight)
        
        genreTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14.adjustedHeight)
            $0.left.equalToSuperview().inset(20.adjustedWidth)
        }
        
        genreCollectionView.snp.makeConstraints {
            $0.top.equalTo(genreTitleLabel.snp.bottom).offset(10.adjustedHeight)
            $0.left.equalToSuperview().inset(20.adjustedWidth)
            $0.width.equalTo(239.adjustedWidth)
            $0.height.equalTo(22.adjustedHeight)
            $0.bottom.equalToSuperview().inset(14.adjustedHeight)
        }
        
        tasteSettingButton.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.width.equalTo(32.adjustedWidth)
            $0.height.equalTo(7.adjustedHeight)
            $0.centerY.equalTo(genreCollectionView)
        }
    }

    var readingStyleButton = ButtonWithRightIcon(frame: .zero, image: .RightArrowBoldIcon, title: "책 읽는 스타일", iconPadding: 12.72.adjustedWidth, textPadding: 20.adjustedWidth, iconSize: CGSize(width: 4.28, height: 7).resized(basedOn: .height)).then {
        $0.textLabel.font = .defaultFont(size: 10, boldLevel: .bold)
        $0.textLabel.textColor = .mainColor
        $0.iconView.contentMode = .scaleAspectFit
        $0.backgroundColor = .white
        $0.setCornerRadius(radius: 10.adjustedHeight)
    }
    
    lazy var tasteStackView = UIStackView(arrangedSubviews: [tasteTitleLabel, genreContainerView, readingStyleButton]).then {
        $0.axis = .vertical
        $0.spacing = 10.adjustedHeight
        
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.setCornerRadius(radius: 10.adjustedHeight)
        
        $0.layoutMargins = UIEdgeInsets(top: 14.adjustedHeight, left: 22.adjustedWidth, bottom: 14.adjustedHeight, right: 22.adjustedWidth)
        $0.isLayoutMarginsRelativeArrangement = true
    }
// }
    
// {
    var routineTitleLabel = UILabel().then {
        $0.font = .defaultFont(size: 12, boldLevel: .bold)
        $0.text = "책 루틴"
        $0.textColor = .mainColor
    }
    
    var goalSettingButton = ButtonWithRightIcon(frame: .zero, image: .RightArrowBoldIcon, title: "목표 관리", iconPadding: 12.72.adjustedWidth, textPadding: 20.adjustedWidth, iconSize: CGSize(width: 4.28, height: 7).resized(basedOn: .height)).then {
        $0.textLabel.font = .defaultFont(size: 10, boldLevel: .bold)
        $0.textLabel.textColor = .mainColor
        $0.iconView.contentMode = .scaleAspectFit
        $0.backgroundColor = .white
        $0.setCornerRadius(radius: 10.adjustedHeight)
    }
    
    var checkListSettingButton = ButtonWithRightIcon(frame: .zero, image: .RightArrowBoldIcon, title: "목표 관리", iconPadding: 12.72.adjustedWidth, textPadding: 20.adjustedWidth, iconSize: CGSize(width: 4.28, height: 7).resized(basedOn: .height)).then {
        $0.textLabel.font = .defaultFont(size: 10, boldLevel: .bold)
        $0.textLabel.textColor = .mainColor
        $0.iconView.contentMode = .scaleAspectFit
        $0.backgroundColor = .white
        $0.setCornerRadius(radius: 10.adjustedHeight)
    }
    
    lazy var routineStackView = UIStackView(arrangedSubviews: [routineTitleLabel, goalSettingButton, checkListSettingButton]).then {
        $0.axis = .vertical
        $0.spacing = 10.adjustedHeight
        $0.distribution = .fillEqually
        
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.setCornerRadius(radius: 10.adjustedHeight)
        
        $0.layoutMargins = UIEdgeInsets(top: 14.adjustedHeight, left: 22.adjustedWidth, bottom: 14.adjustedHeight, right: 22.adjustedWidth)
        $0.isLayoutMarginsRelativeArrangement = true
    }
// }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.addSubview(profileImageView)
        self.addSubview(profileImageSettingButton)
        self.addSubview(nicknameLabel)
        self.addSubview(idLabel)
        self.addSubview(introduceLabel)
        self.addSubview(tasteStackView)
        self.addSubview(routineStackView)
        
        makeView()
    }
    
    private func makeView() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(58.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(60.adjustedHeight)
        }
        profileImageSettingButton.snp.makeConstraints {
            $0.right.bottom.equalTo(profileImageView)
        }
        nicknameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileImageView.snp.bottom).offset(7.adjustedHeight)
        }
        idLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nicknameLabel.snp.bottom)
        }
        introduceLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.adjustedWidth)
            $0.top.equalTo(idLabel.snp.bottom).offset(38.adjustedHeight)
            $0.height.equalTo(32.adjustedHeight)
        }
        tasteStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.adjustedWidth)
            $0.top.equalTo(introduceLabel.snp.bottom).offset(15.adjustedHeight)
            $0.height.equalTo(168.adjustedHeight)
        }
        routineStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.adjustedWidth)
            $0.top.equalTo(tasteStackView.snp.bottom).offset(15.adjustedHeight)
            $0.height.equalTo(129.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MyGenreCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyGenreCollectionViewCell"
    
    var titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .defaultFont(size: 8)
    }
    
    func configure(name: String?) {
        titleLabel.text = name
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .mainColor
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
        frame.size.height = 22.0.adjustedHeight
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
