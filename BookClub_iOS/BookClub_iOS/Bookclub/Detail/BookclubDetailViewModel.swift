//
//  BookclubDetailViewModel.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/04/12.
//

import Foundation

import RxSwift
import RxCocoa

class BookclubDetailViewModel: ViewModelType {
    var bookclub: Club!
    
    struct Input {
        
    }
    
    struct Output {
        var title: Driver<String>!
        var description: Driver<String>!
        var member: Driver<Int>!
        var totalPages: Driver<Int>!
        var level: Driver<Int>!
    }
    
    var input: Input?
    var output: Output = Output()
    
    private let disposeBag = DisposeBag()
    
    init(bookclub: Club) {
        self.bookclub = bookclub
        
        let bookclubInfo = BookclubServices.getClubInfoByClub(id: self.bookclub.id)
        
        self.output.title = bookclubInfo.compactMap { $0?.name }.asDriver(onErrorJustReturn: "")
        self.output.description = bookclubInfo.compactMap { $0?.description }.asDriver(onErrorJustReturn: "")
        self.output.member = bookclubInfo.compactMap { $0?.totalUser }.asDriver(onErrorJustReturn: 0)
        self.output.totalPages = bookclubInfo.compactMap { $0?.totalPosts }.asDriver(onErrorJustReturn: 0)
        self.output.level = bookclubInfo.compactMap { $0?.level }.asDriver(onErrorJustReturn: 0)
    }
}
