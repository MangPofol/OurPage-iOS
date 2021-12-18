//
//  GenreView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/03.
//

import UIKit

final class GenreView: UIView {
    var titleLabel = UILabel().then {
        $0.text = "좋아하는 장르를 자유롭게 선택해주세요."
        $0.textColor = .mainColor
        $0.font = .defaultFont(size: .big, bold: true)
    }
    
    var genreCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .white
        $0.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        $0.allowsMultipleSelection = true
    }
    
    var nextButton = UIButton().then {
        $0.isUserInteractionEnabled = false
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
        $0.titleLabel?.font = .defaultFont(size: 18, boldLevel: .bold)
        $0.backgroundColor = .textFieldBackgroundGray
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(8.0))
    }
    
    var nextInformationLabel = UILabel().then {
        $0.isHidden = true
        $0.backgroundColor = .white
        $0.textColor = UIColor(hexString: "E5949D")
        $0.font = .defaultFont(size: .small)
        $0.text = "입력한 정보는 추후 북클럽 내 ‘나의 프로필’에 표시됩니다."
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(titleLabel)
        self.addSubview(genreCollectionView)
        self.addSubview(nextButton)
        self.addSubview(nextInformationLabel)
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionLayout.minimumInteritemSpacing = 11
        collectionLayout.minimumLineSpacing = 10
        
        self.genreCollectionView.setCollectionViewLayout(collectionLayout, animated: false)
        
        makeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.getAdjustedHeight(33.0))
            $0.left.equalToSuperview().inset(Constants.getAdjustedWidth(20.0))
        }
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(nextInformationLabel.snp.top).offset(-Constants.getAdjustedHeight(9.0))
            $0.width.equalTo(Constants.getAdjustedWidth(320.0))
            $0.height.equalTo(Constants.getAdjustedHeight(52.0))
        }
        nextInformationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Constants.getAdjustedHeight(75.0))
        }
        genreCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.getAdjustedHeight(21.0))
            $0.left.right.equalToSuperview().inset(19)
            $0.bottom.equalTo(nextButton.snp.top).offset(30)
        }
    }
}

class GenreCollectionViewCell: UICollectionViewCell {
    static let identifier = "GenreCollectionViewCell"
    
    var titleLabel = UILabel().then {
        $0.textColor = UIColor(hexString: "C3C5D1")
        $0.font = .defaultFont(size: 12.0)
    }
    
    func configure(name: String?) {
        titleLabel.text = name
    }
    
    func setSelected(_ on: Bool) {
        if on {
            self.backgroundColor = UIColor(hexString: "303860")
            self.titleLabel.textColor = .white
        } else {
            self.backgroundColor = .white
            self.titleLabel.textColor = UIColor(hexString: "C3C5D1")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeBorder(color: UIColor(hexString: "C3C5D1").cgColor, width: 1.0)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(5.adjustedHeight)
            $0.left.right.equalToSuperview().inset(15.adjustedWidth)
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()

        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)

        var frame = layoutAttributes.frame
        frame.size.height = 25.adjustedHeight
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
