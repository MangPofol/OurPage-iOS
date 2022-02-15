//
//  GenderBirthView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/30.
//

import UIKit

final class GenderBirthView: UIView {
    var genderTitleLabel = UILabel().then {
        $0.text = "성별을 선택해주세요."
        $0.textColor = .mainColor
        $0.font = .defaultFont(size: .big, bold: true)
    }
    
    lazy var menButton = ToggleButton(normalColor: .textFieldBackgroundGray, onColor: .mainColor).then {
        $0.setTitle("남성", for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .medium)
        $0.normalTextColor = .mainColor
        $0.onTextColor = .white
        $0.relatedButtons = [womenButton]
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
        $0.setTitleColor(.mainColor, for: .normal)
        $0.backgroundColor = .textFieldBackgroundGray
    }
    
    lazy var womenButton = ToggleButton(normalColor: .textFieldBackgroundGray, onColor: .mainColor).then {
        $0.setTitle("여성", for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .medium)
        $0.normalTextColor = .mainColor
        $0.onTextColor = .white
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(10.0))
        $0.setTitleColor(.mainColor, for: .normal)
        $0.backgroundColor = .textFieldBackgroundGray
    }
    
    var birthTitleLabel = UILabel().then {
        $0.text = "생년월일을 입력해주세요."
        $0.textColor = .mainColor
        $0.font = .defaultFont(size: .big, bold: true)
    }
    
    var yearPickerView = UIPickerView()
    var yearTitleLabel = UILabel().then {
        $0.text = "년"
        $0.font = .defaultFont(size: .medium, bold: true)
        $0.textColor = .mainColor
        $0.textAlignment = .center
    }
    
    var monthPickerView = UIPickerView()
    var monthTitleLabel = UILabel().then {
        $0.text = "월"
        $0.font = .defaultFont(size: .medium, bold: true)
        $0.textColor = .mainColor
        $0.textAlignment = .center
    }
    
    var dayPickerView = UIPickerView()
    var dayTitleLabel = UILabel().then {
        $0.text = "일"
        $0.font = .defaultFont(size: .medium, bold: true)
        $0.textColor = .mainColor
        $0.textAlignment = .center
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
        womenButton.relatedButtons = [menButton]
        
        self.addSubview(genderTitleLabel)
        self.addSubview(menButton)
        self.addSubview(womenButton)
        self.addSubview(birthTitleLabel)
        self.addSubview(yearPickerView)
        self.addSubview(yearTitleLabel)
        self.addSubview(monthPickerView)
        self.addSubview(monthTitleLabel)
        self.addSubview(dayPickerView)
        self.addSubview(dayTitleLabel)
        self.addSubview(nextButton)
        self.addSubview(nextInformationLabel)
        
        makeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeView() {
        genderTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.getAdjustedHeight(33.0))
            $0.left.equalToSuperview().inset(Constants.getAdjustedWidth(20.0))
        }
        menButton.snp.makeConstraints {
            $0.top.equalTo(genderTitleLabel.snp.bottom).offset(Constants.getAdjustedHeight(14.0))
            $0.left.equalTo(genderTitleLabel)
            $0.width.equalTo(Constants.getAdjustedWidth(164.0))
            $0.height.equalTo(Constants.getAdjustedHeight(40.0))
        }
        womenButton.snp.makeConstraints {
            $0.top.equalTo(genderTitleLabel.snp.bottom).offset(Constants.getAdjustedHeight(14.0))
            $0.right.equalToSuperview().inset(Constants.getAdjustedWidth(20.0))
            $0.width.equalTo(Constants.getAdjustedWidth(164.0))
            $0.height.equalTo(Constants.getAdjustedHeight(40.0))
        }
        birthTitleLabel.snp.makeConstraints {
            $0.top.equalTo(menButton.snp.bottom).offset(Constants.getAdjustedHeight(40.0))
            $0.left.equalTo(genderTitleLabel)
        }
        yearPickerView.snp.makeConstraints {
            $0.top.equalTo(birthTitleLabel.snp.bottom).offset(Constants.getAdjustedHeight(20.0))
            $0.left.equalTo(birthTitleLabel)
            $0.height.equalTo(Constants.getAdjustedHeight(136.0))
            $0.width.equalTo(Constants.getAdjustedWidth(65.0))
        }
        yearTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(yearPickerView)
            $0.left.equalTo(yearPickerView.snp.right).offset(5.0)
        }
        monthPickerView.snp.makeConstraints {
            $0.top.equalTo(birthTitleLabel.snp.bottom).offset(Constants.getAdjustedHeight(20.0))
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Constants.getAdjustedHeight(136.0))
            $0.width.equalTo(Constants.getAdjustedWidth(65.0))
        }
        monthTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(yearPickerView)
            $0.left.equalTo(monthPickerView.snp.right).offset(5.0)
        }
        dayPickerView.snp.makeConstraints {
            $0.top.equalTo(birthTitleLabel.snp.bottom).offset(Constants.getAdjustedHeight(20.0))
            $0.right.equalTo(dayTitleLabel.snp.left).offset(-5.0)
            $0.height.equalTo(Constants.getAdjustedHeight(136.0))
            $0.width.equalTo(Constants.getAdjustedWidth(65.0))
        }
        dayTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(yearPickerView)
            $0.right.equalToSuperview().inset(Constants.getAdjustedWidth(20.0))
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
