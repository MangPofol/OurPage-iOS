//
//  GoalView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/05.
//

import UIKit

final class GoalView: UIView {
    var titleLabel = UILabel().then {
        $0.text = "독서 목표를 설정해주세요."
        $0.textColor = .mainColor
        $0.font = .defaultFont(size: .big, bold: true)
    }
    
    var periodPickerView = UIPickerView()
    var unitPickerView = UIPickerView()
    
    var untilLabel = UILabel().then {
        $0.text = "동안"
        $0.font = .defaultFont(size: .medium, bold: true)
        $0.textColor = .mainColor
        $0.textAlignment = .center
    }
    
    var booksPickerView = UIPickerView()
    
    var sentenceLabel = UILabel().then {
        $0.text = "권의 책을 기록하기"
        $0.font = .defaultFont(size: .medium, bold: true)
        $0.textColor = .mainColor
        $0.textAlignment = .center
    }

    var nextButton = UIButton().then {
        $0.isUserInteractionEnabled = false
        $0.setTitle("확인", for: .normal)
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
        self.addSubview(periodPickerView)
        self.addSubview(unitPickerView)
        self.addSubview(untilLabel)
        self.addSubview(booksPickerView)
        self.addSubview(sentenceLabel)
        self.addSubview(nextInformationLabel)
        self.addSubview(nextButton)
        
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
        periodPickerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.getAdjustedHeight(20.0))
            $0.left.equalTo(titleLabel)
            $0.height.equalTo(Constants.getAdjustedHeight(136.0))
            $0.width.equalTo(Constants.getAdjustedWidth(65.0))
        }
        unitPickerView.snp.makeConstraints {
            $0.top.equalTo(periodPickerView)
            $0.left.equalTo(periodPickerView.snp.right).offset(12)
            $0.height.equalTo(Constants.getAdjustedHeight(136.0))
            $0.width.equalTo(Constants.getAdjustedWidth(47.0))
        }
        untilLabel.snp.makeConstraints {
            $0.centerY.equalTo(unitPickerView)
            $0.left.equalTo(unitPickerView.snp.right).offset(12)
        }
        booksPickerView.snp.makeConstraints {
            $0.top.equalTo(periodPickerView)
            $0.left.equalTo(untilLabel.snp.right).offset(12)
            $0.height.equalTo(Constants.getAdjustedHeight(136.0))
            $0.width.equalTo(Constants.getAdjustedWidth(65.0))
        }
        sentenceLabel.snp.makeConstraints {
            $0.centerY.equalTo(unitPickerView)
            $0.left.equalTo(booksPickerView.snp.right).offset(12)
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
