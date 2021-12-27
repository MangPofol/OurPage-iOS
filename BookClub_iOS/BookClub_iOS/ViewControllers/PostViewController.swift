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
    
    convenience init(post_: PostModel?) {
        self.init()
        viewModel = PostViewModel(post_: post_)
    }
    
    override func loadView() {
        self.view = customView
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
    }
    
}
