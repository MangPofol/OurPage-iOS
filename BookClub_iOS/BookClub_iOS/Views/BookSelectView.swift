//
//  BookSelectView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/17.
//

import UIKit

class BookSelectView: UIView {
    var searchBar = UISearchBar().then {
        //        $0.searchBarStyle = .prominent
        $0.backgroundImage = .none
        $0.autocorrectionType = .no
        
        $0.placeholder = "새 책 등록하기"
        
        $0.makeBorder(color: UIColor.mainColor.cgColor, width: CGFloat(Constants.getAdjustedWidth(1.0)), cornerRadius: CGFloat(Constants.getAdjustedHeight(13.0)))
        $0.searchTextField.tintColor = .mainColor
        $0.searchTextField.backgroundColor = .white
        $0.searchTextField.font = .defaultFont(size: .medium)
        $0.searchTextField.textAlignment = .left
        $0.searchTextField.leftView = nil
    }
    
    var bookCollectionContainer = UIView().then {
        $0.backgroundColor = .red
    }
    
    var infoLabel = UILabel().then {
        $0.font = .defaultFont(size: .medium)
        $0.textColor = .gray7A
        $0.text = "내 책장에서 선택하기"
    }
    
    var readingButton
        = ToggleButton(normalColor: .white, onColor: .grayB0).then {
            $0.setTitle("읽는 중", for: .normal)
            $0.setTitleColor(.grayD1, for: .normal)
            $0.normalTextColor = .grayD1
            $0.onTextColor = .white
            $0.titleLabel?.font = .defaultFont(size: .small)
            $0.backgroundColor = .white
            $0.makeBorder(color: UIColor.grayD1.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(10.0)))
            
            $0.isOn = true
        }
    
    var finishedButton
        = ToggleButton(normalColor: .white, onColor: .grayB0).then {
            $0.setTitle("완독", for: .normal)
            $0.setTitleColor(.grayD1, for: .normal)
            $0.normalTextColor = .grayD1
            $0.onTextColor = .white
            $0.titleLabel?.font = .defaultFont(size: .small)
            $0.backgroundColor = .white
            $0.makeBorder(color: UIColor.grayD1.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(10.0)))
        }
    
    var wantToButton
        = ToggleButton(normalColor: .white, onColor: .grayB0).then {
            $0.setTitle("읽고싶은", for: .normal)
            $0.setTitleColor(.grayD1, for: .normal)
            $0.normalTextColor = .grayD1
            $0.onTextColor = .white
            $0.titleLabel?.font = .defaultFont(size: .small)
            $0.backgroundColor = .white
            $0.makeBorder(color: UIColor.grayD1.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(10.0)))
        }
    
    lazy var buttonContainer = UIView().then {
        $0.addSubview(infoLabel)
        $0.addSubview(readingButton)
        $0.addSubview(finishedButton)
        $0.addSubview(wantToButton)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(searchBar)
        self.addSubview(bookCollectionContainer)
        self.addSubview(buttonContainer)
        readingButton.relatedButtons = [finishedButton, wantToButton]
        finishedButton.relatedButtons = [readingButton, wantToButton]
        wantToButton.relatedButtons = [finishedButton, readingButton]
        makeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.getAdjustedHeight(20.0))
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constants.getAdjustedWidth(335.0))
            $0.height.equalTo(Constants.getAdjustedHeight(26.0))
        }
        
        buttonContainer.snp.makeConstraints {
            $0.left.right.equalTo(searchBar)
            $0.top.equalTo(searchBar.snp.bottom).offset(Constants.getAdjustedHeight(42.0))
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
            $0.top.equalTo(buttonContainer.snp.bottom).offset(Constants.getAdjustedHeight(21.0))
            $0.left.right.equalTo(searchBar)
            $0.bottom.equalToSuperview()
        }
    }
}
