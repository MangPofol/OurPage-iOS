//
//  PostViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/28.
//

import Foundation

import RxSwift
import RxCocoa
import UIKit.UITapGestureRecognizer

class PostViewModel {
    var post = BehaviorSubject<PostModel?>(value: nil)
    var book = BehaviorSubject<BookModel?>(value: nil)
    var urlToOpen = PublishRelay<URL?>()
    var isPostDeleted = PublishRelay<Bool>()
    
    var disposeBag = DisposeBag()

    var deletePost = PublishRelay<Bool>()
    
    init(post_: PostModel?, book_: BookModel?,
         linkTapped: Observable<UITapGestureRecognizer>) {
        guard let post = post_, let book = book_ else { return }
        
        self.book.onNext(book)
        self.post.onNext(post)
        
        linkTapped
            .debug()
            .map { _ -> URL? in
                if post.hyperlink == "" {
                    return nil
                }
                if !post.hyperlink.hasPrefix("http") {
                    return URL(string: "http://" + post.hyperlink)
                }
                return URL(string: post.hyperlink)
            }
            .bind(to: self.urlToOpen)
            .disposed(by: disposeBag)
        
        deletePost
            .delay(.seconds(2), scheduler: MainScheduler.instance)
            .flatMap { _ in
                PostServices.deletePost(postId: post_!.postId)
            }
            .bind(to: self.isPostDeleted)
            .disposed(by: disposeBag)
    }
}
