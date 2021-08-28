//
//  MyLibraryView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/18.
//

import UIKit
import BetterSegmentedControl

class MyLibraryView: UIView {

    // CollectionView layouts
    let bookclubSelectorLayout = UICollectionViewFlowLayout()
    let collectionViewLayout = UICollectionViewFlowLayout()
    
    // custom segment control
    let typeControl = BetterSegmentedControl(frame: .zero).then {
        $0.backgroundColor = .white
    }
    
    // 검색, 북클럽, 정렬 버튼
    let searchButton = ToggleButton(normalColor: .gray1, onColor: .mainColor).then {
        $0.setTitle("검색", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.backgroundColor = .gray1
        $0.makeBorder(color: UIColor.gray1.cgColor, width: 1.0, cornerRadius: 5)
    }
    let bookclubButton = ToggleButton(normalColor: .gray1, onColor: .mainColor).then {
        $0.setTitle("북클럽", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.backgroundColor = .gray1
        $0.makeBorder(color: UIColor.gray1.cgColor, width: 1.0, cornerRadius: 5)
    }
    let sortingButton = ToggleButton(normalColor: .gray1, onColor: .mainColor).then {
        $0.setTitle("정렬", for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .gray1
        $0.makeBorder(color: UIColor.gray1.cgColor, width: 1.0, cornerRadius: 5)
    }
    
    lazy var buttonStack = UIStackView(arrangedSubviews: [searchButton, bookclubButton, sortingButton]).then {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.distribution = .fillEqually
        searchButton.relatedButtons = [bookclubButton, sortingButton]
        bookclubButton.relatedButtons = [searchButton, sortingButton]
        sortingButton.relatedButtons = [searchButton, bookclubButton]
    }
    
    // 선택하면 나올 컨트롤들 {
    // 서치바
    lazy var searchBar = UISearchBar().then {
        $0.isHidden = true
        $0.placeholder = "책 제목을 입력하세요."
        $0.searchTextField.font = .defaultFont(size: .small)
    }
    
    // 북클럽 선택
    lazy var bookclubSelector = UICollectionView(frame: .zero, collectionViewLayout: bookclubSelectorLayout).then {
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
        $0.addSubview(bookclubSelector)
        $0.addSubview(sortButtonStack)
        searchBar.snp.makeConstraints { $0.edges.equalToSuperview() }
        sortButtonStack.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview()
            $0.width.equalTo(Constants.screenSize.width * 0.45)
        }
    }
    
    // }
    
    var bookCollectionContainer = UIView().then {
        $0.backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(typeControl)
        self.addSubview(buttonStack)
        self.addSubview(bookCollectionContainer)
        self.addSubview(selectedControl)
        setSegmentedControls()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
        // autolayout set
        typeControl.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constants.screenSize.width * 0.9)
        }
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(typeControl.snp.bottom).offset(12)
            $0.left.equalTo(typeControl)
            $0.width.equalTo(typeControl).multipliedBy(0.55)
        }
        selectedControl.snp.makeConstraints {
            $0.top.equalTo(buttonStack.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constants.screenSize.width * 0.9)
            $0.height.equalTo(0)
        }
        bookCollectionContainer.snp.remakeConstraints {
            $0.top.equalTo(selectedControl.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constants.screenSize.width * 0.9)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
        bookclubSelector.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(typeControl)
            $0.width.equalTo(Constants.screenSize.width * 0.75)
        }
        bookclubSelector.contentInset.top = (30.0 - Constants.bookclubSelectorSize().height) / 2.0
    }
    
    func setSegmentedControls() {
        typeControl.segments = LabelSegment.segments(withTitles: ["읽는 중", "완독", "읽고 싶은"],
                                                     normalFont: UIFont.defaultFont(size: .medium),
                                                     normalTextColor: .black,
                                                     selectedFont: UIFont.defaultFont(size: .medium, bold: true),
                                                     selectedTextColor: .mainColor)
        typeControl.setCustomSegment(underlineColor: .mainColor, indicatorHeight: 1.5)
    }
}
