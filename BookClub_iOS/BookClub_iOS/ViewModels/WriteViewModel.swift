//
//  WriteViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/17.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit.UIImage

class WriteViewModel {
    
    // Inputs
    var uploadedImages = BehaviorRelay<[UIImage]>(value: [])
    var selectedBook = BehaviorSubject<Book?>(value: nil)
    var uploadedImagesURLs = BehaviorRelay<[String]>(value: [])
    
    // Outputs
    var bookSelection: Observable<Bool>
    var isMemo: Observable<Bool>
    var isTopic: Observable<Bool>
    var imageUploading: Observable<Bool>
    var isWriting: Observable<Bool>
    
    init(
        input: (
            bookSelectionButtonTapped: Signal<()>,
            isMemoOn: Observable<Bool>,
            isTopicOn: Observable<Bool>,
            imageUploadButtonTapped: Signal<()>,
            writeButtonTapped: Signal<()>,
            titleText: Observable<String?>,
            contentText: Observable<String>
        )
    ) {
        
        // bind outputs
        bookSelection = input.bookSelectionButtonTapped.asObservable().map { true }
                
        isMemo = input.isMemoOn.map {
            $0
        }
        
        isTopic = input.isTopicOn.map {
            $0
        }
        let type = Observable.combineLatest(isMemo, isTopic)
            .map { value -> String? in
                if value.0 {
                    return "MEMO"
                }
                if value.1 {
                    return "TOPIC"
                }
                return nil
            }
        
        imageUploading = input.imageUploadButtonTapped.asObservable().map { true }
        
        let postSource = Observable.combineLatest(type, input.titleText, input.contentText, self.selectedBook) {
            (type: $0, title: $1, content: $2, book: $3)
        }
        
        isWriting = input.writeButtonTapped.asObservable().withLatestFrom(postSource)
            .flatMap { source -> Observable<Bool> in
                print(postSource)
                if source.book != nil {
                    let post = PostToCreate(bookId: source.book!.bookModel.id, type: source.type!, scope: "PUBLIC", isIncomplete: false, imgLocation: "", title: source.title!, content: source.content)
                    
                    return PostServices.createPost(post: post).map { $0 != nil }
                } else {
                    return Observable.just(false)
                }
            }
    }
}
