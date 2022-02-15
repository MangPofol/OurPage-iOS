//
//  BookView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/27.
//

import UIKit
import RxSwift

final class BookView: UIView {
    var backgroundImageView = UIImageView(image: .BackgroundLogoImage).then {
        $0.contentMode = .scaleAspectFill
    }
    
    var bookImageView = UIImageView(image: .DefaultBookImage).then {
        $0.contentMode = .scaleAspectFit
        $0.setCornerRadius(radius: 10.adjustedHeight)
    }
    
    var endButton = BookEndButton().then {
        $0.setCornerRadius(radius: 10.adjustedHeight)
    }
    
    var memoTitleLabel = UILabel().then {
        $0.text = "MEMO LIST"
        $0.font = .defaultFont(size: 14, boldLevel: .semiBold)
        $0.textColor = .mainColor
    }
    
    var memoTableView = UITableView().then {
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.separatorStyle = .none
        $0.register(MemoTableViewCell.self, forCellReuseIdentifier: MemoTableViewCell.identifier)
        $0.rowHeight = 40.adjustedHeight
    }
    
    lazy var memoContainerView = UIView().then {
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.setCornerRadius(radius: 8.adjustedHeight)
        $0.addSubview(memoTitleLabel)
        $0.addSubview(memoTableView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(backgroundImageView)
        self.addSubview(bookImageView)
        self.addSubview(endButton)
        self.addSubview(memoContainerView)
        
        makeView()
    }
    
    private func makeView() {
        backgroundImageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(-32.adjustedWidth)
            $0.right.equalToSuperview().offset(7.adjustedWidth)
            $0.top.equalToSuperview().inset(56.61.adjustedHeight)
            $0.height.equalTo(178.39.adjustedHeight)
        }
        
        bookImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(52.adjustedHeight)
            $0.width.equalTo(148.adjustedHeight)
            $0.height.equalTo(217.adjustedHeight)
        }
        
        endButton.snp.makeConstraints {
            $0.bottom.equalTo(bookImageView)
            $0.left.equalTo(bookImageView.snp.right).offset(22.adjustedWidth)
            $0.width.equalTo(71.adjustedWidth)
            $0.height.equalTo(25.adjustedHeight)
        }
        
        memoContainerView.snp.makeConstraints { [unowned self] in
            $0.top.equalTo(bookImageView.snp.bottom).offset(54.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedWidth)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(34.adjustedHeight)
        }
        
        memoTitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(25.3.adjustedWidth)
            $0.top.equalToSuperview().inset(19.adjustedHeight)
        }
        
        memoTableView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.adjustedWidth)
            $0.top.equalTo(memoTitleLabel.snp.bottom).offset(9.adjustedHeight)
            $0.bottom.equalToSuperview().inset(21.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class BookEndButton: UIButton {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = .mainColor
            } else {
                self.backgroundColor = UIColor(hexString: "C3C5D1")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSelected = false
        self.semanticContentAttribute = .forceLeftToRight
        self.tintColor = .white
        self.setImage(.PlainCheckBoxIcon.resize(to: CGSize(width: 10.45.adjustedHeight, height: 10.45.adjustedHeight)), for: .normal)
        self.setImage(.CheckedCheckBoxIcon.resize(to: CGSize(width: 10.45.adjustedHeight, height: 10.45.adjustedHeight)), for: .selected)
        self.titleLabel?.font = .defaultFont(size: 11.89, boldLevel: .semiBold)
        self.setTitle("END", for: .normal)
        self.setTitle("END", for: .selected)
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.white, for: .selected)
        self.imageView?.contentMode = .scaleAspectFit
        self.imageEdgeInsets = UIEdgeInsets(top: 7.adjustedHeight, left: 0, bottom: 7.55.adjustedHeight, right: 8.55.adjustedWidth)
//        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 17.adjustedWidth)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class MemoTableViewCell: UITableViewCell {
    static let identifier = "MemoTableViewCell"
    
    var post = BehaviorSubject<PostModel?>(value: nil)
    var disposeBag = DisposeBag()
    
    var iconImageView = UIImageView(image: .MemoIcon).then {
        $0.contentMode = .scaleAspectFit
    }
    
    var titleLabel = UILabel().then {
        $0.font = .defaultFont(size: 12, boldLevel: .light)
        $0.textColor = .mainColor
    }
    
    var createdDateLabel = UILabel().then {
        $0.font = .defaultFont(size: 10, boldLevel: .regular)
        $0.textColor = UIColor(hexString: "C3C5D1")
    }
    
    lazy var innerView = UIView().then {
        $0.backgroundColor = .white
        $0.addSubview(iconImageView)
        $0.addSubview(titleLabel)
        $0.addSubview(createdDateLabel)
        $0.setCornerRadius(radius: 15.adjustedHeight)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor(hexString: "EFF0F3")
        self.contentView.addSubview(innerView)
        
        makeView()
    }
    
    private func makeView() {
        innerView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview()
//            $0.height.equalTo(30.adjustedHeight)
            $0.bottom.equalToSuperview().inset(10.adjustedHeight)
        }
        iconImageView.snp.makeConstraints {
            $0.width.equalTo(9.7.adjustedHeight)
            $0.height.equalTo(11.41.adjustedHeight)
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(14.15.adjustedWidth)
        }
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(iconImageView.snp.right).offset(12.15.adjustedWidth)
        }
        createdDateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(18.adjustedWidth)
        }
    }
    
    func bindOutputs() {
        disposeBag = DisposeBag()
        post
            .compactMap { $0 }
            .withUnretained(self)
            .bind { (owner, post) in
                owner.titleLabel.text = post.title
                owner.createdDateLabel.text = post.createdDate.toDate().toString()
            }
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
