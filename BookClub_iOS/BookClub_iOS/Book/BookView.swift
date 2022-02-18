//
//  BookView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/27.
//

import UIKit
import RxSwift

final class BookView: UIView {
    var backgroundImageView = UIImageView(image: UIImage(named: "BackgroundImageLight")).then {
        $0.contentMode = .scaleAspectFill
    }
    
    var bookImageView = UIImageView(image: .DefaultBookImage).then {
        $0.contentMode = .scaleAspectFit
        $0.setCornerRadius(radius: 10.adjustedHeight)
    }
    
    var bookTitleLabel = UILabel()
    
    var lineView = UIView()
    var readingButton = BookActionButton(iconImage: UIImage(named: "ReadingIcon"), title: "읽는중")
    var dotLine1 = UIImageView()
    var finishButton = BookActionButton(iconImage: UIImage(named: "FinishIcon"), title: "완독")
    var dotLine2 = UIImageView()
    var deleteButton = BookActionButton(iconImage: UIImage(named: "DeleteIcon"), title: "책 삭제")
    var writeButton = BookActionButton(iconImage: UIImage(named: "WriteViewIcon"), title: "기록 쓰러가기")
    
    var memoTitleLabel = UILabel().then {
        $0.text = "MEMO LIST"
        $0.font = .defaultFont(size: 14, boldLevel: .semiBold)
        $0.textColor = .mainColor
    }
    
    var memoTableView = UITableView().then {
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.separatorStyle = .none
        $0.register(MemoTableViewCell.self, forCellReuseIdentifier: MemoTableViewCell.identifier)
        $0.rowHeight = 85.adjustedHeight
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
        self.addSubview(bookTitleLabel)
        self.addSubview(lineView)
        
        self.addSubview(readingButton)
        self.addSubview(dotLine1)
        self.addSubview(finishButton)
        self.addSubview(dotLine2)
        self.addSubview(deleteButton)
        self.addSubview(writeButton)
        
        self.addSubview(memoContainerView)
        
        makeView()
    }
    
    private func makeView() {
        backgroundImageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(-32.adjustedHeight)
            $0.right.equalToSuperview().offset(7.adjustedHeight)
            $0.top.equalTo(bookImageView).inset(-11.adjustedHeight)
            $0.height.equalTo(178.39.adjustedHeight)
        }
        
        bookImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(35.adjustedHeight)
            $0.width.equalTo(93.adjustedHeight)
            $0.height.equalTo(132.adjustedHeight)
        }
        
        bookTitleLabel.then {
            $0.font = .defaultFont(size: 18, boldLevel: .extraBold)
            $0.textColor = .mainColor
            $0.textAlignment = .center
        }.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(19.adjustedHeight)
            $0.left.right.equalToSuperview().inset(49.adjustedHeight)
        }
        
        lineView.then {
            $0.backgroundColor = UIColor(hexString: "EFF0F3")
        }.snp.makeConstraints {
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(23.66.adjustedHeight)
            $0.height.equalTo(1.05)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
        }
        
        readingButton.snp.makeConstraints {
            $0.width.equalTo(74.33.adjustedHeight)
            $0.height.equalTo(45.02.adjustedHeight)
            $0.top.equalTo(lineView.snp.bottom).offset(12.56.adjustedHeight)
            $0.left.equalTo(lineView)
        }
        readingButton.iconImageView.snp.updateConstraints {
            $0.width.equalTo(14.66.adjustedHeight)
            $0.height.equalTo(8.38.adjustedHeight)
            $0.top.equalToSuperview().inset(5.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        dotLine1.then {
            $0.image = UIImage(named: "DotLine")?.withRenderingMode(.alwaysTemplate)
            $0.contentMode = .scaleAspectFill
            $0.tintColor = UIColor(hexString: "EFF0F3")
        }.snp.makeConstraints {
            $0.width.equalTo(0.52)
            $0.left.equalTo(readingButton.snp.right).offset(3.14.adjustedHeight)
            $0.height.equalTo(43.97.adjustedHeight)
            $0.top.equalTo(lineView.snp.bottom).inset(15.7.adjustedHeight)
        }
        
        finishButton.snp.makeConstraints {
            $0.width.equalTo(74.33.adjustedHeight)
            $0.height.equalTo(45.02.adjustedHeight)
            $0.top.equalTo(lineView.snp.bottom).offset(12.56.adjustedHeight)
            $0.left.equalTo(dotLine1.snp.right).offset(3.14.adjustedHeight)
        }
        finishButton.iconImageView.snp.updateConstraints {
            $0.width.equalTo(10.48.adjustedHeight)
            $0.height.equalTo(10.48.adjustedHeight)
            $0.top.equalToSuperview().inset(5.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        dotLine2.then {
            $0.image = UIImage(named: "DotLine")?.withRenderingMode(.alwaysTemplate)
            $0.contentMode = .scaleAspectFill
            $0.tintColor = UIColor(hexString: "EFF0F3")
        }.snp.makeConstraints {
            $0.width.equalTo(0.52)
            $0.left.equalTo(finishButton.snp.right).offset(3.14.adjustedHeight)
            $0.height.equalTo(43.97.adjustedHeight)
            $0.top.equalTo(lineView.snp.bottom).inset(15.7.adjustedHeight)
        }
        
        deleteButton.then {
            $0.defaultColor = .mainPink
            $0.isOn = true
        }.snp.makeConstraints {
            $0.width.equalTo(74.33.adjustedHeight)
            $0.height.equalTo(45.02.adjustedHeight)
            $0.top.equalTo(lineView.snp.bottom).offset(12.56.adjustedHeight)
            $0.left.equalTo(dotLine2.snp.right).offset(3.14.adjustedHeight)
        }
        deleteButton.iconImageView.snp.updateConstraints {
            $0.width.equalTo(11.66.adjustedHeight)
            $0.height.equalTo(12.58.adjustedHeight)
            $0.top.equalToSuperview().inset(5.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        writeButton.then {
            $0.backgroundColor = .mainPink
            $0.setCornerRadius(radius: 8.38.adjustedHeight)
            $0.defaultColor = .white
            $0.isOn = true
        }.snp.makeConstraints {
            $0.height.equalTo(45.02.adjustedHeight)
            $0.top.equalTo(lineView.snp.bottom).offset(12.56.adjustedHeight)
            $0.left.equalTo(deleteButton.snp.right).offset(9.42.adjustedHeight)
            $0.right.equalToSuperview().inset(20.adjustedHeight)
        }
        writeButton.iconImageView.snp.updateConstraints {
            $0.width.equalTo(13.95.adjustedHeight)
            $0.height.equalTo(13.74.adjustedHeight)
            $0.top.equalToSuperview().inset(5.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        memoContainerView.snp.makeConstraints { [unowned self] in
            $0.top.equalTo(deleteButton.snp.bottom).offset(12.76.adjustedHeight)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
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
    
    var titleLabel = UILabel().then {
        $0.font = .defaultFont(size: 14, boldLevel: .medium)
        $0.textColor = .mainColor
        $0.textAlignment = .left
    }
    
    var lineView = UIView()
    var contentLabel = UILabel()
    
    var createdDateLabel = UILabel().then {
        $0.font = .defaultFont(size: 10, boldLevel: .light)
        $0.textColor = UIColor(hexString: "C3C5D1")
        $0.textAlignment = .right
    }
    
    var innerView = UIView()
    
    var post: PostModel? {
        didSet {
            guard let post = post else { return }
            titleLabel.text = post.title
            contentLabel.text = post.content
            createdDateLabel.text = post.createdDate.toString()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor(hexString: "EFF0F3")
        self.contentView.addSubview(innerView)
        
        makeView()
    }
    
    private func makeView() {
        innerView.then {
            $0.backgroundColor = .white
            $0.addSubview(titleLabel)
            $0.addSubview(lineView)
            $0.addSubview(contentLabel)
            $0.addSubview(createdDateLabel)
            $0.setCornerRadius(radius: 15.adjustedHeight)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(15.adjustedHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12.adjustedHeight)
            $0.left.right.equalToSuperview().inset(18.adjustedHeight)
        }
        
        lineView.then {
            $0.backgroundColor = UIColor(hexString: "C3C5D1")
            $0.snp.contentHuggingVerticalPriority = .infinity
        }.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(9.adjustedHeight)
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview().inset(16.adjustedHeight)
        }
        
        contentLabel.then {
            $0.font = .defaultFont(size: 10, boldLevel: .light)
            $0.textColor = UIColor(hexString: "646A88")
        }.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(8.adjustedHeight)
            $0.left.equalToSuperview().inset(17.adjustedHeight)
            $0.right.equalTo(createdDateLabel.snp.left).offset(12.adjustedHeight)
            $0.bottom.equalToSuperview().inset(12.adjustedHeight)
        }
        
        createdDateLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel)
            $0.right.equalToSuperview().inset(18.adjustedHeight)
            $0.bottom.equalToSuperview().inset(12.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
