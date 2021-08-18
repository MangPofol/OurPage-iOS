//
//  MyLibraryView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/18.
//

import UIKit
import BetterSegmentedControl

class MyLibraryView: UIView {

    // custom segment control
    let typeControl = BetterSegmentedControl(frame: .zero)
    
    // 검색, 북클럽, 정렬 버튼
    let searchButton = ToggleButton(normalColor: .white, onColor: .mainColor).then {
        $0.setTitle("검색", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
        
        $0.makeBorder(color: UIColor.gray1.cgColor, width: 1.0, cornerRadius: 5)
    }
    let bookclubButton = ToggleButton(normalColor: .white, onColor: .mainColor).then {
        $0.setTitle("북클럽", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.backgroundColor = .white
        $0.makeBorder(color: UIColor.gray1.cgColor, width: 1.0, cornerRadius: 5)
    }
    let sortingButton = ToggleButton(normalColor: .white, onColor: .mainColor).then {
        $0.setTitle("정렬", for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.makeBorder(color: UIColor.gray1.cgColor, width: 1.0, cornerRadius: 5)
    }
    
    lazy var buttonStack = UIStackView(arrangedSubviews: [searchButton, bookclubButton, sortingButton]).then {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.distribution = .fillEqually
    }
    
    // collectionView
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(typeControl)
        self.addSubview(buttonStack)
        self.addSubview(collectionView)
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
        collectionView.snp.remakeConstraints {
            $0.top.equalTo(buttonStack.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constants.screenSize.width * 0.9)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
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
