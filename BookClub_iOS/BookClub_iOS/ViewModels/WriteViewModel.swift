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
    
    // Outputs
    var bookSelection: Observable<Bool>
    var isMemo: Observable<Bool>
    var isTopic: Observable<Bool>
    var imageUploading: Observable<Bool>
    
    init(
        input: (
            bookSelectionButtonTapped: Signal<()>,
            isMemoOn: Observable<Bool>,
            isTopicOn: Observable<Bool>,
            imageUploadButtonTapped: Signal<()>
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
        
        imageUploading = input.imageUploadButtonTapped.asObservable().map { true }
        
    }
}
