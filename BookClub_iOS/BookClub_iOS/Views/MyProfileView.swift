//
//  MyProfileView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/02.
//

import UIKit

final class MyProfileView: UIView {
    
    var profileImageView = UIImageView().then {
        $0.setCornerRadius(radius: 44.adjustedHeight)
        $0.contentMode = .scaleAspectFill
        $0.image = .DefaultProfileImage
    }
    
    var profileImageSettingButton = UIView().then {
        let imageView = UIImageView(image: .SettingIconWithBackground.resize(to: CGSize(width: 22.adjustedHeight, height: 22.adjustedHeight), isAlwaysTemplate: false))
        $0.backgroundColor = .clear
        $0.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.right.bottom.equalToSuperview()
        }
    }
    
    var nicknameLabel = UILabel().then {
        $0.font = .defaultFont(size: 20, boldLevel: .bold)
        $0.text = "홍길동"
        $0.textColor = .mainColor
    }
    
    var idLabel = UILabel().then {
        $0.font = .defaultFont(size: 13, boldLevel: .regular)
        $0.text = "myidisawsome"
        $0.textColor = .mainColor
    }
    
    var recordIconImageView = UIImageView()
    var recordTextField = UITextField()
    
    var readBookIconImageView = UIImageView()
    var readBookTextField = UITextField()
    
    
    var introduceLabel = UILabel().then {
        $0.font = .defaultFont(size: 12, boldLevel: .semiBold)
        $0.text = "저는 책을 좋아하는 사람입니다."
        $0.textColor = .white
        
        $0.backgroundColor = .clear
        $0.textAlignment = .center
        
        $0.setCornerRadius(radius: 10.adjustedHeight)
    }
    
    
// {
    var tasteTitleLabel = UILabel().then {
        $0.font = .defaultFont(size: 14, boldLevel: .bold)
        $0.text = "책 취향"
        $0.textColor = .mainColor
    }
    
    var genreTitleLabel = UILabel().then {
        $0.font = .defaultFont(size: 12, boldLevel: .medium)
        $0.text = "좋아하는 장르"
        $0.textColor = .mainColor
    }
    
    var genreCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .white
        $0.register(MyGenreCollectionViewCell.self, forCellWithReuseIdentifier: MyGenreCollectionViewCell.identifier)
        $0.allowsSelection = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    var tasteSettingButton = UIButton().then {
        $0.setImage(.RightArrowBoldIcon, for: .normal)
        $0.backgroundColor = .clear
        $0.tintColor = .mainColor
        $0.imageView?.contentMode = .scaleAspectFit
        $0.imageEdgeInsets = UIEdgeInsets(top: 9.adjustedHeight, left: 29.adjustedWidth, bottom: 9.adjustedHeight, right: 6.72.adjustedWidth)
    }
    
    lazy var genreContainerView = UIView().then {
        $0.addSubview(genreTitleLabel)
        $0.addSubview(genreCollectionView)
        $0.addSubview(tasteSettingButton)
        
        $0.backgroundColor = .white
        $0.setCornerRadius(radius: 10.adjustedHeight)
        
        genreTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10.adjustedHeight)
            $0.left.equalToSuperview().inset(15.adjustedHeight)
        }
        
        genreCollectionView.snp.makeConstraints {
            $0.top.equalTo(genreTitleLabel.snp.bottom).offset(5.adjustedHeight)
            $0.left.equalToSuperview().inset(15.adjustedHeight)
            $0.width.equalTo(239.adjustedWidth)
            $0.height.equalTo(25.adjustedHeight)
        }
        
        tasteSettingButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(6.adjustedWidth)
            $0.width.equalTo(40.adjustedWidth)
            $0.height.equalTo(25.adjustedHeight)
            $0.centerY.equalTo(genreCollectionView)
        }
    }

    var readingStyleButton = ButtonWithRightIcon(frame: .zero, image: .RightArrowBoldIcon, title: "책 읽는 스타일", iconPadding: 12.72.adjustedWidth, textPadding: 20.adjustedWidth, iconSize: CGSize(width: 4.28, height: 7).resized(basedOn: .height)).then {
        $0.textLabel.font = .defaultFont(size: 12, boldLevel: .medium)
        $0.textLabel.textColor = .mainColor
        $0.iconView.contentMode = .scaleAspectFit
        $0.backgroundColor = .white
        $0.setCornerRadius(radius: 10.adjustedHeight)
    }
    
    lazy var tasteStackView = UIView()
// }
    
// {
    var routineTitleLabel = UILabel().then {
        $0.font = .defaultFont(size: 14, boldLevel: .bold)
        $0.text = "책 루틴"
        $0.textColor = .mainColor
    }
    
    var goalSettingButton = ButtonWithRightIcon(frame: .zero, image: .RightArrowBoldIcon, title: "목표 관리", iconPadding: 12.72.adjustedWidth, textPadding: 20.adjustedWidth, iconSize: CGSize(width: 4.28, height: 7).resized(basedOn: .height)).then {
        $0.textLabel.font = .defaultFont(size: 12, boldLevel: .medium)
        $0.textLabel.textColor = .mainColor
        $0.iconView.contentMode = .scaleAspectFit
        $0.backgroundColor = .white
        $0.setCornerRadius(radius: 10.adjustedHeight)
    }
    
    var checkListSettingButton = ButtonWithRightIcon(frame: .zero, image: .RightArrowBoldIcon, title: "체크리스트 관리", iconPadding: 12.72.adjustedWidth, textPadding: 20.adjustedWidth, iconSize: CGSize(width: 4.28, height: 7).resized(basedOn: .height)).then {
        $0.textLabel.font = .defaultFont(size: 12, boldLevel: .medium)
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
    
    var dotLineView = UIImageView(image: UIImage(named: "DotLine")).then {
        $0.contentMode = .scaleAspectFit
    }
    
    var logoImageView = UIImageView(image: UIImage(named: "MainLogo"))
    
    var introduceBackgroundImageView = UIImageView(image: UIImage(named: "IntroduceBackground"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.addSubview(profileImageView)
        self.addSubview(profileImageSettingButton)
        self.addSubview(dotLineView)
        
        self.addSubview(nicknameLabel)
        self.addSubview(idLabel)
        
        self.addSubview(recordIconImageView)
        self.addSubview(recordTextField)
        self.addSubview(readBookIconImageView)
        self.addSubview(readBookTextField)
        
        self.addSubview(introduceBackgroundImageView)
        self.addSubview(introduceLabel)
        self.addSubview(logoImageView)
        
        self.addSubview(tasteStackView)
        self.addSubview(routineStackView)
        
        makeView()
    }
    
    private func makeView() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(58.adjustedHeight)
            $0.left.equalToSuperview().inset(41.adjustedHeight)
            $0.width.height.equalTo(88.adjustedHeight)
        }
        profileImageSettingButton.snp.makeConstraints {
            $0.right.bottom.equalTo(profileImageView)
            $0.width.height.equalTo(22.adjustedHeight)
        }
        dotLineView.snp.makeConstraints {
            $0.top.bottom.equalTo(profileImageView)
            $0.left.equalTo(profileImageView.snp.right).offset(26.adjustedHeight)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.left.equalTo(dotLineView.snp.right).offset(23.adjustedHeight)
            $0.top.equalTo(dotLineView)
        }
        idLabel.snp.makeConstraints {
            $0.left.equalTo(nicknameLabel)
            $0.top.equalTo(nicknameLabel.snp.bottom)
        }
        
        recordIconImageView.then {
            $0.image = UIImage(named: "WriteViewIcon")?.withRenderingMode(.alwaysTemplate)
            $0.tintColor = UIColor(hexString: "7B8099")
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.bottom.equalTo(readBookIconImageView.snp.top).offset(-7.5.adjustedHeight)
            $0.left.equalTo(idLabel)
            $0.width.height.equalTo(10.4.adjustedHeight)
        }
        
        recordTextField.then {
            $0.font = .defaultFont(size: 12, boldLevel: .regular)
            $0.textColor = UIColor(hexString: "7B8099")
            $0.text = "총 기록 838 pages"
        }.snp.makeConstraints {
            $0.centerY.equalTo(recordIconImageView)
            $0.left.equalTo(recordIconImageView.snp.right).offset(7.6)
        }
        
        readBookIconImageView.then {
            $0.image = UIImage(named: "MyLibraryIcon")?.withRenderingMode(.alwaysTemplate)
            $0.tintColor = UIColor(hexString: "7B8099")
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.bottom.equalTo(dotLineView)
            $0.left.equalTo(idLabel)
            $0.width.height.equalTo(10.4.adjustedHeight)
        }
        
        readBookTextField.then {
            $0.font = .defaultFont(size: 12, boldLevel: .regular)
            $0.textColor = UIColor(hexString: "7B8099")
            $0.text = "읽은 책 26 books"
        }.snp.makeConstraints {
            $0.centerY.equalTo(readBookIconImageView)
            $0.left.equalTo(readBookIconImageView.snp.right).offset(7.6)
        }
        
        logoImageView.then {
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.right.equalTo(tasteStackView).inset(8.45)
            $0.width.equalTo(62.45.adjustedHeight)
            $0.height.equalTo(23.83.adjustedHeight)
            $0.top.equalTo(profileImageView.snp.bottom).offset(65.9.adjustedHeight)
        }
        introduceBackgroundImageView.then {
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.edges.equalTo(introduceLabel)
        }
        
        introduceLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20.adjustedWidth)
            $0.right.equalTo(logoImageView.snp.left)
            $0.centerY.equalTo(logoImageView)
            $0.height.equalTo(32.adjustedHeight)
        }
        
        tasteStackView.then {
            $0.addSubview(tasteTitleLabel)
            $0.addSubview(genreContainerView)
            $0.addSubview(readingStyleButton)
            
            $0.backgroundColor = UIColor(hexString: "EFF0F3")
            $0.setCornerRadius(radius: 10.adjustedHeight)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.adjustedWidth)
            $0.top.equalTo(introduceLabel.snp.bottom).offset(15.adjustedHeight)
            $0.height.equalTo(168.adjustedHeight)
        }
        tasteTitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20.0.adjustedHeight)
            $0.top.equalToSuperview().inset(14.0.adjustedHeight)
        }
        genreContainerView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0.adjustedHeight)
            $0.top.equalTo(tasteTitleLabel.snp.bottom).offset(10.0.adjustedHeight)
            $0.height.equalTo(68.0)
        }
        readingStyleButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0.adjustedHeight)
            $0.top.equalTo(genreContainerView.snp.bottom).offset(10.0.adjustedHeight)
            $0.height.equalTo(29.0.adjustedHeight)
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
        $0.font = .defaultFont(size: 10)
    }
    
    func configure(name: String?) {
        titleLabel.text = name
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .mainColor
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(15)
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()

        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)

        var frame = layoutAttributes.frame
        frame.size.height = 25.0.adjustedHeight
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
