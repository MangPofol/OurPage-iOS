//
//  WriteView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/10.
//

import UIKit
import RxSwift

class WriteView: UIView {
    var upperView = UIView().then {
        $0.backgroundColor = .white
        $0.setShadow(opacity: 0.5, color: .lightGray)
    }
    
    var bookSelectionButton = ButtonWithImage(frame: .zero).then {
        $0.backgroundColor = .mainColor
        $0.button.setTitle("기록할 책을 선택해주세요", for: .normal)
        $0.button.setTitleColor(.white, for: .normal)
        $0.button.titleLabel?.font = .defaultFont(size: 12, boldLevel: .bold)
        $0.imageView.image = .rightArrowImage
        $0.imageView.tintColor = .white
        $0.setCornerRadius(radius: 10.adjustedHeight)
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
        $0.font = .defaultFont(size: 14, boldLevel: .bold)
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
    }
    
    var contentTextView = UITextView().then {
        $0.font = .defaultFont(size: .medium)
        $0.textColor = .grayB0
        $0.text = "내용을 입력하세요."
        $0.autocorrectionType = .no
        $0.backgroundColor = .white
        // 공백 없애기
        $0.textContainer.lineFragmentPadding = 0
        $0.textContainerInset = .zero
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(upperView)
        self.addSubview(bookSelectionButton)
        self.addSubview(imageUploadButton)
        self.addSubview(uploadedImageCollection)
        self.addSubview(imageUploadButtonUnderLine)
        self.addSubview(titleTextField)
        self.addSubview(contentTextView)
        makeView()
    }
    
    func makeView() {
        bookSelectionButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.getAdjustedHeight(20.0))
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Constants.getAdjustedHeight(30.0))
            $0.width.equalTo(Constants.getAdjustedWidth(334.0))
        }
        
        upperView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(bookSelectionButton).inset(-22.adjustedHeight)
        }
        
        imageUploadButton.snp.makeConstraints {
            $0.top.equalTo(upperView.snp.bottom).offset(Constants.getAdjustedHeight(25.0))
            $0.width.height.equalTo(Constants.getAdjustedHeight(37.0))
            $0.left.equalTo(bookSelectionButton)
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
            $0.width.equalTo(bookSelectionButton)
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
