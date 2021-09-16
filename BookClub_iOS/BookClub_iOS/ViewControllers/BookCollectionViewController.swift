//
//  BookCollectionViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/26.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class BookCollectionViewController: UICollectionViewController {

    let disposeBag = DisposeBag()
    var viewModel: BookCollectionViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = nil
        self.collectionView.dataSource = nil
        
        self.collectionView.backgroundColor = .white
        self.collectionView.register(BookListViewCell.self, forCellWithReuseIdentifier: BookListViewCell.identifier)
        self.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel = BookCollectionViewModel(bookTapped: self.collectionView.rx.modelSelected(BookModel.self).map { $0 })
        
        // bind outputs
        viewModel!.bookModel
            .observeOn(MainScheduler.asyncInstance)
            .bind(to:
                    self.collectionView
                    .rx
                    .items(cellIdentifier: BookListViewCell.identifier, cellType: BookListViewCell.self)) { (row, element, cell) in
                
                SearchServices.getThumbnailBy(isbn: element.isbn).bind {
                    cell.thumbnailString.onNext($0)
                }.disposed(by: cell.disposeBag)
                    
                
                cell.bookModel.onNext(element)
            }.disposed(by: disposeBag)
    }
}

extension BookCollectionViewController: UICollectionViewDelegateFlowLayout {
    // 한 가로줄에 cell이 3개만 들어가도록 크기 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.bookListCellSize()
    }
}

