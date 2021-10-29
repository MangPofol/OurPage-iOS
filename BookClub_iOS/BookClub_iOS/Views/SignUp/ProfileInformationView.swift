//
//  ProfileInformationView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/30.
//

import UIKit

final class ProfileInformationView: UIView {
    var titleLabel = UILabel().then {
        $0.text = "나의 독서 프로필 채워보기"
        $0.textColor = .mainColor
        $0.font = .defaultFont(size: .big, bold: true)
    }
    
    var contentLabel = UILabel().then {
        $0.text = "프로필을 당신만의 독서취향으로 채워보세요."
        $0.textColor = .mainColor
        $0.font = .defaultFont(size: .medium)
    }
    
    var nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .mainPink
        $0.setCornerRadius(radius: Constants.getAdjustedHeight(8.0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        self.addSubview(nextButton)
        
        makeView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeView() {
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(Constants.getAdjustedWidth(20.0))
            $0.top.equalToSuperview().inset(Constants.getAdjustedHeight(33.0))
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.getAdjustedHeight(10.0))
            $0.left.equalTo(titleLabel)
        }
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Constants.getAdjustedHeight(93.0))
            $0.width.equalTo(Constants.getAdjustedWidth(320.0))
            $0.height.equalTo(Constants.getAdjustedHeight(52.0))
        }
    }
}
