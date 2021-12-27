//
//  PostView.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/28.
//

import UIKit

final class PostView: UIView {
    var bookTitleLabel = UILabel().then {
        $0.font = .defaultFont(size: 14, boldLevel: .bold)
        $0.textColor = .mainColor
    }
    
    private var titleUnderLineView = UIView().then {
        $0.backgroundColor = .mainColor
    }
    
    lazy var upperView = UIView().then {
        $0.backgroundColor = .white
        $0.addSubview(bookTitleLabel)
        $0.addSubview(titleUnderLineView)
        $0.setShadow(opacity: 0.5, color: .lightGray)
    }
    
    var postTitleLabel = UILabel().then {
        $0.font = .defaultFont(size: 16, boldLevel: .bold)
        $0.textColor = .mainColor
    }
    
    var postContentTextView = UITextView().then {
        $0.isUserInteractionEnabled = false
        $0.backgroundColor = .white
        $0.font = .defaultFont(size: 14, boldLevel: .light)
        $0.textColor = UIColor(hexString: "646A88")
        $0.isScrollEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.addSubview(upperView)
        self.addSubview(postTitleLabel)
        self.addSubview(postContentTextView)
        
        makeView()
    }
    
    private func makeView() {
        upperView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(63.adjustedHeight)
        }
        titleUnderLineView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.adjustedWidth)
            $0.height.equalTo(2)
            $0.bottom.equalToSuperview().inset(22.adjustedHeight)
        }
        bookTitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(30.adjustedWidth)
            $0.bottom.equalTo(titleUnderLineView.snp.top).offset(-5.5.adjustedHeight)
        }
        postTitleLabel.snp.makeConstraints {
            $0.top.equalTo(upperView.snp.bottom).offset(17.adjustedHeight)
            $0.left.equalToSuperview().inset(24.adjustedWidth)
        }
        
        postContentTextView.snp.makeConstraints {
            $0.top.equalTo(postTitleLabel.snp.bottom).offset(24.5.adjustedHeight)
            $0.left.right.equalToSuperview().inset(24.adjustedWidth)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
