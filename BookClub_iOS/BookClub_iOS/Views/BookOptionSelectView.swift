//
//  BookOptionSelectView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/28.
//

import UIKit

class BookOptionSelectView: UIView {
    var titleLabel = UILabel().then {
        $0.text = "책 옵션"
        $0.font = .defaultFont(size: .big, bold: true)
    }
    
    var readingButton
        = ToggleButton(normalColor: .white, onColor: .mainColor).then {
            $0.setTitle("읽는 중", for: .normal)
            $0.setTitleColor(.grayC4, for: .normal)
            $0.normalTextColor = .grayC4
            $0.onTextColor = .white
            $0.titleLabel?.font = .defaultFont(size: .cellFont)
            $0.backgroundColor = .white
            $0.makeBorder(color: UIColor.grayC4.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(10.0)))
            
            $0.isOn = true
        }
    
    var finishedButton
        = ToggleButton(normalColor: .white, onColor: .mainColor).then {
            $0.setTitle("완독", for: .normal)
            $0.setTitleColor(.grayC4, for: .normal)
            $0.normalTextColor = .grayC4
            $0.onTextColor = .white
            $0.titleLabel?.font = .defaultFont(size: .cellFont)
            $0.backgroundColor = .white
            $0.makeBorder(color: UIColor.grayC4.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(10.0)))
        }
    
    var wantToButton
        = ToggleButton(normalColor: .white, onColor: .mainColor).then {
            $0.setTitle("읽고싶은", for: .normal)
            $0.setTitleColor(.grayC4, for: .normal)
            $0.normalTextColor = .grayC4
            $0.onTextColor = .white
            $0.titleLabel?.font = .defaultFont(size: .cellFont)
            $0.backgroundColor = .white
            $0.makeBorder(color: UIColor.grayC4.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(10.0)))
        }
    
    var addBookButton = UIButton().then {
        $0.setTitle("책 추가하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .medium, bold: true)
        $0.backgroundColor = .grayE3
        $0.makeBorder(color: UIColor.grayE3.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(10.0)))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(titleLabel)
        self.addSubview(readingButton)
        self.addSubview(finishedButton)
        self.addSubview(wantToButton)
        self.addSubview(addBookButton)
        readingButton.relatedButtons = [finishedButton, wantToButton]
        finishedButton.relatedButtons = [readingButton, wantToButton]
        wantToButton.relatedButtons = [readingButton, finishedButton]
        makeView()
        self.topRoundCorner(radius: CGFloat(Constants.getAdjustedHeight(10.0)))
    }
    
    func makeView() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(Constants.getAdjustedHeight(15.0))
        }
        readingButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(Constants.getAdjustedWidth(33.0))
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.getAdjustedHeight(27.0))
            $0.width.equalTo(Constants.getAdjustedWidth(97.0))
            $0.height.equalTo(Constants.getAdjustedHeight(32.0))
        }
        finishedButton.snp.makeConstraints {
            $0.left.equalTo(readingButton.snp.right).offset(Constants.getAdjustedWidth(9.0))
            $0.top.equalTo(readingButton)
            $0.width.equalTo(Constants.getAdjustedWidth(97.0))
            $0.height.equalTo(Constants.getAdjustedHeight(32.0))
        }
        wantToButton.snp.makeConstraints {
            $0.left.equalTo(finishedButton.snp.right).offset(Constants.getAdjustedWidth(9.0))
            $0.top.equalTo(readingButton)
            $0.width.equalTo(Constants.getAdjustedWidth(97.0))
            $0.height.equalTo(Constants.getAdjustedHeight(32.0))
        }
        addBookButton.snp.makeConstraints {
            $0.top.equalTo(finishedButton.snp.bottom).offset(Constants.getAdjustedHeight(13.0))
            $0.left.right.equalToSuperview().inset(Constants.getAdjustedWidth(33.0))
            $0.height.equalTo(Constants.getAdjustedHeight(39.0))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
