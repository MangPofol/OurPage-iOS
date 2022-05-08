//
//  CommentCell.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/05/08.
//

import UIKit

final class CommentCell: UICollectionViewCell {
    static let identifier = "CommentCell"
    
    var profileImageView = UIImageView()
    var userNicknameLabel = UILabel()
    var dateLabel = UILabel()
    var commentLabel = UILabel()
    
    private var containerStackView = UIStackView()
    var replyButton = CMButton()
    var deleteButton = CMButton()
    
    var bottomLine = UIView()
    
    var comment: Comment? {
        didSet {
            guard let comment = self.comment else {
                return
            }

//            self.profileImageView.kf.setImage(with: URL(string: comment.))
            self.userNicknameLabel.text = comment.userNickname
            self.commentLabel.text = comment.content
            self.dateLabel.text = comment.createdDate
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = UIColor(hexString: "EFF0F3")
        self.contentView.addSubview(bottomLine)
        self.bottomLine.then {
            $0.backgroundColor = UIColor(hexString: "C3C5D1")
        }.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        self.contentView.addSubview(profileImageView)
        self.profileImageView.then {
            $0.setCornerRadius(radius: 15.0.adjustedHeight)
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .mainPink
//            $0.image = UIImage(named: "DefaultProfileImage")
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(7.0.adjustedHeight)
            $0.top.equalToSuperview().inset(21.0.adjustedHeight)
            $0.width.height.equalTo(30.0.adjustedHeight)
        }
        
        self.contentView.addSubview(userNicknameLabel)
        self.userNicknameLabel.then {
            $0.font = .defaultFont(size: 14.0, boldLevel: .bold)
            $0.textColor = .mainColor
            $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
        }.snp.makeConstraints {
            $0.top.equalTo(self.profileImageView)
            $0.left.equalTo(self.profileImageView.snp.right).offset(11.0.adjustedHeight)
        }
        
        self.contentView.addSubview(dateLabel)
        self.dateLabel.then {
            $0.font = .defaultFont(size: 11.0, boldLevel: .regular)
            $0.textColor = UIColor(hexString: "C3C5D1")
            $0.textAlignment = .right
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        }.snp.makeConstraints {
            $0.centerY.equalTo(self.userNicknameLabel)
            $0.left.equalTo(self.userNicknameLabel.snp.right).offset(6.0.adjustedHeight)
            $0.right.equalToSuperview().inset(10.0.adjustedHeight)
        }
        
        self.contentView.addSubview(commentLabel)
        self.commentLabel.then {
            $0.font = .defaultFont(size: 13.0, boldLevel: .regular)
            $0.textColor = .mainColor
            $0.numberOfLines = 2
        }.snp.makeConstraints {
            $0.left.equalTo(self.userNicknameLabel)
            $0.top.equalTo(self.userNicknameLabel.snp.bottom).offset(5.5.adjustedHeight)
            $0.right.equalToSuperview().inset(21.0.adjustedHeight)
        }
        
        self.contentView.addSubview(containerStackView)
        self.containerStackView.then {
            $0.backgroundColor = UIColor(hexString: "EFF0F3")
            $0.axis = .horizontal
            $0.spacing = 15.0
        }.snp.makeConstraints {
            $0.height.equalTo(12.0.adjustedHeight)
            $0.left.equalTo(self.commentLabel)
            $0.top.equalTo(self.commentLabel.snp.bottom).offset(6.0.adjustedHeight)
            $0.bottom.equalToSuperview().inset(14.0.adjustedHeight)
        }
        
        self.containerStackView.addArrangedSubview(replyButton)
        _ = self.replyButton.then {
            $0.setTitle("답글달기", for: .normal)
            $0.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
            $0.titleLabel?.font = .defaultFont(size: 11.0, boldLevel: .regular)
        }
        
        let lineView = UIView()
        self.containerStackView.addArrangedSubview(lineView)
        lineView.then {
            $0.backgroundColor = UIColor(hexString: "C3C5D1")
        }.snp.makeConstraints {
            $0.width.equalTo(1.0)
        }
        
        self.containerStackView.addArrangedSubview(deleteButton)
        _ = self.deleteButton.then {
            $0.setTitle("삭제하기", for: .normal)
            $0.setTitleColor(.mainPink, for: .normal)
            $0.titleLabel?.font = .defaultFont(size: 11.0, boldLevel: .regular)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
