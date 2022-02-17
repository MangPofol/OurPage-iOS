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
    
    var disposeBag = DisposeBag()
    
    init(post_: PostModel?, book_: BookModel?, linkTapped: Observable<UITapGestureRecognizer>) {
        guard let post = post_, let book = book_ else { return }
        
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
        
        self.book.onNext(book)
        self.post.onNext(post)
    }
}
