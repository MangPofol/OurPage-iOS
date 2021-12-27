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
    var disposeBag = DisposeBag()
    
    init(post_: PostModel?) {
        guard let post = post_ else { return }
        
        self.post.onNext(post)
    }
}
