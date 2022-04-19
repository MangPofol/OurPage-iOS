//
//  BookclubHomeCollectionViewCell.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/28.
//

import UIKit
import RxSwift
import Kingfisher

class BookclubHomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookclubHomeCollectionViewCell"
    
    var titleLabel = UILabel()
    var introduceLabel = UILabel()
    var memberProfileImageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var pageLabel = UILabel()
    var pageBackgroundImage = UIImageView()
    var levelCharacterimageView = UIImageView()
    var newBadgeImageView = UIImageView()
    
    private var pointBackgroundImageView = UIImageView()
    private var backgroundImageView = UIImageView()
    private var containerView = UIView()
    
    private var disposeBag = DisposeBag()
    
    var bookclubMembers: [CreatedUser] = [] {
        didSet {
            self.memberProfileImageCollectionView.reloadData()
        }
    }
    
    var bookclub: Club? {
        didSet {
            guard let bookclub = bookclub else {
                self.bookclubMembers = []
                return
            }
            
            self.titleLabel.text = bookclub.name
            self.introduceLabel.text =  "\"" + bookclub.description + "\""
            
            self.disposeBag = DisposeBag()
            
            BookclubServices.getClubInfoByClub(id: bookclub.id)
                .bind { [weak self] in
                    guard let self = self, let club = $0 else {
                        self?.bookclubMembers = []
                        return
                    }
                    self.levelCharacterimageView.image = UIImage(named: "BookclubLevel\(club.level)")
                    self.pageLabel.text = "\(club.totalPosts)"
                    self.bookclubMembers = club.userResponseDtos
                }
                .disposed(by: disposeBag)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.memberProfileImageCollectionView.dataSource = self
        
        self.contentView.addSubview(containerView)
        containerView.then {
            $0.backgroundColor = .mainColor
            $0.setCornerRadius(radius: 20.adjustedHeight)
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.containerView.addSubview(titleLabel)
        titleLabel.then {
            $0.textColor = .white
            $0.textAlignment = .left
            $0.font = .defaultFont(size: 16.0, boldLevel: .bold)
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(23.0.adjustedHeight)
            $0.left.equalToSuperview().inset(21.0.adjustedHeight)
            $0.right.equalToSuperview().inset(30.0.adjustedHeight)
        }
        
        self.containerView.addSubview(introduceLabel)
        introduceLabel.then {
            $0.textColor = UIColor(hexString: "C3C5D1")
            $0.textAlignment = .left
            $0.font = .defaultFont(size: 12.0, boldLevel: .regular)
            $0.numberOfLines = 2
        }.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3.adjustedHeight)
            $0.left.right.equalTo(titleLabel)
        }
        
        self.containerView.addSubview(backgroundImageView)
        backgroundImageView.then {
            $0.image = UIImage(named: "BackgroundImage")
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(-60.0.adjustedHeight)
            $0.bottom.equalToSuperview().inset(-30.8.adjustedHeight)
            $0.right.equalToSuperview().inset(-29.84.adjustedHeight)
            $0.height.equalTo(135.8.adjustedHeight)
        }
        
        self.containerView.addSubview(newBadgeImageView)
        newBadgeImageView.then {
            $0.image = UIImage(named: "NewBadge")
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.width.height.equalTo(9.0)
            $0.top.equalToSuperview().inset(29.0.adjustedHeight)
            $0.right.equalToSuperview().inset(20.0.adjustedHeight)
        }
        
        self.containerView.addSubview(memberProfileImageCollectionView)
        memberProfileImageCollectionView.then {
            _ = ($0.collectionViewLayout as! UICollectionViewFlowLayout).then {
                $0.itemSize = CGSize(width: 18.0, height: 18.0).resized(basedOn: .height)
                $0.scrollDirection = .horizontal
                $0.minimumInteritemSpacing = 4.0.adjustedHeight
                $0.sectionInset = .zero
            }
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
            $0.register(BookclubHomeMemberProfileCell.self, forCellWithReuseIdentifier: BookclubHomeMemberProfileCell.identifier)
        }.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24.adjustedHeight)
            $0.left.equalToSuperview().inset(21.adjustedHeight)
            $0.width.equalTo(18.0.adjustedHeight * 4.adjustedHeight + 12.0.adjustedHeight)
            $0.height.equalTo(18.1.adjustedHeight)
        }
        
        self.containerView.addSubview(pageBackgroundImage)
        pageBackgroundImage.then {
            $0.image = UIImage(named: "BookclubPageBackground")
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.width.equalTo(56.2.adjustedHeight)
            $0.height.equalTo(16.0.adjustedHeight)
            $0.bottom.equalToSuperview().inset(24.0.adjustedHeight)
            $0.right.equalToSuperview().inset(44.8.adjustedHeight)
        }
        
        self.containerView.addSubview(pageLabel)
        pageLabel.then {
            $0.textColor = .mainColor
            $0.textAlignment = .right
            $0.font = .defaultFont(size: 10.0, boldLevel: .regular)
        }.snp.makeConstraints {
            $0.right.equalTo(pageBackgroundImage).offset(-28.2.adjustedHeight)
            $0.top.bottom.left.equalTo(pageBackgroundImage)
        }
        
        self.containerView.addSubview(levelCharacterimageView)
        levelCharacterimageView.then {
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.left.equalTo(pageBackgroundImage.snp.right).offset(0.8)
            $0.bottom.equalTo(pageBackgroundImage)
            $0.width.height.equalTo(24.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookclubHomeCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.bookclubMembers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookclubHomeMemberProfileCell.identifier, for: indexPath) as! BookclubHomeMemberProfileCell
        
        
        cell.profileImageView.kf.setImage(with: URL(string: self.bookclubMembers[indexPath.item].profileImgLocation ?? ""))
        
        return cell
    }
}

class BookclubHomeMemberProfileCell: UICollectionViewCell {
    static let identifier = "BookclubHomeMemberProfileCell"
    
    var profileImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(profileImageView)
        self.profileImageView.then {
            $0.contentMode = .scaleAspectFit
            $0.setCornerRadius(radius: 9.0.adjustedHeight)
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
