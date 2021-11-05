//
//  ReadingStyleView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/05.
//

import UIKit

final class ReadingStyleView: UIView {
    var titleLabel = UILabel().then {
        $0.text = "책 읽는 스타일을 선택해주세요."
        $0.textColor = .mainColor
        $0.font = .defaultFont(size: .big, bold: true)
    }
    
    lazy var style1Button = ToggleButton(normalColor: UIColor(hexString: "EFF0F3"), onColor: .mainColor).then {
        $0.setTitle("아침을 먹고 아이패드로 책을 보는 타입", for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .medium)
        $0.normalTextColor = UIColor(hexString: "C3C5D1")
        $0.onTextColor = .white
        $0.relatedButtons = [style2Button, style3Button]
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
        $0.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
    }
    
    lazy var style2Button = ToggleButton(normalColor: UIColor(hexString: "EFF0F3"), onColor: .mainColor).then {
        $0.setTitle("아침을 먹고 아이패드로 책을 보는 타입", for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .medium)
        $0.normalTextColor = UIColor(hexString: "C3C5D1")
        $0.onTextColor = .white
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
        $0.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
    }
    
    lazy var style3Button = ToggleButton(normalColor: UIColor(hexString: "EFF0F3"), onColor: .mainColor).then {
        $0.setTitle("아침을 먹고 아이패드로 책을 보는 타입", for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .medium)
        $0.normalTextColor = UIColor(hexString: "C3C5D1")
        $0.onTextColor = .white
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
        $0.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
    }
    
    var customStyleTextField = UITextView().then {
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.font = .defaultFont(size: .medium)
        $0.textColor = UIColor(hexString: "C3C5D1")
        $0.text = "+ 직접 입력하기 (최대 30자)"
        
        $0.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
    }

    var nextButton = UIButton().then {
        $0.isUserInteractionEnabled = false
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
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
        self.addSubview(style1Button)
        self.addSubview(style2Button)
        self.addSubview(style3Button)
        self.addSubview(customStyleTextField)
        self.addSubview(nextInformationLabel)
        self.addSubview(nextButton)
        
        style2Button.relatedButtons = [style1Button, style3Button]
        style3Button.relatedButtons = [style1Button, style2Button]
        makeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeView() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.getAdjustedHeight(33.0))
            $0.left.equalToSuperview().inset(Constants.getAdjustedWidth(20.0))
        }
        style1Button.snp.makeConstraints {
            $0.width.equalTo(335.0)
            $0.height.equalTo(40.0)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
        }
        style2Button.snp.makeConstraints {
            $0.width.equalTo(335.0)
            $0.height.equalTo(40.0)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(style1Button.snp.bottom).offset(Constants.getAdjustedHeight(14.0))
        }
        style3Button.snp.makeConstraints {
            $0.width.equalTo(335.0)
            $0.height.equalTo(40.0)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(style2Button.snp.bottom).offset(Constants.getAdjustedHeight(14.0))
        }
        customStyleTextField.snp.makeConstraints {
            $0.width.equalTo(335.0)
            $0.height.equalTo(40.0)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(style3Button.snp.bottom).offset(Constants.getAdjustedHeight(14.0))
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
    }
}
