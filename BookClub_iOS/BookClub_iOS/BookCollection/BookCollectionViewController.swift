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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let viewModel = viewModel {
            viewModel.reloadBooks()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = nil
        self.collectionView.dataSource = nil
        
        self.collectionView.backgroundColor = .white
        self.collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        self.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel = BookCollectionViewModel(bookTapped: self.collectionView.rx.modelSelected(Book.self).map { $0 })
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: CGFloat(Constants.getAdjustedHeight(15.0)), right: 0)
        
        // bind outputs
        viewModel!.books
            .observe(on: MainScheduler.instance)
            .bind(to:
                    collectionView.rx
                    .items(cellIdentifier: BookCollectionViewCell.identifier, cellType: BookCollectionViewCell.self)) { (row, element, cell) in
//                cell.bookModel.onNext(element.bookModel)
                cell.bookModel = BehaviorSubject<BookModel?>(value: element.bookModel)
                cell.bindOutputs()
            }.disposed(by: disposeBag)
    }
}

extension BookCollectionViewController: UICollectionViewDelegateFlowLayout {
    // 한 가로줄에 cell이 3개만 들어가도록 크기 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.bookListCellSize()
    }
}

