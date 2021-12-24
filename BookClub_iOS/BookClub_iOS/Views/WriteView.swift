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
        $0.setImage(.cameraIcon.resize(to: CGSize(width: 17.17, height: 15.29).resized(basedOn: .height)), for: .normal)
        $0.imageView?.tintColor = .pink_E5949D
        $0.alignTextBelow(spacing: 0.0)
    }
    
    let uploadedImageCollectionFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 12.adjustedHeight
        $0.minimumInteritemSpacing = 12.adjustedHeight
    }
    
    lazy var uploadedImageCollection = UICollectionView(frame: .zero, collectionViewLayout: uploadedImageCollectionFlowLayout).then {
        $0.backgroundColor = .white
        
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
            $0.height.equalTo(Constants.getAdjustedHeight(41.0))
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
    
    var vcViewModel: WriteViewModel!
    var index: Int!
    
    var imageUrlString: String? = nil {
        didSet {
            if let str = imageUrlString {
                imageView.kf.setImage(with: URL(string: str))
            }
        }
    }
    
    var imageView = UIImageView().then {
        $0.setCornerRadius(radius: CGFloat(Constants.getAdjustedHeight(8.0)))
        $0.kf.indicatorType = .activity
    }
    
    var deleteButton = UIButton().then {
        $0.setImage(.deleteButtonImage, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
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
            $0.right.equalTo(imageView).offset(3.adjustedHeight)
            $0.top.equalTo(imageView).inset(-3.adjustedHeight)
            $0.width.height.equalTo(Constants.getAdjustedHeight(10.0))
        }
        
        deleteButton.rx.tap
            .bind { [weak self] in
                self?.vcViewModel.deleteImageAt.onNext(self?.index)
            }
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
        deleteButton.rx.tap
            .bind { [weak self] in
                self?.vcViewModel.deleteImageAt.onNext(self?.index)
            }
            .disposed(by: disposeBag)
    }
}
