//
//  BookclubDetailView.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/04/06.
//

import UIKit

final class BookclubDetailView: UIView {
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var membersLabel = UILabel()
    var headerArrowImageView = UIImageView()
    var headerButton = UIButton()
    var levelLabel = UILabel()
    var pagesLabel = UILabel()
    private var levelBackgroundImageView = UIImageView()
    private var headerView = UIView()
    var levelCharacterImageView = UIImageView()
    
    private var containerStackView = UIStackView()
    var bookclubBooksView = BookclubBooksView()
    var bookclubWelcomeView = BookclubWelcomeView()
    var bookclubTrendingMemoView = BookclubTrendingMemoView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(headerView)
        self.headerView.then {
            $0.backgroundColor = .mainColor
        }.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(152.adjustedHeight)
        }
        
        self.headerView.addSubview(titleLabel)
        self.titleLabel.then {
            $0.font = .defaultFont(size: 26.0, boldLevel: .bold)
            $0.textColor = .white
            $0.text = "Bookclub Text"
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(33.0)
            $0.right.equalToSuperview()
            $0.left.equalToSuperview().inset(24.0.adjustedHeight)
        }
        
        self.headerView.addSubview(descriptionLabel)
        self.descriptionLabel.then {
            $0.font = .defaultFont(size: 14.0, boldLevel: .regular)
            $0.textColor = UIColor(hexString: "C3C5D1")
            $0.text = "desription"
        }.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(1.0)
            $0.left.equalToSuperview().inset(24.0.adjustedHeight)
        }
        
        self.headerView.addSubview(membersLabel)
        self.membersLabel.then {
            $0.font = .defaultFont(size: 10.0, boldLevel: .medium)
            $0.textColor = .mainColor
            $0.backgroundColor = .white
            $0.text = "total 1 members"
            $0.setCornerRadius(radius: 10.adjustedHeight)
            $0.textAlignment = .center
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(24.0.adjustedHeight)
            $0.width.equalTo(117.adjustedHeight)
            $0.height.equalTo(20.adjustedHeight)
            $0.bottom.equalToSuperview().inset(27.79.adjustedHeight)
        }
        
        self.headerView.addSubview(headerArrowImageView)
        self.headerArrowImageView.then {
            $0.image = .rightArrowImage
            $0.tintColor = .white
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.right.equalToSuperview().inset(40.52.adjustedHeight)
            $0.bottom.equalToSuperview().inset(82.49.adjustedHeight)
            $0.width.equalTo(5.48.adjustedHeight)
            $0.height.equalTo(9.51.adjustedHeight)
        }
        
        self.headerView.addSubview(headerButton)
        self.headerButton.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.left.top.equalTo(titleLabel)
            $0.bottom.equalTo(membersLabel)
            $0.right.equalTo(headerArrowImageView)
        }
        
        self.headerView.addSubview(levelBackgroundImageView)
        self.levelBackgroundImageView.then {
            $0.image = UIImage(named: "BookclubDetailLevelBackground")
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.centerY.equalTo(membersLabel)
            $0.left.equalTo(membersLabel.snp.right).offset(6.0.adjustedHeight)
            $0.width.equalTo(123.adjustedHeight)
            $0.height.equalTo(20.adjustedHeight)
        }
        
        self.headerView.addSubview(levelLabel)
        self.levelLabel.then {
            $0.font = .defaultFont(size: 10.0, boldLevel: .bold)
            $0.textColor = .mainColor
        }.snp.makeConstraints {
            $0.centerY.equalTo(levelBackgroundImageView)
            $0.left.equalTo(levelBackgroundImageView).offset(13.0.adjustedHeight)
        }
        
        self.headerView.addSubview(levelCharacterImageView)
        self.levelCharacterImageView.then {
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.width.height.equalTo(24.adjustedHeight)
            $0.left.equalTo(levelBackgroundImageView.snp.right).offset(4.0)
            $0.bottom.equalTo(levelBackgroundImageView)
        }
        
        self.headerView.addSubview(pagesLabel)
        self.pagesLabel.then {
            $0.font = .defaultFont(size: 10.0, boldLevel: .medium)
            $0.textColor = .mainColor
        }.snp.makeConstraints {
            $0.centerY.equalTo(levelBackgroundImageView)
            $0.right.equalTo(levelBackgroundImageView).offset(-16.0.adjustedHeight)
        }
        
        self.addSubview(containerStackView)
        self.containerStackView.then {
            $0.axis = .vertical
            $0.spacing = 19.0.adjustedHeight
        }.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(20.0.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.0.adjustedHeight)
            $0.bottom.equalToSuperview().inset(30.0.adjustedHeight)
        }
        
        self.containerStackView.addArrangedSubview(bookclubWelcomeView)
        self.bookclubWelcomeView.snp.makeConstraints {
            $0.height.equalTo(173.adjustedHeight)
        }
        
        self.containerStackView.addArrangedSubview(bookclubBooksView)
        self.bookclubBooksView.snp.makeConstraints {
            $0.height.equalTo(173.adjustedHeight)
        }
        
        self.containerStackView.addArrangedSubview(bookclubTrendingMemoView)
        self.bookclubTrendingMemoView.snp.makeConstraints {
            $0.height.equalTo(316.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class BookclubWelcomeView: UIView {
    private var titleLabel = UILabel()
    private var imageView = UIImageView()
    var inviteButton = CMButton()
    private var descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .mainColor
        self.setCornerRadius(radius: 10.0.adjustedHeight)
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        titleLabel.then {
            $0.font = .defaultFont(size: 16.73, boldLevel: .semiBold)
            $0.textColor = .white
            $0.text = "CONGRATULATION"
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(16.5.adjustedHeight)
        }
        
        imageView.then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "BookclubWelcomeImage")
        }.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.centerY)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(169.adjustedHeight)
            $0.height.equalTo(82.adjustedHeight)
        }
        
        self.addSubview(inviteButton)
        inviteButton.then {
            $0.defaultBackgroundColor = .mainPink
            $0.setCornerRadius(radius: 8.adjustedHeight)
            $0.setTitle("클럽원 초대하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .defaultFont(size: 12.0, boldLevel: .semiBold)
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(7.0.adjustedHeight)
            $0.width.equalTo(181.adjustedHeight)
            $0.height.equalTo(24.adjustedHeight)
        }
        
        self.addSubview(descriptionLabel)
        descriptionLabel.then {
            $0.font = .defaultFont(size: 10.0, boldLevel: .regular)
            $0.textColor = .white
            $0.text = "새로운 클럽원을 지금 바로 초대해 보세요."
        }.snp.makeConstraints {
            $0.top.equalTo(inviteButton.snp.bottom).offset(3.0.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
