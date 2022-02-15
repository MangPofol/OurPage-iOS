//
//  PostViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/28.
//

import Foundation

import RxSwift

class PostViewModel {
    var post = BehaviorSubject<PostModel?>(value: nil)
    var book = BehaviorSubject<BookModel?>(value: nil)
    
    var disposeBag = DisposeBag()
    
    init(post_: PostModel?, book_: BookModel?) {
        guard let post = post_, let book = book_ else { return }
        
        self.book.onNext(book)
        self.post.onNext(post)
    }
}
