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
    
    var disposeBag = DisposeBag()
    
    // Inputs
    var uploadingImages = BehaviorSubject<[UIImage]>(value: [])
    var selectedBook = BehaviorSubject<BookModel?>(value: nil)
    var uploadedImagesURLs = BehaviorRelay<[String]>(value: [])
    var deleteImageAt = BehaviorSubject<Int?>(value: nil)
    
    // Outputs
    var bookSelection: Observable<Bool>
    var imageUploading: Observable<Bool>
    var openPostSetting: Observable<PostToCreate?>
    var ableToNext: Observable<Bool>
    
    init(
        input: (
            bookSelectionButtonTapped: Signal<()>,
            imageUploadButtonTapped: Signal<()>,
            nextButtonTapped: Signal<()>,
            titleText: Observable<String>,
            contentText: Observable<String>
        )
    ) {
        
        // bind outputs
        bookSelection = input.bookSelectionButtonTapped.asObservable().map { true }
        
        imageUploading = input.imageUploadButtonTapped.asObservable().map { true }
        
        let postSource = Observable.combineLatest(input.titleText, input.contentText, self.selectedBook, uploadedImagesURLs.asObservable()) {
            (title: $0, content: $1, book: $2, images: $3)
        }
        
        ableToNext = postSource.map {
            return $0.title != "" && $0.content != "" && $0.content != "내용을 입력하세요." && $0.book != nil
        }
        
        openPostSetting = input.nextButtonTapped.asObservable().withLatestFrom(postSource)
            .map { source -> PostToCreate? in
                if source.book != nil {
                    let post = PostToCreate(bookId: source.book!.id, scope: "", isIncomplete: false, location: "", readTime: "", hyperlinkTitle: "", hyperlink: "", title: source.title, content: source.content, postImgLocations: source.images, clubIdListForScope: [])
                    print(#fileID, #function, #line, post)
                    return post
                } else {
                    return nil
                }
            }
        
        uploadingImages
            .filter { $0.count > 0 }
            .flatMap {
                FileServices.uploadFiles(with: $0.map { $0.jpegData(compressionQuality: 0.1)! })
            }
            .compactMap { $0 }
            .bind { [weak self] in
                guard let self = self else { return }
                self.uploadedImagesURLs.accept(self.uploadedImagesURLs.value + $0)
            }
            .disposed(by: disposeBag)
        
        deleteImageAt
            .compactMap { $0 }
            .flatMap { [weak self] index -> Observable<Bool> in
                if var urls = self?.uploadedImagesURLs.value {
                    return FileServices.deleteFiles(files: [urls[index]]).flatMap { bool -> Observable<Bool> in
                        if bool {
                            urls.remove(at: index)
                            self?.uploadedImagesURLs.accept(urls)
                        }
                        return Observable.just(bool)
                    }
                }
                return Observable.just(false)
            }
            .bind {
                print(#fileID, #function, #line, $0)
            }
            .disposed(by: disposeBag)
    }
}
