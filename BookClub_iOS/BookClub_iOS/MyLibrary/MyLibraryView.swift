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
    let typeControl = BetterSegmentedControl(
        frame: .zero,
        segments: LabelSegment.segments(withTitles: ["읽는 중", "완독", "읽고 싶은"],
                                        normalFont: UIFont.defaultFont(size: .medium),
                                        normalTextColor: .mainColor,
                                        selectedFont: UIFont.defaultFont(size: .medium, bold: true),
                                        selectedTextColor: .white),
        options: [.cornerRadius(8.adjustedHeight),
                  .backgroundColor(UIColor(hexString: "EFF0F3")),
                  .indicatorViewBackgroundColor(.mainColor),
                  .indicatorViewInset(0.0)]
    )
    
    // 검색, 북클럽, 정렬 버튼
    let searchButton = ToggleButton(normalColor: .white, onColor: .mainColor).then {
        $0.setTitle("검색", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setImage(.SearchIconRegular.resize(to: CGSize(width: 8.11.adjustedWidth, height: 8.11.adjustedHeight)), for: .normal)
        $0.tintColor = .mainColor
//        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 43.adjustedWidth, bottom: 0, right: 0)
//        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8.adjustedWidth)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.setInsets(forContentPadding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), imageTitlePadding: 8.0)
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.backgroundColor = .white
        $0.makeBorder(color: UIColor.grayC3.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(13.0)))
    }
    let bookclubButton = ToggleButton(normalColor: .white, onColor: .mainColor).then {
        $0.setTitle("북클럽", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.backgroundColor = .white
        $0.makeBorder(color: UIColor.grayC3.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(13.0)))
    }
    let sortingButton = ToggleButton(normalColor: .white, onColor: .mainColor).then {
        $0.setTitle("정렬", for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.makeBorder(color: UIColor.grayC3.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(13.0)))
    }
    
    lazy var upperView = UIView().then {
        $0.backgroundColor = .white
        $0.addSubview(typeControl)
        $0.addSubview(searchButton)
        $0.addSubview(bookclubButton)
        $0.addSubview(sortingButton)
        $0.addShadow(location: .bottom, color: UIColor(hexString: "E5E5E5"))
    }
    
    // 선택하면 나올 컨트롤들 {
    // 서치바
    lazy var searchTextField = UITextField().then {
        $0.isHidden = true
        $0.placeholder = "책 제목을 입력하세요."
        $0.textColor = .mainColor
        $0.font = .defaultFont(size: 12)
        $0.leftViewMode = .always
        $0.backgroundColor = .white
        $0.makeBorder(color: UIColor.grayC3.cgColor, width: 1, cornerRadius: 8.adjustedHeight)
        // 아이콘 추가
        let imageView = UIImageView(frame: CGRect(x: 10.adjustedWidth, y: 9.adjustedHeight, width: 6.adjustedWidth, height: 6.adjustedHeight))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .mainColor
        imageView.image = .SearchIconRegular.resize(to: CGSize(width: 6.adjustedWidth, height: 6.adjustedHeight))
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 23.adjustedWidth, height: 25.adjustedHeight))
        view.addSubview(imageView)
        $0.leftView = view
    }
    
    // 북클럽 선택
    lazy var bookclubSelector = UICollectionView(frame: .zero, collectionViewLayout: bookclubSelectorLayout).then {
        $0.isHidden = true
        $0.backgroundColor = .clear
        $0.allowsMultipleSelection = true
    }
    
    // 정렬 방법 선택
    let byNewButton = ToggleButton(normalColor: UIColor(hexString: "EFF0F3"), onColor: .mainColor).then {
        $0.setTitle("최신순", for: .normal)
        $0.onTextColor = .white
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.setTitleColor(.mainColor, for: .normal)
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.setCornerRadius(radius: CGFloat(Constants.getAdjustedWidth(3.0)))
    }
    let byOldButton = ToggleButton(normalColor: UIColor(hexString: "EFF0F3"), onColor: .mainColor).then {
        $0.setTitle("오래된순", for: .normal)
        $0.onTextColor = .white
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.setTitleColor(.mainColor, for: .normal)
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.setCornerRadius(radius: CGFloat(Constants.getAdjustedWidth(3.0)))
    }
    let byNameButton = ToggleButton(normalColor: UIColor(hexString: "EFF0F3"), onColor: .mainColor).then {
        $0.setTitle("이름순", for: .normal)
        $0.onTextColor = .white
        $0.titleLabel?.font = .defaultFont(size: .small)
        $0.setTitleColor(.mainColor, for: .normal)
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.setCornerRadius(radius: CGFloat(Constants.getAdjustedWidth(3.0)))
    }
    lazy var sortButtonStack = UIStackView(arrangedSubviews: [byNewButton, byOldButton, byNameButton]).then {
        $0.isHidden = true
        $0.axis = .horizontal
        $0.spacing = CGFloat(Constants.buttonStackSpacing)
        $0.distribution = .fillEqually
        $0.alignment = .leading
        byNewButton.relatedButtons = [byOldButton, byNameButton]
        byOldButton.relatedButtons = [byNewButton, byNameButton]
        byNameButton.relatedButtons = [byNewButton, byOldButton]
    }
    
//    lazy var selectedControl = UIView().then {
//        $0.addSubview(searchTextField)
//        $0.addSubview(bookclubSelector)
//        $0.addSubview(sortButtonStack)
//        $0.backgroundColor = .clear
//        searchTextField.snp.makeConstraints { $0.edges.equalToSuperview() }
//        sortButtonStack.snp.makeConstraints {
//            $0.top.bottom.left.equalToSuperview()
//            $0.width.equalTo(Constants.screenSize.width * 0.45)
//        }
//    }
    
    // }
    
    var bookCollectionContainer = UIView().then {
        $0.backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(upperView)
        self.addSubview(bookCollectionContainer)
        self.addSubview(searchTextField)
        self.addSubview(bookclubSelector)
        self.addSubview(sortButtonStack)
        setSegmentedControls()
        searchButton.relatedButtons = [bookclubButton, sortingButton]
        bookclubButton.relatedButtons = [searchButton, sortingButton]
        sortingButton.relatedButtons = [searchButton, bookclubButton]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
        // autolayout set
        upperView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(111.adjustedHeight)
        }
        typeControl.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21.95.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20.adjustedWidth)
            $0.height.equalTo(35.adjustedHeight)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(typeControl.snp.bottom).offset(13.0.adjustedHeight)
            $0.left.equalTo(typeControl)
            $0.width.equalTo(61.adjustedWidth)
            $0.height.equalTo(26.adjustedHeight)
        }
        
        bookclubButton.snp.makeConstraints {
            $0.top.equalTo(typeControl.snp.bottom).offset(13.0.adjustedHeight)
            $0.left.equalTo(searchButton.snp.right).offset(8.adjustedWidth)
            $0.width.equalTo(51.adjustedWidth)
            $0.height.equalTo(26.adjustedHeight)
        }
        
        sortingButton.snp.makeConstraints {
            $0.top.equalTo(typeControl.snp.bottom).offset(13.0.adjustedHeight)
            $0.left.equalTo(bookclubButton.snp.right).offset(8.adjustedWidth)
            $0.width.equalTo(51.adjustedWidth)
            $0.height.equalTo(26.adjustedHeight)
        }
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(upperView.snp.bottom).offset(14.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(typeControl)
            $0.height.equalTo(29.adjustedHeight)
        }
        bookclubSelector.snp.makeConstraints {
            $0.top.equalTo(upperView.snp.bottom).offset(20.adjustedHeight)
            $0.left.equalTo(typeControl)
            $0.right.equalTo(typeControl)
            $0.height.equalTo(19.adjustedHeight)
        }
        sortButtonStack.snp.makeConstraints {
            $0.top.equalTo(upperView.snp.bottom).offset(20.adjustedHeight)
            $0.left.equalTo(typeControl)
            $0.width.equalTo(162.adjustedWidth)
            $0.height.equalTo(19.adjustedHeight)
        }
        bookCollectionContainer.snp.remakeConstraints { [unowned self] in
            $0.top.equalTo(upperView.snp.bottom).offset(20.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constants.getAdjustedWidth(335.0))
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
    }
    
    func setSegmentedControls() {
//        typeControl.segments = LabelSegment.segments(withTitles: ["읽는 중", "완독", "읽고 싶은"],
//                                                     normalFont: UIFont.defaultFont(size: .medium),
//                                                     normalTextColor: .black,
//                                                     selectedFont: UIFont.defaultFont(size: .medium, bold: true),
//                                                     selectedTextColor: .mainColor)
//        typeControl.setCustomSegment(underlineColor: .mainColor, indicatorHeight: Constants.getAdjustedWidth(2.0))
    }
}
