//
//  WriteSettingViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/21.
//

import Foundation

import RxSwift
import RxCocoa

class WriteSettingViewModel {
    var postToCreate: PostToCreate!
    
    var ableToPost: Observable<Bool>
    var postSuccess: Observable<PostToCreate?>
    
    init(
        input: (
            placeText: Observable<String>,
            timeText: Observable<String>,
            linkTitleText: Observable<String>,
            linkContentText: Observable<String>,
            postButtonTapped: ControlEvent<()>
        )
    ) {
        let inputs = Observable.combineLatest(input.placeText, input.timeText, input.linkTitleText, input.linkContentText) {
            (place: $0, time: $1, linkTitle: $2, linkContent: $3)
        }
        
        ableToPost = inputs.map {
            return ($0.linkTitle == "" && $0.linkContent == "") || ($0.linkTitle != "" && $0.linkContent != "")
        }
        
        var post = postToCreate!
        postSuccess = input.postButtonTapped.asObservable().withLatestFrom(inputs)
            .flatMap { inputs -> Observable<PostToCreate?> in
                post.location = inputs.place
                post.readTime = inputs.time
                post.hyperlinkTitle = inputs.linkTitle
                post.hyperlink = inputs.linkContent
                
                return PostServices.createPost(post: post)
            }
            
    }
}
