//
//  HotViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/26.
//

import Foundation
import RxSwift
import RxCocoa

class HotViewModel {
    let hots = Observable.just([Hot(content: "메모 제목", book: "나미야 잡화점의 기적"), Hot(content: "메모 제목", book: "공간의 미래"), Hot(content: "메모 제목", book: "그러라 그래")])
}
