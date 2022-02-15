//
//  ModifyGoalView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/08.
//

import UIKit

final class ModifyGoalView: UIView {
    var goalModifyTitleLabel = UILabel().then {
        $0.textColor = .mainColor
        $0.text = "독서 목표를 수정해주세요."
        $0.font = .defaultFont(size: 18, boldLevel: .bold)
    }
    
    var periodPickerView = UIPickerView().then {
        $0.layoutMargins = .zero
    }
    var unitPickerView = UIPickerView().then {
        $0.layoutMargins = .zero
    }
    
    var untilLabel = UILabel().then {
        $0.text = "동안"
        $0.font = .defaultFont(size: 14, boldLevel: .bold)
        $0.textColor = .mainColor
        $0.textAlignment = .center
    }
    
    var booksPickerView = UIPickerView().then {
        $0.layoutMargins = .zero
    }
    
    var sentenceLabel = UILabel().then {
        $0.text = "권의 책을 기록하기"
        $0.font = .defaultFont(size: 14, boldLevel: .bold)
        $0.textColor = .mainColor
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.addSubview(goalModifyTitleLabel)
        self.addSubview(periodPickerView)
        self.addSubview(unitPickerView)
        self.addSubview(untilLabel)
        self.addSubview(booksPickerView)
        self.addSubview(sentenceLabel)
        
        makeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeView() {
        goalModifyTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35.adjustedHeight)
            $0.left.equalToSuperview().inset(22.adjustedWidth)
        }
        periodPickerView.snp.makeConstraints {
            $0.top.equalTo(goalModifyTitleLabel.snp.bottom).offset(Constants.getAdjustedHeight(20.0))
            $0.left.equalTo(goalModifyTitleLabel)
            $0.height.equalTo(Constants.getAdjustedHeight(220.0))
            $0.width.equalTo(Constants.getAdjustedWidth(65.0))
        }
        unitPickerView.snp.makeConstraints {
            $0.top.equalTo(periodPickerView)
            $0.left.equalTo(periodPickerView.snp.right)//.offset(5.adjustedWidth)
            $0.height.equalTo(Constants.getAdjustedHeight(220.0))
            $0.width.equalTo(Constants.getAdjustedWidth(57.0))
        }
        untilLabel.snp.makeConstraints {
            $0.centerY.equalTo(unitPickerView)
            $0.left.equalTo(unitPickerView.snp.right).offset(5.adjustedWidth)
        }
        booksPickerView.snp.makeConstraints {
            $0.top.equalTo(periodPickerView)
            $0.left.equalTo(untilLabel.snp.right).offset(5.adjustedWidth)
            $0.height.equalTo(Constants.getAdjustedHeight(220.0))
            $0.width.equalTo(Constants.getAdjustedWidth(65.0))
        }
        sentenceLabel.snp.makeConstraints {
            $0.centerY.equalTo(unitPickerView)
            $0.left.equalTo(booksPickerView.snp.right).offset(5.adjustedWidth)
        }
    }
}
