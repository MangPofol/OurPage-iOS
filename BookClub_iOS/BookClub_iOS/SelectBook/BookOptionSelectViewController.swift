//
//  BookOptionSelectViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/28.
//

import UIKit
import RxSwift
import RxCocoa

class BookOptionSelectViewController: UIViewController {
    
    let customView = BookOptionSelectView()
    var selectedBook: Book!
    let disposeBag = DisposeBag()
    
    var viewModel: BookOptionSelectViewModel!
    var bookSelectVC: BookSelectViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(customView)
        self.view.backgroundColor = .clear
        customView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(Constants.getAdjustedHeight(187.0))
        }
        
        viewModel = BookOptionSelectViewModel(addButtonTapped: customView.addBookButton.rx.tap.asSignal(), selectedBook: selectedBook)
        customView.readingButton
            .rx.tap
            .withUnretained(self)
            .bind { (owner, _) in
                owner.viewModel.categorySelected.onNext(.NOW)
            }.disposed(by: disposeBag)
        
        customView.finishedButton
            .rx.tap
            .withUnretained(self)
            .bind { (owner, _) in
                owner.viewModel.categorySelected.onNext(.AFTER)
            }.disposed(by: disposeBag)
        
        customView.wantToButton.rx.tap
            .withUnretained(self)
            .bind { (owner, _) in
                owner.viewModel.categorySelected.onNext(.BEFORE)
            }.disposed(by: disposeBag)
        
        viewModel.isAddingBook
            .compactMap { $0 }
            .withUnretained(self)
            .bind { (owner, value) in
                var book = owner.selectedBook
                book?.bookModel = value.1
                switch value.0 {
                case .NOW:
                    owner.dismiss(animated: true) {
                        if owner.bookSelectVC != nil {
                            owner.bookSelectVC?.newBookSelected.onNext(book)
                        }
                    }
                case .AFTER:
                    owner.dismiss(animated: true) {
                        if owner.bookSelectVC != nil {
                            owner.bookSelectVC?.newBookSelected.onNext(book)
                        }
                    }
                case .BEFORE:
                    owner.dismiss(animated: true) {
                        if owner.bookSelectVC != nil {
                            owner.bookSelectVC?.customView.searchBar.text = ""
                            owner.bookSelectVC?.customView.searchBar.sendActions(for: .valueChanged)
                            //                            self.bookSelectVC?.searchMode(false)
                            
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
        
    }
    
}
