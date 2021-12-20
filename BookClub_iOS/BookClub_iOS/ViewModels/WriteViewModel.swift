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
    var imageUploading: Observable<Bool>
    var isWriting: Observable<Bool>
    
    init(
        input: (
            bookSelectionButtonTapped: Signal<()>,
            imageUploadButtonTapped: Signal<()>,
            writeButtonTapped: Signal<()>,
            titleText: Observable<String?>,
            contentText: Observable<String>
        )
    ) {
        
        // bind outputs
        bookSelection = input.bookSelectionButtonTapped.asObservable().map { true }
        
        imageUploading = input.imageUploadButtonTapped.asObservable().map { true }
        
        let postSource = Observable.combineLatest(input.titleText, input.contentText, self.selectedBook) {
            (title: $0, content: $1, book: $2)
        }
        
        isWriting = input.writeButtonTapped.asObservable().withLatestFrom(postSource)
            .flatMap { source -> Observable<Bool> in
                print(postSource)
                if source.book != nil {
                    let post = PostToCreate(bookId: source.book!.bookModel.id, scope: "CLUB", isIncomplete: false, location: "내 방", readTime: "어제", hyperlinkTitle: "", hyperlink: "", title: source.title ?? "", content: source.content, postImgLocations: [], clubIdListForScope: [])
                    
                    return PostServices.createPost(post: post).map { $0 != nil }
                } else {
                    return Observable.just(false)
                }
            }
    }
}
