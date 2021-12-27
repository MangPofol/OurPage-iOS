//
//  SideMenuView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/09.
//

import UIKit


final class SideMenuView: UIView {
    
    var profileImageView = UIImageView().then {
        $0.image = .DefaultProfileImage
    }
    
    var nameLabel = UILabel().then {
        $0.font = .defaultFont(size: .name_20, bold: true)
        $0.textColor = .white
        $0.text = "Thama"
    }
    
    var idLabel = UILabel().then {
        $0.font = .defaultFont(size: .cellFont)
        $0.textColor = .white
        $0.text = "@hi06021"
    }
    
    lazy var upperView = UIView().then {
        $0.backgroundColor = .mainColor
        $0.addSubview(nameLabel)
        $0.addSubview(idLabel)
        $0.addSubview(profileImageView)
        $0.bottomRightCorner(radius: CGFloat(Constants.getAdjustedHeight(20.0)))
    }
    
    var itemsContainer = UIView().then {
        $0.backgroundColor = .white
    }
    
//    var modifyAccountButonn = UIButton().then {
//        $0.setTitle("회원정보수정", for: .normal)
//        $0.setTitleColor(.black, for: .normal)
//        $0.titleLabel!.font = UIFont.preferredFont(forTextStyle: .body)
//        $0.titleLabel!.adjustsFontForContentSizeCategory = true
//        $0.backgroundColor = .white
//        $0.sizeToFit()
//    }
//
//    var myBookClubButton = UIButton().then {
//        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
//        $0.titleLabel?.adjustsFontForContentSizeCategory = true
//        $0.contentHorizontalAlignment = .left
//        $0.setTitleColor(.black, for: .normal)
//        $0.setTitle("▼ 나의 북클럽", for: .normal)
//    }
//
//    var myBookClubTableView = UITableView().then {
//        $0.separatorColor = .black
//        $0.separatorStyle = .none
//        $0.isScrollEnabled = false
//    }
//
//    var createBookClubButton = UIButton().then {
//        $0.setTitle("북클럽 생성하기", for: .normal)
//        $0.setTitleColor(.black, for: .normal)
//        $0.backgroundColor = .backgroundGray
//        $0.setShadow(opacity: 1, color: .lightGray, offset: CGSize(width: 0, height: 3), radius: 1)
//    }
//
//    lazy var myBookClubStack = UIStackView(arrangedSubviews: [myBookClubButton, myBookClubTableView, createBookClubButton]).then {
//        $0.axis = .vertical
//        $0.spacing = 0
//        $0.distribution = .equalSpacing
//    }
//
//    var joinedBookClubButton = UIButton().then {
//        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
//        $0.titleLabel?.adjustsFontForContentSizeCategory = true
//        $0.contentHorizontalAlignment = .left
//        $0.setTitleColor(.black, for: .normal)
//        $0.setTitle("▼ 참여한 북클럽", for: .normal)
//    }
//
//    var joinedClubTableView = UITableView().then {
//        $0.separatorColor = .black
//        $0.separatorStyle = .none
//        $0.backgroundColor = .white
//        $0.isScrollEnabled = false
//    }
//
//    lazy var joinedClubStack = UIStackView(arrangedSubviews: [joinedBookClubButton, joinedClubTableView]).then {
//        $0.axis = .vertical
//        $0.spacing = 5
//        $0.distribution = .equalSpacing
//    }
//
//    var alertButton = UIButton().then {
//        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
//        $0.titleLabel?.adjustsFontForContentSizeCategory = true
//        $0.contentHorizontalAlignment = .left
//        $0.setTitleColor(.black, for: .normal)
//        $0.setTitle("▼ 알림", for: .normal)
//    }
//
//    var alertTableView = UITableView().then {
//        $0.separatorColor = .black
//        $0.separatorStyle = .none
//    }
//
//    lazy var alertStack = UIStackView(arrangedSubviews: [alertButton, alertTableView]).then {
//        $0.axis = .vertical
//        $0.spacing = 5
//        $0.distribution = .equalSpacing
//    }
//
//    var usageButton = UIButton().then {
//        $0.layer.borderWidth = 1.0
//        $0.layer.borderColor = UIColor.black.cgColor
//        $0.backgroundColor = .white
//        $0.setTitle(" 앱 활용법 ", for: .normal)
//        $0.setTitleColor(.black, for: .normal)
//        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
//        $0.titleLabel?.adjustsFontForContentSizeCategory = true
//    }
//
//    // 우 하단 버튼 {
//    var verticalLine1 = LineView(width: 1.0, color: .black)
//    var verticalLine2 = LineView(width: 1.0, color: .black)
//    var versionButton = UIButton().then {
//        $0.backgroundColor = .white
//        $0.setTitle("앱버젼", for: .normal)
//        $0.setTitleColor(.black, for: .normal)
//    }
//    var inquireButton = UIButton().then {
//        $0.backgroundColor = .white
//        $0.setTitle("문의하기", for: .normal)
//        $0.setTitleColor(.black, for: .normal)
//    }
//    var settingButton = UIButton().then {
//        $0.backgroundColor = .white
//        $0.setTitle("설정", for: .normal)
//        $0.setTitleColor(.black, for: .normal)
//    }
//    // }
//
//    lazy var buttonStack = UIStackView(arrangedSubviews: [versionButton, verticalLine1, inquireButton, verticalLine2, settingButton]).then {
//        $0.axis = .horizontal
//        $0.spacing = 5
//        $0.distribution = .equalSpacing
//        $0.alignment = .trailing
//        $0.backgroundColor = .white
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.addSubview(upperView)
        self.addSubview(itemsContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
        upperView.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(Constants.getAdjustedHeight(150.0))
        }
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(Constants.getAdjustedHeight(44.0))
            $0.left.equalToSuperview().inset(Constants.getAdjustedWidth(22.0))
            $0.bottom.equalToSuperview().inset(Constants.getAdjustedHeight(19.0))
        }
        idLabel.snp.makeConstraints {
            $0.left.equalTo(profileImageView.snp.right).offset(Constants.getAdjustedWidth(12.0))
            $0.bottom.equalToSuperview().inset(Constants.getAdjustedHeight(23.0))
        }
        nameLabel.snp.makeConstraints {
            $0.left.equalTo(idLabel)
            $0.bottom.equalTo(idLabel.snp.top).offset(Constants.getAdjustedHeight(-7.0))
        }
        itemsContainer.snp.makeConstraints {
            $0.top.equalTo(upperView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        profileImageView.setCornerRadius(radius: CGFloat(Constants.getAdjustedHeight(22.0)))
        
//        modifyAccountButonn.snp.makeConstraints {
//            $0.centerY.equalTo(idLabel)
//            $0.right.equalToSuperview().inset(20)
//        }
//        myBookClubStack.snp.makeConstraints {
//            $0.top.equalTo(idLabel.snp.bottom).offset(Constants.screenSize.height / 25.0)
//            $0.left.right.equalToSuperview().inset(20)
//        }
//        joinedClubStack.snp.makeConstraints {
//            $0.top.equalTo(myBookClubStack.snp.bottom).offset(20)
//            $0.left.right.equalToSuperview().inset(20)
//        }
//        alertStack.snp.makeConstraints {
//            $0.top.equalTo(joinedClubStack.snp.bottom).offset(20)
//            $0.left.right.equalToSuperview().inset(20)
//        }
//        usageButton.snp.makeConstraints {
//            $0.left.equalToSuperview().inset(20)
//            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
//        }
//        buttonStack.snp.makeConstraints {
//            $0.right.equalToSuperview().inset(20)
//            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
//        }
//        verticalLine1.snp.makeConstraints {
//            $0.width.equalTo(1.25)
//            $0.top.bottom.equalToSuperview()
//        }
//        verticalLine2.snp.makeConstraints {
//            $0.width.equalTo(1.25)
//            $0.top.bottom.equalToSuperview()
//        }
    }
}

