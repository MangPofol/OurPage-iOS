//
//  BookViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/27.
//

import UIKit

import RxSwift
import FFPopup

class BookViewController: UIViewController {

    let customView = BookView()
    
    var viewModel: BookViewModel!
    private var popup: FFPopup!
    
    var disposeBag = DisposeBag()
    
    convenience init(book: BookModel?) {
        self.init()
        viewModel = BookViewModel(
            book_: book,
            input: (
                readingButtonTapped: self.customView.readingButton.rx.tapGesture().when(.recognized).map { [unowned self] _ in self.customView.readingButton.isOn },
                finishButtonTapped: self.customView.finishButton.rx.tapGesture().when(.recognized).map { [unowned self] _ in self.customView.finishButton.isOn },
                writeButtonTapped: self.customView.writeButton.rx.tapGesture().when(.recognized)
            )
        )
    }
    
    override func loadView() {
        self.view = customView
        self.removeBackButtonTitle()
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.defaultFont(size: 18, boldLevel: .extraBold)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.refreshPosts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Action Button 누르면 로딩
        Observable.merge(
            self.customView.readingButton.rx.tapGesture().when(.recognized).asObservable(),
            self.customView.finishButton.rx.tapGesture().when(.recognized).asObservable(),
            self.customView.writeButton.rx.tapGesture().when(.recognized).asObservable()
        ).bind { _ in
            LoadingHUD.show()
        }
        .disposed(by: disposeBag)
        
        self.customView.deleteButton.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in
                self?.showDeleteAlert()
            }
            .disposed(by: disposeBag)
        
        viewModel.book
            .compactMap { $0 }
            .withUnretained(self)
            .bind { (owner, book) in
                LoadingHUD.hide()
                owner.customView.bookTitleLabel.text = book.name
                owner.customView.readingButton.isOn = (book.category == "NOW")
                owner.customView.finishButton.isOn = (book.category == "AFTER")
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
            .debug()
            .bind(to: customView.memoTableView.rx.items(cellIdentifier: MemoTableViewCell.identifier, cellType: MemoTableViewCell.self)) { (row, element, cell) in
                cell.post = element
            }
            .disposed(by: disposeBag)
        
        viewModel.bookDeleted
            .bind { [weak self] in
                self?.popup.dismiss(animated: true)
                LoadingHUD.hide()
                guard let self = self, $0 == true else { return }
                self.navigationController?.popViewController(animated: true)
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
    
    private func showDeleteAlert() {
        let view = DeleteAlertView(title: "책을 삭제하시겠습니까?", content: "전체 메모 리스트도 함께 삭제됩니다.", action: "삭제")
        let layout = FFPopupLayout(horizontal: .center, vertical: .center)
        popup = FFPopup(contentView: view, showType: .bounceIn, dismissType: .shrinkOut, maskType: .dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)
        
        view.actionButton.rx.tap
            .bind { [weak self] _ in
                LoadingHUD.show()
                self?.viewModel.deleteButtonTapped.accept(true)
            }
            .disposed(by: disposeBag)
        
        view.cancelButton.rx.tap
            .bind { [weak self] _ in
                self?.popup.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        popup.show(layout: layout)
    }
}
