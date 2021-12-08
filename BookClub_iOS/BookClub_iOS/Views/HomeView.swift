//
//  HomeView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/29.
//

import UIKit

final class HomeView: UIView {
    var backgroundImageView = UIImageView().then {
        $0.image = .HomeBackgroundImage
        $0.contentMode = .scaleAspectFill
    }
    
    var userNameLabel = UILabel().then {
        $0.text = "홍길동님,"
        $0.font = .defaultFont(size: 24, boldLevel: .bold)
        $0.textColor = .mainColor
        $0.backgroundColor = .clear
    }
    
    var welcomeLabel = UILabel().then {
        $0.text = "오늘도 힘차게 기록해봅시다."
        $0.font = .defaultFont(size: 24, boldLevel: .bold)
        $0.textColor = .mainColor
        $0.backgroundColor = .clear
    }
    
    var totalPageLabel = UILabel().then {
        $0.text = "total 396 pages"
        $0.font = .defaultFont(size: 10, boldLevel: .medium)
        $0.textColor = .white
        $0.textAlignment = .center
        
        $0.backgroundColor = .clear
    }
    lazy var totalPageLabelContainer = UIView().then {
        $0.backgroundColor = .mainColor
        $0.setCornerRadius(radius: 10.adjustedHeight)
        $0.addSubview(totalPageLabel)
    }
    
    var recordForDateLabel = UILabel().then {
        $0.text = "The record for \(Date().toEnglishMonthDay())."
        $0.font = .defaultFont(size: 10, boldLevel: .medium)
        $0.textColor = .white
        $0.textAlignment = .center
        
        $0.backgroundColor = .clear
    }
    lazy var recordForDateLabelContainer = UIView().then {
        $0.backgroundColor = .mainColor
        $0.setCornerRadius(radius: 10.adjustedHeight)
        $0.addSubview(recordForDateLabel)
    }
    
    var myProfileButton = UIButton().then {
        $0.setImage(.RightArrowBoldIcon.resize(to: CGSize(width: 5.48, height: 9.51).resized(basedOn: .height)), for: .normal)
        $0.backgroundColor = .clear
        $0.tintColor = .mainColor
        
        $0.imageView?.contentMode = .scaleAspectFit
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 375.adjustedWidth - 40.adjustedWidth, bottom: 0, right: 0)
    }
    
    var goalButton = UIButton().then {
        $0.setTitle("1년에 10권 읽고 기록하기", for: .normal)
        $0.titleLabel?.font = .defaultFont(size: 14, boldLevel: .semiBold)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15.3.adjustedWidth, bottom: 0, right: 0)
        $0.setTitleColor(.mainColor, for: .normal)
        $0.contentHorizontalAlignment = .left
        
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.setCornerRadius(radius: 8.adjustedHeight)
        
        $0.setImage(.RightArrowBoldIcon.resize(to: CGSize(width: 5.48, height: 9.51).resized(basedOn: .height)), for: .normal)
        
        $0.imageView?.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview().inset(17.adjustedWidth)
        }
        $0.imageView?.contentMode = .scaleAspectFit
        $0.tintColor = .mainColor
        $0.imageView?.contentMode = .center
    }
    
    var checkListHeader = CheckListButton()
    
    var checkListTableView = UITableView().then {
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.bottomRoundCorner(radius: 8.adjustedHeight)
    }
    
    var writeButton = WriteRecordButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(backgroundImageView)
        self.addSubview(userNameLabel)
        self.addSubview(welcomeLabel)
        self.addSubview(totalPageLabelContainer)
        self.addSubview(recordForDateLabelContainer)
        self.addSubview(myProfileButton)
        self.addSubview(goalButton)
        self.addSubview(checkListHeader)
        self.addSubview(checkListTableView)
        self.addSubview(writeButton)
        
        makeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
        backgroundImageView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().inset(50.adjustedHeight)
            $0.height.equalTo(152.adjustedHeight)
        }
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundImageView).inset(54.adjustedHeight)
            $0.left.equalToSuperview().inset(25.adjustedWidth)
        }
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom)
            $0.left.equalTo(userNameLabel)
            $0.width.equalTo(283.adjustedWidth)
        }
        totalPageLabelContainer.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(26.adjustedHeight)
            $0.left.equalTo(welcomeLabel)
            $0.height.equalTo(20.22.adjustedHeight)
        }
        totalPageLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(13.adjustedWidth)
        }
        recordForDateLabelContainer.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(26.adjustedHeight)
            $0.left.equalTo(totalPageLabelContainer.snp.right).offset(5.9.adjustedWidth)
            $0.height.equalTo(20.22.adjustedHeight)
        }
        recordForDateLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(13.adjustedWidth)
        }
        myProfileButton.snp.makeConstraints {
            $0.centerY.equalTo(welcomeLabel)
            $0.width.equalToSuperview()
            $0.height.equalTo(29.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        goalButton.snp.makeConstraints {
            $0.top.equalTo(totalPageLabel.snp.bottom).offset(70.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedWidth)
            $0.height.equalTo(35.adjustedHeight)
        }
        checkListHeader.snp.makeConstraints {
            $0.top.equalTo(goalButton.snp.bottom).offset(11.81.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedWidth)
            $0.height.equalTo(35.adjustedHeight)
        }
        checkListTableView.snp.makeConstraints {
            $0.top.equalTo(checkListHeader.snp.bottom)
            $0.left.right.equalTo(checkListHeader)
            $0.height.equalTo(0)
        }
        writeButton.snp.makeConstraints {
            $0.top.equalTo(checkListTableView.snp.bottom).offset(11.81.adjustedHeight)
            $0.left.right.equalTo(goalButton)
            $0.height.equalTo(35.adjustedHeight)
        }
    }
}

final class WriteRecordButton: UIView {
    var titleLabel = UILabel().then {
        $0.text = "기록 쓰러가기"
        $0.font = .defaultFont(size: 14, boldLevel: .bold)
        $0.textColor = .white
    }
    
    var writeButton = UIButton().then {
        $0.setImage(.WriteIcon.resize(to: CGSize(width: 12.53.adjustedWidth, height: 12.41.adjustedHeight)), for: .normal)
        $0.tintColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .mainPink
        self.setCornerRadius(radius: 8.adjustedHeight)
        
        self.addSubview(titleLabel)
        self.addSubview(writeButton)
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(14.adjustedWidth)
            $0.centerY.equalToSuperview()
        }
        writeButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(14.46.adjustedWidth)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class CheckListButton: UIView {
    var titleLabel = UILabel().then {
        $0.text = "CHECK LIST"
        $0.font = .defaultFont(size: 14, boldLevel: .semiBold)
        $0.textColor = .mainColor
    }
    
    var settingButton = UIButton().then {
        $0.setImage(.settingIcon, for: .normal)
        $0.tintColor = .mainColor
        $0.imageEdgeInsets = UIEdgeInsets(top: 7.adjustedHeight, left: 7.5.adjustedHeight, bottom: 8.adjustedHeight, right: 7.5.adjustedHeight)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    var lineView = UIView().then {
        $0.backgroundColor = .mainColor
    }
    
    var openButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(.DownArrow, for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 9.14.adjustedHeight, left: 7.59.adjustedHeight, bottom: 10.38.adjustedHeight, right: 7.89.adjustedHeight)
        $0.tintColor = .mainColor
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hexString: "EFF0F3")
        self.setCornerRadius(radius: 8.adjustedHeight)
        
        self.addSubview(titleLabel)
        self.addSubview(settingButton)
        self.addSubview(lineView)
        self.addSubview(openButton)
        
        makeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeView() {
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(17.3.adjustedWidth)
        }
        
        openButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(7.adjustedWidth)
            $0.width.height.equalTo(25.adjustedHeight)
        }
        
        lineView.snp.makeConstraints {
            $0.right.equalTo(openButton.snp.left).offset(-3.adjustedWidth)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(1.adjustedWidth)
            $0.height.equalTo(11.adjustedHeight)
        }
        
        settingButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(lineView.snp.left).offset(-3.adjustedWidth)
            $0.width.height.equalTo(25.adjustedHeight)
        }
    }
}
