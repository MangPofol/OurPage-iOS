//
//  BookclubView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/26.
//

import UIKit

class BookclubView: UIView {
    let clubMemberSelectorLayout = UICollectionViewFlowLayout()
    
    var levelView = UIImageView().then {
        $0.backgroundColor = .mainColor
        $0.image = .bookclubLevelImage
    }
    
    let memberProfileFlowLayout = UICollectionViewFlowLayout()
    lazy var memberProfileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: memberProfileFlowLayout).then {
        $0.backgroundColor = .mainColor
        memberProfileFlowLayout.scrollDirection = .horizontal
        let size = Constants.profileImageSize().width
        memberProfileFlowLayout.minimumLineSpacing = -(size / 5.0)
//        memberProfileFlowLayout.minimumInteritemSpacing = -(size / 2.0)
        $0.register(MemberProfileCollectionViewCell.self, forCellWithReuseIdentifier: MemberProfileCollectionViewCell.identifier)
    }
    
    var introducingLabel = UILabel().then {
        $0.font = .defaultFont(size: .introducing)
        $0.textColor = .white
        $0.text = "북클럽 한 줄 소개"
    }
    
    lazy var upperView = UIView().then {
        $0.backgroundColor = .mainColor
        $0.addSubview(levelView)
        $0.addSubview(introducingLabel)
        $0.addSubview(memberProfileCollectionView)
    }
    
    var hotContainer = UIView().then {
        $0.backgroundColor = .white
    }
    
    
    var underline1 = LineView().then { $0.backgroundColor = .mainColor }
    var underline2 = LineView().then { $0.backgroundColor = .grayC3 }
    var recordCollectionLabel = UILabel().then {
        $0.font = .defaultFont(size: .medium, bold: true)
        $0.textColor = .mainColor
        $0.text = " 기록 모아보기 "
    }
    
    // 필터 버튼
    let searchButton = ToggleButton(normalColor: .white, onColor: .mainColor).then {
        $0.setTitle("검색", for: .normal)
        
        $0.imageView?.contentMode = .scaleAspectFit
        $0.setImage(.SearchIconRegular.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageView?.tintColor = .mainColor
        $0.semanticContentAttribute = .forceRightToLeft
        $0.setInsets(forContentPadding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), imageTitlePadding: 8.0)
        
        $0.setTitleColor(.mainColor, for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.backgroundColor = .white
        $0.makeBorder(color: UIColor.grayC3.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(12.5)))
    }
    let clubMemberButton = ToggleButton(normalColor: .white, onColor: .mainColor).then {
        $0.setTitle("클럽원", for: .normal)
        $0.setTitleColor(.mainColor, for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.backgroundColor = .white
        $0.makeBorder(color: UIColor.grayC3.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(12.5)))
    }
    let sortingButton = ToggleButton(normalColor: .white, onColor: .mainColor).then {
        $0.setTitle("정렬", for: .normal)
        $0.setTitleColor(.mainColor, for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.backgroundColor = .white
        $0.makeBorder(color: UIColor.grayC3.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(12.5)))
    }
    
    lazy var buttonStack = UIStackView(arrangedSubviews: [searchButton, clubMemberButton, sortingButton]).then {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.distribution = .fillEqually
        sortingButton.relatedButtons = [searchButton, clubMemberButton]
        clubMemberButton.relatedButtons = [searchButton, sortingButton]
        searchButton.relatedButtons = [clubMemberButton, sortingButton]
    }
    
    // 선택하면 나올 컨트롤들 {
    // 서치바
    lazy var searchBar = UISearchBar().then {
        $0.isHidden = true
        $0.backgroundImage = .none
        $0.autocorrectionType = .no
        
        $0.placeholder = "책 제목을 입력하세요."
        
        $0.makeBorder(color: UIColor.grayE3.cgColor, width: CGFloat(Constants.getAdjustedWidth(1.0)), cornerRadius: CGFloat(Constants.getAdjustedHeight(8.0)))
        $0.searchTextField.tintColor = .mainColor
        $0.searchTextField.textColor = .mainColor
        $0.searchTextField.backgroundColor = .white
        $0.searchTextField.font = .defaultFont(size: .small)
        $0.searchTextField.textAlignment = .left
        $0.searchTextField.leftView?.tintColor = .mainColor
    }
    
    // 북클럽 선택
    lazy var clubMemeberSelector = UICollectionView(frame: .zero, collectionViewLayout: clubMemberSelectorLayout).then {
        $0.isHidden = true
        $0.backgroundColor = .white
        $0.allowsMultipleSelection = true
    }
    
    // 정렬 방법 선택
    let byNewButton = ToggleButton(normalColor: .gray1, onColor: .mainColor).then {
        $0.setTitle("최신순", for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .gray1
        $0.setCornerRadius(radius: 3)
    }
    let byOldButton = ToggleButton(normalColor: .gray1, onColor: .mainColor).then {
        $0.setTitle("오래된순", for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .gray1
        $0.setCornerRadius(radius: 3)
    }
    let byNameButton = ToggleButton(normalColor: .gray1, onColor: .mainColor).then {
        $0.setTitle("이름순", for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .gray1
        $0.setCornerRadius(radius: 3)
    }
    lazy var sortButtonStack = UIStackView(arrangedSubviews: [byNewButton, byOldButton, byNameButton]).then {
        $0.isHidden = true
        $0.axis = .horizontal
        $0.spacing = 5
        $0.distribution = .fillEqually
        $0.alignment = .leading
        byNewButton.relatedButtons = [byOldButton, byNameButton]
        byOldButton.relatedButtons = [byNewButton, byNameButton]
        byNameButton.relatedButtons = [byNewButton, byOldButton]
    }
    
    lazy var selectedControl = UIView().then {
        $0.addSubview(searchBar)
        $0.addSubview(clubMemeberSelector)
        $0.addSubview(sortButtonStack)
        searchBar.snp.makeConstraints { $0.edges.equalToSuperview().inset(1.0) }
        sortButtonStack.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview()
            $0.width.equalTo(Constants.screenSize.width * 0.45)
        }
    }
    
    // }
    
    var bookCollectionContainer = UIView().then {
        $0.backgroundColor = .white
    }
    
    lazy var lowerView = UIView().then {
        $0.addSubview(hotContainer)
        $0.addSubview(recordCollectionLabel)
        $0.addSubview(underline2)
        $0.addSubview(underline1)
        $0.addSubview(buttonStack)
        $0.addSubview(selectedControl)
        $0.backgroundColor = .white
        $0.topRoundCorner(radius: 20)
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(upperView)
        self.addSubview(lowerView)
        self.addSubview(bookCollectionContainer)
//        self.addSubview(memberProfileCollectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
        levelView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(Constants.getAdjustedHeight(20.0))
            $0.width.equalTo(Constants.getAdjustedWidth(116.0))
            $0.height.equalTo(Constants.getAdjustedHeight(25.0))
        }
        
        introducingLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(levelView.snp.bottom).offset(Constants.getAdjustedHeight(10.0))
        }
    
        memberProfileCollectionView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(introducingLabel.snp.bottom).offset(Constants.getAdjustedHeight(11.0))
            $0.height.equalTo(Constants.profileImageSize().height)
        }
        
        upperView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(Constants.getAdjustedHeight(185.0))
        }
        
        // lowerview {
        lowerView.snp.makeConstraints {
            $0.top.equalTo(upperView.snp.bottom).offset(-Constants.getAdjustedHeight(35.0))
//            $0.left.right.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(Constants.getAdjustedHeight(300.0))
            //279
        }
        
        hotContainer.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(Constants.getAdjustedWidth(20.0))
            $0.top.equalToSuperview().inset(Constants.getAdjustedHeight(16.0))
            $0.height.equalTo(191.10)
        }
        
        recordCollectionLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(Constants.getAdjustedWidth(20.0))
            $0.top.equalTo(hotContainer.snp.bottom).offset(5)
        }
        underline1.snp.makeConstraints {
            $0.left.right.equalTo(recordCollectionLabel)
            $0.top.equalTo(recordCollectionLabel.snp.bottom).offset(8)
            $0.height.equalTo(1.5)
        }
        underline2.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(Constants.getAdjustedWidth(20.0))
            $0.top.equalTo(recordCollectionLabel.snp.bottom).offset(8)
            $0.height.equalTo(1.5)
        }
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(underline1).offset(Constants.getAdjustedHeight(14.0))
            $0.left.equalTo(recordCollectionLabel)
            $0.width.equalTo(lowerView).dividedBy(2.0)
            $0.height.equalTo(Constants.getAdjustedHeight(25.0))
        }
        selectedControl.snp.makeConstraints {
            $0.top.equalTo(buttonStack.snp.bottom).offset(Constants.getAdjustedHeight(12.0))
            $0.left.equalTo(buttonStack)
            $0.width.equalTo(Constants.screenSize.width * 0.9)
            $0.height.equalTo(0)
        }
        clubMemeberSelector.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(selectedControl)
            $0.width.equalTo(Constants.screenSize.width * 0.75)
        }
        // }
        
        bookCollectionContainer.snp.remakeConstraints { [unowned self] in
            $0.top.equalTo(selectedControl.snp.bottom).offset(Constants.getAdjustedHeight(12.0))
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constants.screenSize.width * 0.9)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
