//
//  MyTasteView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/08.
//

import UIKit

final class MyTasteView: UIView {
    var genreModifyTitleLabel = UILabel().then {
        $0.textColor = .mainColor
        $0.text = "좋아하는 장르를 수정해주세요."
        $0.font = .defaultFont(size: 14, boldLevel: .bold)
    }
    
    var genreCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .white
        $0.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        $0.allowsMultipleSelection = true
        $0.isScrollEnabled = false
    }
    
    var styleModifyTitleLabel = UILabel().then {
        $0.textColor = .mainColor
        $0.text = "책 읽는 스타일을 수정해주세요."
        $0.font = .defaultFont(size: 14, boldLevel: .bold)
    }
    
    lazy var style1Button = ToggleButton(normalColor: UIColor(hexString: "EFF0F3"), onColor: .mainColor).then {
        $0.setTitle("아침을 먹고 아이패드로 책을 보는 타입", for: .normal)
        $0.titleLabel?.font = .defaultFont(size: 12)
        $0.normalTextColor = UIColor(hexString: "C3C5D1")
        $0.onTextColor = .white
        $0.relatedButtons = [style2Button, style3Button]
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
        $0.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10.5.adjustedWidth, bottom: 0, right: 0)
    }
    
    lazy var style2Button = ToggleButton(normalColor: UIColor(hexString: "EFF0F3"), onColor: .mainColor).then {
        $0.setTitle("아침을 먹고 아이패드로 책을 보는 타입", for: .normal)
        $0.titleLabel?.font = .defaultFont(size: 12)
        $0.normalTextColor = UIColor(hexString: "C3C5D1")
        $0.onTextColor = .white
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
        $0.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10.5.adjustedWidth, bottom: 0, right: 0)
    }
    
    lazy var style3Button = ToggleButton(normalColor: UIColor(hexString: "EFF0F3"), onColor: .mainColor).then {
        $0.setTitle("아침을 먹고 아이패드로 책을 보는 타입", for: .normal)
        $0.titleLabel?.font = .defaultFont(size: 12)
        $0.normalTextColor = UIColor(hexString: "C3C5D1")
        $0.onTextColor = .white
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
        $0.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10.5.adjustedWidth, bottom: 0, right: 0)
    }
    
    var customStyleTextField = UITextView().then {
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.font = .defaultFont(size: 12)
        $0.textColor = UIColor(hexString: "C3C5D1")
        $0.text = "+ 직접 입력하기 (최대 30자)"
        
        $0.textContainerInset = UIEdgeInsets(top: 8.adjustedHeight, left: 11.adjustedWidth, bottom: 0, right: 15.adjustedWidth)
//        $0.textContainerInset = .zero
        
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(genreModifyTitleLabel)
        self.addSubview(genreCollectionView)
        self.addSubview(styleModifyTitleLabel)
        self.addSubview(style1Button)
        self.addSubview(style2Button)
        self.addSubview(style3Button)
        self.addSubview(customStyleTextField)
        
        style1Button.relatedButtons = [style2Button, style3Button]
        style2Button.relatedButtons = [style1Button, style3Button]
        style3Button.relatedButtons = [style1Button, style2Button]
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionLayout.minimumInteritemSpacing = 9.6.adjustedWidth
        collectionLayout.minimumLineSpacing = 8.3.adjustedHeight
        
        self.genreCollectionView.setCollectionViewLayout(collectionLayout, animated: false)
        
        makeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeView() {
        genreModifyTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35.adjustedHeight)
            $0.left.equalToSuperview().inset(22.adjustedWidth)
        }
        
        genreCollectionView.snp.makeConstraints {
            $0.top.equalTo(genreModifyTitleLabel.snp.bottom).offset(Constants.getAdjustedHeight(20.0))
            $0.left.equalTo(genreModifyTitleLabel)
            $0.right.equalToSuperview().inset(22.adjustedWidth)
            $0.height.equalTo(159.2.adjustedHeight)
        }
        
        styleModifyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(genreCollectionView.snp.bottom).offset(83.98.adjustedHeight)
            $0.left.equalToSuperview().inset(22.adjustedWidth)
        }
        
        style1Button.snp.makeConstraints {
            $0.width.equalTo(335.0.adjustedWidth)
            $0.height.equalTo(30.0.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(styleModifyTitleLabel.snp.bottom).offset(14)
        }
        style2Button.snp.makeConstraints {
            $0.width.equalTo(335.0.adjustedWidth)
            $0.height.equalTo(30.0.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(style1Button.snp.bottom).offset(Constants.getAdjustedHeight(14.0))
        }
        style3Button.snp.makeConstraints {
            $0.width.equalTo(335.0.adjustedWidth)
            $0.height.equalTo(30.0.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(style2Button.snp.bottom).offset(Constants.getAdjustedHeight(14.0))
        }
        customStyleTextField.snp.makeConstraints {
            $0.width.equalTo(335.0.adjustedWidth)
            $0.height.equalTo(30.0.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(style3Button.snp.bottom).offset(Constants.getAdjustedHeight(14.0))
        }
    }
}
