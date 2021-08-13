//
//  BookListViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/13.
//

import UIKit
import RxSwift
import RxCocoa

class BookListViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = BookListViewModel()
    
    // collectionView
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // add and configure collection view
        self.view.addSubview(self.collectionView)
        self.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        self.collectionView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(10)
        }
        
        // Register cell classes
        self.collectionView.register(BookListViewCell.self, forCellWithReuseIdentifier: BookListViewCell.identifier)
        
        viewModel.data
            .bind(to:
                    self.collectionView
                    .rx
                    .items(cellIdentifier: BookListViewCell.identifier, cellType: BookListViewCell.self)) { (row, element, cell) in
                cell.bookImageView.image = UIImage(named: element.image)
                cell.bookTitleLabel.text = element.title
            }.disposed(by: disposeBag)
        
        //                maincollectionView.rx
        //                    .modelSelected(BotMenu.self)
        //                    .subscribe({ (item) in
        //                        print(item.element?.path ?? "")
        //                        let pushVC = PushViewController()
        //                        self.present(pushVC, animated: true, completion: nil)
        //                    }).disposed(by: disposeBag)
        
    }
    
}

extension BookListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let width = collectionView.bounds.width
           let cellWidth = (width - 30) / 3 // compute your cell width
           return CGSize(width: cellWidth, height: cellWidth / 0.6)
       }
}
