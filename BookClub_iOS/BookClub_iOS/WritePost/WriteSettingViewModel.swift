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
    
    var clubs: Observable<[Club]>
    
    var ableToPost: Observable<Bool>
    var postSuccess: Observable<PostModel?>
    
    var selectedClub = BehaviorSubject<Club?>(value: nil)
    var deselectedClub = BehaviorSubject<Club?>(value: nil)
    
    var selectedClubs = BehaviorRelay<[Club]>(value: [])
    
    var disposeBag = DisposeBag()
    
    init(
        input: (
            placeText: Observable<String>,
            timeText: Observable<String>,
            linkTitleText: Observable<String>,
            linkContentText: Observable<String>,
            postButtonTapped: ControlEvent<()>?,
            postToCreate: PostToCreate,
            updatingPostId: Int?
        )
    ) {
        let myLibrary = Club(id: -1, name: "내 서재", colorSet: "", level: -1, presidentId: -1, description: "", createdDate: "", modifiedDate: "")
        clubs = ClubServices.getClubByUser()
            .map {
                return [myLibrary] + $0
            }
        
        let inputs = Observable.combineLatest(input.placeText, input.timeText, input.linkTitleText, input.linkContentText, selectedClubs) {
            (place: $0, time: $1, linkTitle: $2, linkContent: $3, clubs: $4)
        }
        
        ableToPost = inputs.map {
            return ($0.linkTitle == "" && $0.linkContent == "") || ($0.linkTitle != "" && $0.linkContent != "")
        }
        
        var post = input.postToCreate
        postSuccess = input.postButtonTapped!.asObservable().withLatestFrom(inputs)
            .flatMap { inputs -> Observable<PostModel?> in
                post.location = inputs.place
                post.readTime = inputs.time
                post.linkRequestDtos = [CreatingPostHyperlink(hyperlinkTitle: inputs.linkTitle, hyperlink: inputs.linkContent)]
                post.clubIdListForScope = inputs.clubs.map { $0.id }
                
                post.scope = "PRIVATE"
                
                if let updatingPostId = input.updatingPostId {
                    return PostServices.updatePost(post: PostToUpdate(scope: post.scope, isIncomplete: post.isIncomplete, location: post.location, readTime: post.readTime, title: post.title, content: post.content, postImgLocations: post.postImgLocations, linkRequestDtos: post.linkRequestDtos, clubIdListForScope: post.clubIdListForScope), postId: updatingPostId)
                }
                
                return PostServices.createPost(post: post)
            }
            
        selectedClub
            .compactMap { $0 }
            .bind { [weak self] val in
                guard let self = self else { return }
                if val.id == -1 {
                    return
                }
                let arr = self.selectedClubs.value
                
                if !arr.contains(where: { $0.id == val.id }) {
                    self.selectedClubs.accept(arr + [val])
                }
            }
            .disposed(by: disposeBag)
        
        deselectedClub
            .compactMap { $0 }
            .bind { [weak self] val in
                guard let self = self else { return }
                if val.id == -1 {
                    return
                }
                var arr = self.selectedClubs.value
                
                if let idx = arr.firstIndex(where: { $0.id == val.id }) {
                    arr.remove(at: idx)
                    self.selectedClubs.accept(arr)
                }
            }
            .disposed(by: disposeBag)
    }
}
