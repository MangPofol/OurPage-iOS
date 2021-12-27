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
    var searchedInfo = BehaviorSubject<SearchedBook?>(value: nil)
    
    var bookImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = .BookLoadingImage
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
    
//    if element.searchedInfo == nil {
//        SearchServices.searchBookBy(isbn: element.bookModel.isbn).bind {
//            cell.searchedInfo.onNext($0.first)
//        }.disposed(by: cell.disposeBag)
//    } else {
//        cell.searchedInfo.onNext(element.searchedInfo)
//    }
    
    private func bindOutputs() {
        bookModel.observe(on: MainScheduler.instance)
            .compactMap { $0 }
            .do { [weak self] book in
                self?.bookTitleLabel.text = book.name
            }
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { book -> Observable<SearchedBook?> in
                return SearchServices.searchBookBy(isbn: book.isbn).map { $0.first }
            }
            .bind { [weak self] in
                self?.searchedInfo.onNext($0)
            }
            .disposed(by: disposeBag)
        
        searchedInfo
            .observe(on: MainScheduler.instance)
            .do { [weak self] val in
                if val == nil {
                    self?.bookImageView.image = .BookLoadingImage
                }
            }
            .compactMap { $0 }
            .bind { [weak self] in
                self?.bookImageView.kf.setImage(with: URL(string: $0.thumbnail), placeholder: UIImage.BookLoadingImage)
            }
            .disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        bookImageView.image = .BookLoadingImage
        bindOutputs()
    }
}
