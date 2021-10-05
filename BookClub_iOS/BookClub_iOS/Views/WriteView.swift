//
//  WriteView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/10.
//

import UIKit
import RxSwift

class WriteView: UIView {
    var bookSelectionButton = ButtonWithImage(frame: .zero).then {
        $0.backgroundColor = .white
        $0.button.setTitle("기록할 책을 선택해주세요", for: .normal)
        $0.button.setTitleColor(.mainColor, for: .normal)
        $0.button.titleLabel?.font = .defaultFont(size: .medium, bold: false)
        $0.imageView.image = .rightArrowImage
        $0.imageView.tintColor = .mainColor
    }
    
    var bookSelectionButtonUnderLine = LineView().then {
        $0.backgroundColor = .mainColor
    }
    
    var memoButton = ToggleButton(normalColor: .white, onColor: .mainColor).then {
        $0.setTitle("MEMO", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small, bold: true)
        $0.backgroundColor = .white
        $0.makeBorder(color: UIColor.grayC3.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(13.0)))
    }
    
    var topicButton = ToggleButton(normalColor: .white, onColor: .mainColor).then {
        $0.setTitle("TOPIC", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .defaultFont(size: .small, bold: true)
        $0.backgroundColor = .white
        $0.makeBorder(color: UIColor.grayC3.cgColor, width: 1.0, cornerRadius: CGFloat(Constants.getAdjustedHeight(13.0)))
    }
    
    var imageUploadButton = UIButton().then {
        $0.backgroundColor = .white
        $0.makeBorder(color: UIColor.pink_E5949D.cgColor, width: 1.5, cornerRadius: CGFloat(Constants.getAdjustedHeight(8.0)))
        $0.setTitle("0/4", for: .normal)
        $0.setTitleColor(.pink_E5949D, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.titleLabel?.font = .defaultFont(size: .small, bold: false)
        $0.setImage(.cameraIcon, for: .normal)
        $0.imageView?.tintColor = .pink_E5949D
        $0.alignTextBelow(spacing: 0.0)
    }
    
    let uploadedImageCollectionFlowLayout = UICollectionViewFlowLayout()
    lazy var uploadedImageCollection = UICollectionView(frame: .zero, collectionViewLayout: uploadedImageCollectionFlowLayout).then {
        $0.backgroundColor = .white
        uploadedImageCollectionFlowLayout.scrollDirection = .horizontal
        let size = CGSize(width: Constants.getAdjustedHeight(40.0), height: Constants.getAdjustedHeight(39.0))
//        uploadedImageCollectionFlowLayout.minimumLineSpacing = -(size.width / 5.0)
        uploadedImageCollectionFlowLayout.minimumInteritemSpacing = CGFloat(Constants.getAdjustedWidth(12.0))
        $0.register(UploadedImageCollectionViewCell.self, forCellWithReuseIdentifier: UploadedImageCollectionViewCell.identifier)
    }
    
    var imageUploadButtonUnderLine = LineView().then {
        $0.backgroundColor = .grayC3
    }
    
    var titleTextField = UITextField().then {
        $0.placeholder = "제목을 입력해주세요."
        $0.font = .defaultFont(size: .big, bold: true)
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
    }
    
    var contentTextView = UITextView().then {
        $0.font = .defaultFont(size: .medium)
        $0.textColor = .grayB0
        $0.text = "내용을 입력하세요."
        $0.autocorrectionType = .no
    
        // 공백 없애기
        $0.textContainer.lineFragmentPadding = 0
        $0.textContainerInset = .zero
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(bookSelectionButton)
        self.addSubview(bookSelectionButtonUnderLine)
        self.addSubview(memoButton)
        self.addSubview(topicButton)
        self.addSubview(imageUploadButton)
        self.addSubview(uploadedImageCollection)
        self.addSubview(imageUploadButtonUnderLine)
        self.addSubview(titleTextField)
        self.addSubview(contentTextView)
        memoButton.relatedButtons = [topicButton]
        topicButton.relatedButtons = [memoButton]
        makeView()
    }
    
    func makeView() {
        bookSelectionButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.getAdjustedHeight(20.0))
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Constants.getAdjustedHeight(30.0))
            $0.width.equalTo(Constants.getAdjustedWidth(334.0))
        }
        
        bookSelectionButtonUnderLine.snp.makeConstraints {
            $0.top.equalTo(bookSelectionButton.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(bookSelectionButton)
            $0.height.equalTo(2.0)
        }
        
        memoButton.snp.makeConstraints {
            $0.left.equalTo(bookSelectionButton)
            $0.top.equalTo(bookSelectionButton.snp.bottom).offset(Constants.getAdjustedHeight(14.0))
            $0.width.equalTo(Constants.getAdjustedWidth(51.0))
            $0.height.equalTo(Constants.getAdjustedHeight(26.0))
        }
        
        topicButton.snp.makeConstraints {
            $0.width.height.equalTo(memoButton)
            $0.top.equalTo(bookSelectionButton.snp.bottom).offset(Constants.getAdjustedHeight(14.0))
            $0.left.equalTo(memoButton.snp.right).offset(Constants.getAdjustedWidth(8.0))
        }
        
        imageUploadButton.snp.makeConstraints {
            $0.top.equalTo(memoButton.snp.bottom).offset(Constants.getAdjustedHeight(25.0))
            $0.width.height.equalTo(Constants.getAdjustedHeight(37.0))
            $0.left.equalTo(memoButton)
        }
        
        uploadedImageCollection.snp.makeConstraints {
            $0.bottom.equalTo(imageUploadButton)
            $0.height.equalTo(Constants.getAdjustedHeight(40.0))
            $0.left.equalTo(imageUploadButton.snp.right).offset(Constants.getAdjustedWidth(15.0))
            $0.right.equalToSuperview()
        }
        
        imageUploadButtonUnderLine.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(1.0)
            $0.width.equalTo(bookSelectionButtonUnderLine)
            $0.top.equalTo(imageUploadButton.snp.bottom).offset(Constants.getAdjustedHeight(9.0))
        }
        
        titleTextField.snp.makeConstraints {
            $0.left.right.equalTo(bookSelectionButton)
            $0.top.equalTo(imageUploadButtonUnderLine.snp.bottom).offset(Constants.getAdjustedHeight(10.0))
        }
        
        contentTextView.snp.makeConstraints {
            $0.left.equalTo(titleTextField)
            $0.top.equalTo(titleTextField.snp.bottom).offset(Constants.getAdjustedHeight(14.0))
            $0.width.equalTo(Constants.getAdjustedWidth(316.0))
            $0.height.equalTo(Constants.getAdjustedHeight(308.0))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UploadedImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "UploadedImageCollectionViewCell"
    
    var disposeBag = DisposeBag()
    
    var imageView = UIImageView().then {
        $0.setCornerRadius(radius: CGFloat(Constants.getAdjustedHeight(8.0)))
    }
    var deleteImage = UIImageView().then {
        $0.image = .deleteButtonImage
        $0.backgroundColor = .red
        $0.contentMode = .scaleToFill
    }
    var deleteButton = UIButton().then {
        $0.setImage(.deleteButtonImage, for: .normal)
        $0.backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(deleteButton)
        
        imageView.snp.makeConstraints {
            $0.bottom.left.equalToSuperview()
            $0.width.height.equalTo(Constants.getAdjustedHeight(37.0))
        }
        
        deleteButton.snp.makeConstraints {
            $0.right.equalTo(imageView).offset(Constants.getAdjustedWidth(3.0))
            $0.top.equalTo(imageView).inset(-Constants.getAdjustedWidth(3.0))
            $0.width.height.equalTo(Constants.getAdjustedWidth(10.0))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
}
