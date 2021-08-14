//
//  SideMenuView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/09.
//

import UIKit

final class SideMenuView: UIView {
    var nameLabel = UILabel().then {
        $0.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        $0.adjustsFontForContentSizeCategory = true
        $0.textColor = .black
        $0.text = "이름"
    }
    
    var idLabel = UILabel().then {
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        $0.adjustsFontForContentSizeCategory = true
        $0.textColor = .black
        $0.text = "아이디: hi06021"
    }
    
    var modifyAccountButonn = UIButton().then {
        $0.setTitle("회원정보수정", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel!.font = UIFont.preferredFont(forTextStyle: .body)
        $0.titleLabel!.adjustsFontForContentSizeCategory = true
        $0.backgroundColor = .white
        $0.sizeToFit()
    }
    
    var myBookClubButton = UIButton().then {
        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        $0.titleLabel?.adjustsFontForContentSizeCategory = true
        $0.contentHorizontalAlignment = .left
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("▼ 나의 북클럽", for: .normal)
    }
    
    var myBookClubTableView = UITableView().then {
        $0.separatorColor = .black
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
    }
    
    var createBookClubButton = UIButton().then {
        $0.setTitle("북클럽 생성하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .backgroundGray
        $0.setShadow(opacity: 1, color: .lightGray, offset: CGSize(width: 0, height: 3), radius: 1)
    }
    
    lazy var myBookClubStack = UIStackView(arrangedSubviews: [myBookClubButton, myBookClubTableView, createBookClubButton]).then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.distribution = .equalSpacing
    }
    
    var joinedBookClubButton = UIButton().then {
        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        $0.titleLabel?.adjustsFontForContentSizeCategory = true
        $0.contentHorizontalAlignment = .left
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("▼ 참여한 북클럽", for: .normal)
    }
    
    var joinedClubTableView = UITableView().then {
        $0.separatorColor = .black
        $0.separatorStyle = .none
        $0.backgroundColor = .white
        $0.isScrollEnabled = false
    }
    
    lazy var joinedClubStack = UIStackView(arrangedSubviews: [joinedBookClubButton, joinedClubTableView]).then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.distribution = .equalSpacing
    }
    
    var alertButton = UIButton().then {
        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        $0.titleLabel?.adjustsFontForContentSizeCategory = true
        $0.contentHorizontalAlignment = .left
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("▼ 알림", for: .normal)
    }
    
    var alertTableView = UITableView().then {
        $0.separatorColor = .black
        $0.separatorStyle = .none
    }
    
    lazy var alertStack = UIStackView(arrangedSubviews: [alertButton, alertTableView]).then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.distribution = .equalSpacing
    }
    
    var usageButton = UIButton().then {
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.black.cgColor
        $0.backgroundColor = .white
        $0.setTitle(" 앱 활용법 ", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
        $0.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    // 우 하단 버튼 {
    var verticalLine1 = LineView(width: 1.0, color: .black)
    var verticalLine2 = LineView(width: 1.0, color: .black)
    var versionButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("앱버젼", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    var inquireButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("문의하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    var settingButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("설정", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    // }
    
    lazy var buttonStack = UIStackView(arrangedSubviews: [versionButton, verticalLine1, inquireButton, verticalLine2, settingButton]).then {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.distribution = .equalSpacing
        $0.alignment = .trailing
        $0.backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.addSubview(nameLabel)
        self.addSubview(idLabel)
        self.addSubview(modifyAccountButonn)
        self.addSubview(myBookClubStack)
        self.addSubview(joinedClubStack)
        self.addSubview(alertStack)
        self.addSubview(usageButton)
        self.addSubview(buttonStack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
        nameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(Constants.screenSize.height / 20)
        }
        idLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        modifyAccountButonn.snp.makeConstraints {
            $0.centerY.equalTo(idLabel)
            $0.right.equalToSuperview().inset(20)
        }
        myBookClubStack.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(Constants.screenSize.height / 25.0)
            $0.left.right.equalToSuperview().inset(20)
        }
        joinedClubStack.snp.makeConstraints {
            $0.top.equalTo(myBookClubStack.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(20)
        }
        alertStack.snp.makeConstraints {
            $0.top.equalTo(joinedClubStack.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(20)
        }
        usageButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
        buttonStack.snp.makeConstraints {
            $0.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
        verticalLine1.snp.makeConstraints {
            $0.width.equalTo(1.25)
            $0.top.bottom.equalToSuperview()
        }
        verticalLine2.snp.makeConstraints {
            $0.width.equalTo(1.25)
            $0.top.bottom.equalToSuperview()
        }
    }
}

