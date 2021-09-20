//
//  BookListViewCell.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/13.
//

import UIKit
import RxSwift

class BookListViewCell: UICollectionViewCell {
    static let identifier = "BookListViewCell"
    var disposeBag = DisposeBag()
    
    var bookModel = BehaviorSubject<BookModel?>(value: nil)
    var thumbnailString = BehaviorSubject<String?>(value: nil)
    var searchedInfo = BehaviorSubject<SearchedBook?>(value: nil)
    
    var bookImageView = UIImageView().then {
        $0.image = UIImage(named: "SampleBook")!
        $0.contentMode = .scaleAspectFit
        $0.setCornerRadius(radius: CGFloat(Constants.getAdjustedWidth(10.0)))
    }
    var bookTitleLabel = UILabel().then {
        $0.text = "책 제목"
        $0.textAlignment = .center
        $0.font = .defaultFont(size: .small)
        $0.adjustsFontForContentSizeCategory = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(bookImageView)
        self.contentView.addSubview(bookTitleLabel)
        makeView()
        
        bindOutputs()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
        bookImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(Constants.getAdjustedWidth(93.0))
            $0.height.equalTo(Constants.getAdjustedHeight(132.0))
        }
        bookTitleLabel.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(Constants.getAdjustedHeight(8.0))
            $0.left.right.equalToSuperview()
        }
    }
    
    private func bindOutputs() {
        bookModel.observeOn(MainScheduler.instance)
            .filter { $0 != nil}
            .bind { book in
                // DB 먼저 검사
                self.bookTitleLabel.text = book!.name
            }
            .disposed(by: disposeBag)
        
        searchedInfo.observeOn(MainScheduler.asyncInstance)
            .filter { $0 != nil }
            .bind {
                self.bookImageView.kf.setImage(with: URL(string: $0!.thumbnail))
            }
            .disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        bindOutputs()
    }
}
