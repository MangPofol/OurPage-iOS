//
//  BookSelectView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/17.
//

import UIKit

class BookSelectView: UIView {
    var upperView = UIView().then {
        $0.backgroundColor = .white
        $0.setShadow(opacity: 0.5, color: .lightGray)
    }
    
    var searchBar = UITextField().then {
        $0.backgroundColor = .white
        $0.autocorrectionType = .no
        $0.font = .defaultFont(size: 14, boldLevel: .bold)
        $0.placeholder = "새 책 등록하기"
        
        $0.makeBorder(color: UIColor.mainColor.cgColor, width: CGFloat(Constants.getAdjustedWidth(1.0)), cornerRadius: CGFloat(Constants.getAdjustedHeight(13.0)))
        
        // left padding
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14.adjustedWidth, height: 1))
        
        // searchBar 돋보기 오른쪽으로
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: (9.42 + 10.47).adjustedWidth, height: 9.42.adjustedHeight))
        let imageView = UIImageView(frame: CGRect(x: -10.47.adjustedWidth, y: 0, width: 9.47.adjustedWidth, height: 9.47.adjustedHeight))
        imageView.image = .SearchIconRegular
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .mainColor
        rightView.addSubview(imageView)
        
        $0.rightView = rightView
        $0.rightViewMode = .always
        $0.leftView = leftView
        $0.leftViewMode = .always
    }
    
    var bookCollectionContainer = UIView().then {
        $0.backgroundColor = .red
    }
    
    var infoLabel = UILabel().then {
        $0.font = .defaultFont(size: 14, boldLevel: .medium)
        $0.textColor = UIColor(hexString: "646A88")
        $0.text = "내 책장에서 선택하기"
    }
    
    let buttonSelectionColor = UIColor(hexString: "C3C5D1")
    lazy var readingButton
        = ToggleButton(normalColor: .white, onColor: buttonSelectionColor).then {
            $0.setTitle("읽는 중", for: .normal)
            $0.setTitleColor(.grayD1, for: .normal)
            $0.normalTextColor = .grayD1
            $0.onTextColor = .white
            $0.titleLabel?.font = .defaultFont(size: .small)
            $0.backgroundColor = .white
            $0.makeBorder(color: UIColor.grayD1.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(10.0)))
            
            $0.isOn = true
        }
    
    lazy var finishedButton
        = ToggleButton(normalColor: .white, onColor: buttonSelectionColor).then {
            $0.setTitle("완독", for: .normal)
            $0.setTitleColor(.grayC3, for: .normal)
            $0.normalTextColor = .grayC3
            $0.onTextColor = .white
            $0.titleLabel?.font = .defaultFont(size: .small)
            $0.backgroundColor = .white
            $0.makeBorder(color: UIColor.grayC3.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(10.0)))
        }
    
    lazy var wantToButton
        = ToggleButton(normalColor: .white, onColor: buttonSelectionColor).then {
            $0.setTitle("읽고싶은", for: .normal)
            $0.setTitleColor(.grayC3, for: .normal)
            $0.normalTextColor = .grayC3
            $0.onTextColor = .white
            $0.titleLabel?.font = .defaultFont(size: .small)
            $0.backgroundColor = .white
            $0.makeBorder(color: UIColor.grayC3.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(10.0)))
        }
    
    lazy var buttonContainer = UIView().then {
        $0.addSubview(infoLabel)
        $0.addSubview(readingButton)
        $0.addSubview(finishedButton)
        $0.addSubview(wantToButton)
    }
    
    var searchResultTitleLabel = UILabel().then {
        $0.text = "검색 결과"
        $0.font = .defaultFont(size: 14, boldLevel: .medium)
        $0.textColor = UIColor(hexString: "646A88")
        $0.isHidden = true
    }
    
    var searchResultLineView = LineView(width: 1, color: UIColor(hexString: "646A88")).then {
        $0.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(upperView)
        self.addSubview(searchBar)
        self.addSubview(bookCollectionContainer)
        self.addSubview(buttonContainer)
        self.addSubview(searchResultTitleLabel)
        self.addSubview(searchResultLineView)
        readingButton.relatedButtons = [finishedButton, wantToButton]
        finishedButton.relatedButtons = [readingButton, wantToButton]
        wantToButton.relatedButtons = [finishedButton, readingButton]
        makeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
        upperView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(searchBar).inset(-26.adjustedHeight)
        }
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.getAdjustedHeight(20.0))
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constants.getAdjustedWidth(335.0))
            $0.height.equalTo(Constants.getAdjustedHeight(35))
        }
        
        buttonContainer.snp.makeConstraints {
            $0.left.right.equalTo(searchBar)
            $0.top.equalTo(upperView.snp.bottom).offset(14.adjustedHeight)
        }
        
        infoLabel.snp.makeConstraints {
            $0.left.top.equalToSuperview()
        }
        
        readingButton.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(Constants.getAdjustedHeight(9.0))
            $0.left.equalToSuperview()
            $0.width.equalTo(Constants.getAdjustedWidth(47.0))
            $0.height.equalTo(Constants.getAdjustedHeight(20.0))
            $0.bottom.equalToSuperview()
        }
        
        finishedButton.snp.makeConstraints {
            $0.top.equalTo(readingButton)
            $0.left.equalTo(readingButton.snp.right).offset(Constants.getAdjustedWidth(5.0))
            $0.width.equalTo(Constants.getAdjustedWidth(36.0))
            $0.height.equalTo(Constants.getAdjustedHeight(20.0))
            $0.bottom.equalToSuperview()
        }
        
        wantToButton.snp.makeConstraints {
            $0.top.equalTo(readingButton)
            $0.left.equalTo(finishedButton.snp.right).offset(Constants.getAdjustedWidth(5.0))
            $0.width.equalTo(Constants.getAdjustedWidth(53.0))
            $0.height.equalTo(Constants.getAdjustedHeight(20.0))
            $0.bottom.equalToSuperview()
        }
        
        bookCollectionContainer.snp.makeConstraints {
            $0.top.equalTo(upperView.snp.bottom).offset(81.adjustedHeight)
            $0.left.right.equalTo(searchBar)
            $0.bottom.equalToSuperview()
        }
        
        searchResultTitleLabel.snp.makeConstraints {
            $0.left.equalTo(searchBar)
            $0.top.equalTo(upperView.snp.bottom).offset(14.adjustedHeight)
        }
        
        searchResultLineView.snp.makeConstraints {
            $0.left.right.equalTo(searchBar)
            $0.height.equalTo(1)
            $0.top.equalTo(searchResultTitleLabel.snp.bottom).offset(18.adjustedHeight)
        }
    }
}
