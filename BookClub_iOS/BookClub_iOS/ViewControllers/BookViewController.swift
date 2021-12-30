//
//  BookViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/27.
//

import UIKit
import RxSwift

class BookViewController: UIViewController {

    let customView = BookView()
    
    var viewModel: BookViewModel!
    
    var disposeBag = DisposeBag()
    
    convenience init(book: BookModel?) {
        self.init()
        viewModel = BookViewModel(book_: book)
    }
    
    override func loadView() {
        self.view = customView
        self.removeBackButtonTitle()
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.defaultFont(size: 18, boldLevel: .extraBold)]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.book
            .compactMap { $0 }
            .withUnretained(self)
            .bind { (owner, book) in
                owner.title = book.name
                owner.customView.endButton.isSelected = (book.category != "BEFORE")
            }
            .disposed(by: disposeBag)
        
        viewModel.searchedInfo
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { (owner, info) in
                owner.customView.bookImageView.kf.setImage(with: URL(string: info.thumbnail), placeholder: UIImage.DefaultBookImage)
            }
            .disposed(by: disposeBag)
        
        viewModel.posts
            .bind(to: customView.memoTableView.rx.items(cellIdentifier: MemoTableViewCell.identifier, cellType: MemoTableViewCell.self)) { (row, element, cell) in
                cell.post = BehaviorSubject<PostModel?>(value: element)
                cell.bindOutputs()
            }
            .disposed(by: disposeBag)
        
        customView.memoTableView
            .rx.modelSelected(PostModel.self)
            .withLatestFrom(viewModel.book) { ($0, $1) }
            .bind { [weak self] in
                let vc = PostViewController(post_: $0.0, book_: $0.1)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
