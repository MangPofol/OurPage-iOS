//
//  BookListViewCell.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/13.
//

import UIKit

class BookListViewCell: UICollectionViewCell {
    static let identifier = "BookListViewCell"
    
    var bookImageView = UIImageView().then {
        $0.image = UIImage(named: "SampleBook")!
        $0.contentMode = .scaleAspectFit
    }
    var bookTitleLabel = UILabel().then {
        $0.text = "책 제목"
        $0.textAlignment = .center
        $0.font = UIFont.preferredFont(forTextStyle: .caption1)
        $0.adjustsFontForContentSizeCategory = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(bookImageView)
        self.contentView.addSubview(bookTitleLabel)
        makeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
        bookImageView.snp.makeConstraints {
            $0.top.left.right.equalTo(self.contentView.safeAreaLayoutGuide)
            $0.bottom.equalTo(bookTitleLabel.snp.top)
        }
        bookTitleLabel.snp.makeConstraints {
            $0.left.right.bottom.equalTo(self.contentView.safeAreaLayoutGuide)
        }
    }
}
