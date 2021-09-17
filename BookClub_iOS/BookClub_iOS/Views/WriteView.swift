//
//  WriteView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/10.
//

import UIKit

class WriteView: UIView {
    var bookSelectionButton = ButtonWithImage(frame: .zero).then {
        $0.backgroundColor = .mainColor
        $0.button.setTitle("기록할 책을 선택해주세요", for: .normal)
        $0.button.setTitleColor(.white, for: .normal)
        $0.button.titleLabel?.font = .defaultFont(size: .medium, bold: true)
        $0.imageView.image = .rightArrowImage
        $0.setCornerRadius(radius: CGFloat(Constants.getAdjustedHeight(10.0)))
    }
    
    var memoButton = ToggleButton(normalColor: .white, onColor: .mainColor).then {
        $0.setTitle("메모", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.backgroundColor = .white
        $0.makeBorder(color: UIColor.gray1.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(13.0)))
    }
    
    var topicButton = ToggleButton(normalColor: .white, onColor: .mainColor).then {
        $0.setTitle("토픽", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.backgroundColor = .white
        $0.makeBorder(color: UIColor.gray1.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(13.0)))
    }
    
    var titleTextField = UITextField().then {
        $0.placeholder = "제목을 입력해주세요."
        $0.font = .defaultFont(size: .big, bold: true)
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
    }
    
    var contentTextView = UITextView().then {
        $0.font = .defaultFont(size: .medium)
        $0.textColor = .grayB0
        $0.text = "내용을 입력하세요."
        $0.autocorrectionType = .no
    
        // 공백 없애기
        $0.textContainer.lineFragmentPadding = 0
        $0.textContainerInset = .zero
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(bookSelectionButton)
        self.addSubview(memoButton)
        self.addSubview(topicButton)
        self.addSubview(titleTextField)
        self.addSubview(contentTextView)
        memoButton.relatedButtons = [topicButton]
        topicButton.relatedButtons = [memoButton]
        makeView()
    }
    
    func makeView() {
        bookSelectionButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.getAdjustedHeight(20.0))
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Constants.getAdjustedHeight(30.0))
            $0.width.equalTo(Constants.getAdjustedWidth(334.0))
        }
        
        memoButton.snp.makeConstraints {
            $0.left.equalTo(bookSelectionButton)
            $0.top.equalTo(bookSelectionButton.snp.bottom).offset(Constants.getAdjustedHeight(14.0))
            $0.width.equalTo(Constants.getAdjustedWidth(51.0))
            $0.height.equalTo(Constants.getAdjustedHeight(26.0))
        }
        
        topicButton.snp.makeConstraints {
            $0.width.height.equalTo(memoButton)
            $0.top.equalTo(bookSelectionButton.snp.bottom).offset(Constants.getAdjustedHeight(14.0))
            $0.left.equalTo(memoButton.snp.right).offset(Constants.getAdjustedWidth(8.0))
        }
        
        titleTextField.snp.makeConstraints {
            $0.left.right.equalTo(bookSelectionButton)
            $0.top.equalTo(memoButton.snp.bottom).offset(Constants.getAdjustedHeight(37.0))
        }
        
        contentTextView.snp.makeConstraints {
            $0.left.equalTo(titleTextField)
            $0.top.equalTo(titleTextField.snp.bottom).offset(Constants.getAdjustedHeight(14.0))
            $0.width.equalTo(Constants.getAdjustedWidth(316.0))
            $0.height.equalTo(Constants.getAdjustedHeight(308.0))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
