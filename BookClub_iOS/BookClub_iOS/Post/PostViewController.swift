//
//  PostViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/28.
//

import UIKit

import RxSwift
import RxGesture
import SafariServices
import FFPopup

class PostViewController: UIViewController {

    let customView = PostView()
    
    var viewModel: PostViewModel!
    
    var disposeBag = DisposeBag()
    
    private var post_: PostModel?
    private var book_: BookModel?
    
    private var popup: FFPopup!
    
    convenience init(post_: PostModel?, book_: BookModel?) {
        self.init()
        self.post_ = post_
        self.book_ = book_
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.addSubview(customView)
        customView.snp.makeConstraints { $0.edges.equalToSuperview() }
        customView.makeView()
        self.navigationController?.navigationBar.removeBarShadow()
        self.removeBackButtonTitle()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = .zero
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 335.adjustedHeight, height: 335.adjustedHeight)
        customView.imageCollectionView.setCollectionViewLayout(flowLayout, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = PostViewModel(
            post_: post_,
            book_: book_,
            linkTapped: customView.linkView.rx.tapGesture().when(.recognized)
        )
        
        customView.modifyButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                self.navigationController?.pushViewController(WriteViewController(post: self.post_!, selectedBook: self.book_!), animated: true)
            }
            .disposed(by: disposeBag)
        
        customView.deleteButton.rx.tap
            .bind { [weak self] in
                self?.showDeleteAlert()
            }
            .disposed(by: disposeBag)
        
        viewModel.post
            .compactMap { $0 }
            .withUnretained(self)
            .bind { (owner, post) in
                owner.customView.postTitleLabel.text = post.title
                owner.customView.postContentTextView.text = post.content
                owner.customView.dateLabel.text = post.modifiedDate.toString(with: "yyyy/MM/dd HH:mm")
                owner.customView.placeView.label.text = post.location
                owner.customView.timeView.label.text = post.readTime
                let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
                let underlineAttributedString = NSAttributedString(string: post.linkResponseDtos.first?.hyperlinkTitle ?? "", attributes: underlineAttribute)
                owner.customView.linkView.label.attributedText = underlineAttributedString
            }
            .disposed(by: disposeBag)
        
        viewModel.post
            .compactMap {
                $0?.postImgLocations
            }
            .do { [weak self] in
                self?.customView.imagePageControl.numberOfPages = $0.count
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
        
        viewModel.urlToOpen
            .debug()
            .compactMap { $0 }
            .bind { [weak self] in
                guard let self = self else { return }
                let safariView = SFSafariViewController(url: $0)
                self.present(safariView, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        viewModel.isPostDeleted
            .bind { [weak self] in
                if $0 {
                    LoadingHUD.hide()
                    self?.popup.dismiss(animated: true)
                    self?.navigationController?.popViewController(animated: true)
                }
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
        
        customView.imageCollectionView.rx.willEndDragging
            .bind { [weak self] in
                guard let self = self else { return }
                let page = Int($0.1.pointee.x / 335.adjustedHeight)
                self.customView.imagePageControl.currentPage = page
            }
            .disposed(by: disposeBag)
    }
    
    private func showDeleteAlert() {
        let view = DeleteAlertView(title: "메모를 삭제하시겠습니까?", content: "메모는 추후 복구가 불가능합니다.", action: "삭제")
        let layout = FFPopupLayout(horizontal: .center, vertical: .center)
        popup = FFPopup(contentView: view, showType: .bounceIn, dismissType: .shrinkOut, maskType: .dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)
        
        view.actionButton.rx.tap
            .bind { [weak self] _ in
                LoadingHUD.show()
                self?.viewModel.deletePost.accept(true)
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
