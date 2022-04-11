//
//  BookclubCreateViewController.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/30.
//

import UIKit

import RxSwift
import RxCocoa

class BookclubCreateViewController: UIViewController {
    private let customView = BookclubCreateView()
    
    private var viewModel: BookclubCreateViewModel!
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = customView
        self.navigationItem.title = "북클럽 추가"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: nil, action: nil).then {
            $0.setTitleTextAttributes([.font: UIFont.defaultFont(size: 14, boldLevel: .bold), .foregroundColor: UIColor.mainColor], for: .normal)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customView.nameTextField.setMaxLength(maxLength: 10, disposeBag: self.disposeBag)
        self.customView.descriptionTextField.setMaxLength(maxLength: 20, disposeBag: self.disposeBag)
        
        self.viewModel = BookclubCreateViewModel(
            input: BookclubCreateViewModel.Input(
                nameText: self.customView.nameTextField.rx.text.orEmpty.asObservable(),
                descriptionText: self.customView.descriptionTextField.rx.text.orEmpty.asObservable(),
                finishButtonTapped: self.navigationItem.rightBarButtonItem!.rx.tap
            )
        )
        
        // bind outputs {
        self.navigationItem.rightBarButtonItem!.rx.tap
            .bind {
                LoadingHUD.show()
            }
            .disposed(by: disposeBag)
        
        self.viewModel.output.bookclubCreated
            .do { _ in LoadingHUD.hide() }
            .debug("북클럽 생성")
            .drive {
                switch $0 {
                case .success(let bookclub):
                    print(bookclub)
                case .nameDuplicated:
                    print("Duplicated")
                case .failure:
                    print("Failure")
                }
            }
            .disposed(by: disposeBag)
        // }
    }
}
