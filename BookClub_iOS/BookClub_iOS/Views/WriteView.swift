//
//  WriteView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/10.
//

import UIKit

class WriteView: UIView {
    var bookTextField = UITextField().then {
        $0.placeholder = "책을 정해주세요"
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        $0.adjustsFontForContentSizeCategory = true
    }
    
    var lineView = UIView(frame: CGRect(x: 0, y: 100, width: 320, height: 1.0)).then {
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    // Buttons and date
    var memoButton = UIButton().then {
        $0.setTitle("⋅ MEMO", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        $0.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    var topicButton = UIButton().then {
        $0.setTitle("⋅ TOPIC", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        $0.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    var dateLabel = UILabel().then {
        $0.text = Date().toString()
        $0.font = UIFont.preferredFont(forTextStyle: .footnote)
        $0.adjustsFontForContentSizeCategory = true
    }
    //
    
    lazy var containerView = UIView().then {
        $0.backgroundColor = .clear
        $0.addSubview(memoButton)
        $0.addSubview(topicButton)
        $0.addSubview(dateLabel)
    }
    
    var titleTextField = UITextField().then {
        $0.placeholder = "제목을 작성해보세요"
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        $0.adjustsFontForContentSizeCategory = true
    }
    
    var lineView2 = UIView(frame: CGRect(x: 0, y: 100, width: 320, height: 1.0)).then {
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    var contentTextView = UITextView().then {
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        $0.adjustsFontForContentSizeCategory = true
        $0.text = "내용을 입력 해 주세요."
        $0.textColor = .lightGray
        $0.textContainerInset = UIEdgeInsets(top: 5.0, left: 0, bottom: 0, right: 0)
        $0.textContainer.lineFragmentPadding = 0.0
    }
    
    // Underbar buttons
    var addButton = UIButton().then {
        $0.setTitle("+", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        $0.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    var saveButton = UIButton().then {
        $0.setTitle("저장하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        $0.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    var verticalLine = UIView().then {
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.black.cgColor
    }
    var storageButton = UIButton().then {
        $0.setTitle("2", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        $0.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    lazy var underbarContainer = UIView().then {
        $0.backgroundColor = .clear
        $0.addSubview(addButton)
        $0.addSubview(saveButton)
        $0.addSubview(verticalLine)
        $0.addSubview(storageButton)
    }
    //
        
    lazy var stackView = UIStackView(
        arrangedSubviews: [bookTextField, lineView, containerView, titleTextField, lineView2, contentTextView]
    ).then {
        $0.axis = .vertical
        $0.spacing = 3
        $0.distribution = .fill
        $0.backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(stackView)
        self.addSubview(underbarContainer)
    }
    
    public func makeView() {
        lineView.snp.makeConstraints {
            $0.height.equalTo(1.0)
        }
        lineView2.snp.makeConstraints {
            $0.height.equalTo(1.0)
        }
        memoButton.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
        }
        topicButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(memoButton.snp.right).offset(10)
        }
        dateLabel.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.left.right.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(underbarContainer.snp.top)
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(50)
        }
        underbarContainer.snp.makeConstraints {
            $0.left.right.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(30)
        }
        addButton.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
        }
        storageButton.snp.makeConstraints {
            $0.right.top.bottom.equalToSuperview()
        }
        verticalLine.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.right.equalTo(storageButton.snp.left).offset(-15)
            $0.width.equalTo(1.0)
        }
        saveButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.right.equalTo(verticalLine.snp.left).offset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
