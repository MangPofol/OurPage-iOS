//
//  PostViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/28.
//

import UIKit

import RxSwift

class PostViewController: UIViewController {

    let customView = PostView()
    
    var viewModel: PostViewModel!
    
    var disposeBag = DisposeBag()
    
    convenience init(post_: PostModel?, book_: BookModel?) {
        self.init()
        viewModel = PostViewModel(post_: post_, book_: book_)
    }
    
    override func loadView() {
        self.view = customView
        self.navigationController?.navigationBar.removeBarShadow()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = .zero
        flowLayout.minimumInteritemSpacing = 1.5
        flowLayout.minimumLineSpacing = 1.5
        customView.imageCollectionView.setCollectionViewLayout(flowLayout, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        viewModel.post
            .compactMap { $0 }
            .withUnretained(self)
            .bind { (owner, post) in
                owner.customView.postTitleLabel.text = post.title
                owner.customView.postContentTextView.text = post.content
            }
            .disposed(by: disposeBag)
        
        viewModel.post
            .compactMap {
                $0?.postImgLocations
            }
            .do { [weak self] in
                if $0.count == 0 {
                    self?.customView.imageCollectionView.snp.updateConstraints {
                        $0.height.equalTo(0.adjustedHeight)
                    }
                } else {
                    self?.customView.imageCollectionView.snp.updateConstraints {
                        $0.height.equalTo(335.adjustedHeight)
                    }
                }
            }
            .bind(to: customView.imageCollectionView.rx.items(cellIdentifier: PostImageCell.identifier, cellType: PostImageCell.self)) { (row, element, cell) in
                cell.imageView.kf.setImage(with: URL(string: element))
            }
            .disposed(by: disposeBag)
        
        
        viewModel.book
            .compactMap { $0 }
            .withUnretained(self)
            .bind { (owner, book) in
                owner.customView.bookTitleLabel.text = book.name
            }
            .disposed(by: disposeBag)
        
        
        customView.imageCollectionView
            .rx.itemSelected
            .bind { [weak self] in
                guard let self = self else { return }
                let vc = OriginalImagesViewController(originalImages: self.viewModel.post.compactMap { $0?.postImgLocations }, firstIndex: $0.item)
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
            
        
        customView.imageCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
}

extension PostViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(#fileID, #function, #line, "")
        let width = 335.adjustedWidth
        if indexPath.item == 0 {
            return CGSize(width: width, height: width * (2 / 3))
        } else {
            return CGSize(width: (width / 3) - 1.5, height: (width / 3) - 1.5)
        }
    }
}
