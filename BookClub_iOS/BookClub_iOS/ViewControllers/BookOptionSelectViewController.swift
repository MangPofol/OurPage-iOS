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
    
    var bookSelectVC: BookSelectViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(customView)
        self.view.backgroundColor = .clear
        customView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(Constants.getAdjustedHeight(187.0))
        }
        
        let viewModel = BookOptionSelectViewModel(addButtonTapped: customView.addBookButton.rx.tap.asSignal(), selectedBook: selectedBook)
        customView.readingButton.rx.tap.bind {
            viewModel.categorySelected.onNext(.NOW)
        }.disposed(by: disposeBag)
        
        customView.finishedButton.rx.tap.bind {
            viewModel.categorySelected.onNext(.AFTER)
        }.disposed(by: disposeBag)
        
        customView.wantToButton.rx.tap.bind {
            viewModel.categorySelected.onNext(.BEFORE)
        }.disposed(by: disposeBag)
        
        viewModel.isAddingBook
            .bind {
                switch $0 {
                case .NOW:
                    self.dismiss(animated: true) {
                        if self.bookSelectVC != nil {
                            self.bookSelectVC?.newBookSelected.onNext(self.selectedBook)
                        }
                    }
                case .AFTER:
                    self.dismiss(animated: true) {
                        if self.bookSelectVC != nil {
                            self.bookSelectVC?.newBookSelected.onNext(self.selectedBook)
                        }
                    }
                case .BEFORE:
                    self.dismiss(animated: true) {
                        if self.bookSelectVC != nil {
                            self.bookSelectVC?.customView.searchBar.searchTextField.text = ""
                            self.bookSelectVC?.customView.searchBar.searchTextField.sendActions(for: .valueChanged)
//                            self.bookSelectVC?.searchMode(false)
                            
                        }
                    }
                case nil:
                    print("Error")
                }
                
            }
            .disposed(by: disposeBag)
        
    }
    
}
