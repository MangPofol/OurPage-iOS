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
    let control = BetterSegmentedControl(frame: .zero)
    
    // collectionView
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    // 상단 버튼 stack
    lazy var controlStack = UIStackView(arrangedSubviews: [typeControl, control]).then {
        $0.axis = .vertical
        $0.spacing = 0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(controlStack)
        self.addSubview(collectionView)
        setSegmentedControls()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
        // autolayout set
        controlStack.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constants.screenSize.width * 0.9)
        }
        collectionView.snp.remakeConstraints {
            $0.top.equalTo(controlStack.snp.bottom).offset(20)
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
        control.segments = LabelSegment.segments(withTitles: ["나만보기", "북클럽 A", "북클럽 B", "북클럽 C"],
                                                 normalFont: UIFont.defaultFont(size: .medium),
                                                 normalTextColor: .gray1,
                                                 selectedFont: UIFont.defaultFont(size: .medium, bold: true),
                                                 selectedTextColor: .black)
        typeControl.setCustomSegment(underlineColor: .mainColor, indicatorHeight: 1.5)
        control.setCustomSegment(underlineColor: .black, indicatorHeight: 1.0)
    }
}
