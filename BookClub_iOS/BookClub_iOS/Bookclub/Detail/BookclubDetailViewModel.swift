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
    var bookclub: Bookclub!
    private var clubBooks: [BookclubBook] = []
    
    struct Input {
        var selectedBookIndex = PublishRelay<Int>()
    }
    
    struct Output {
        var title: Driver<String>!
        var description: Driver<String>!
        var member: Driver<Int>!
        var totalPages: Driver<Int>!
        var level: Driver<Int>!
        var isWelcomeViewHidden: Driver<Bool>!
        var clubBooks: Driver<[BookclubBook]>!
        var openBookDetail: Driver<BookclubBook?>!
        var trendingMemos: Driver<[ClubPost]>!
    }
    
    var input: Input? = Input()
    var output: Output = Output()
    
    private let disposeBag = DisposeBag()
    
    init(bookclub: Bookclub) {
        self.bookclub = bookclub
        
        let bookclubInfo = BookclubServices.getClubInfoByClub(id: self.bookclub.id)
        
        self.output.title = bookclubInfo.compactMap { $0?.clubMetadata.name }.asDriver(onErrorJustReturn: "")
        self.output.description = bookclubInfo.compactMap { $0?.clubMetadata.description }.asDriver(onErrorJustReturn: "")
        self.output.member = bookclubInfo.compactMap { $0?.totalUser }.asDriver(onErrorJustReturn: 0)
        self.output.totalPages = bookclubInfo.compactMap { $0?.totalPosts }.asDriver(onErrorJustReturn: 0)
        self.output.level = bookclubInfo.compactMap { $0?.clubMetadata.level }.asDriver(onErrorJustReturn: 0)
        self.output.isWelcomeViewHidden = bookclubInfo.compactMap { $0 }
            .map {
                return !(($0.totalUser == 1) && $0.clubMetadata.createdDate.isInToday)
            }
            .asDriver(onErrorJustReturn: true)
        self.output.clubBooks = bookclubInfo
            .compactMap { [weak self] in
                let books = $0?.bookclubBook
                self?.clubBooks = books ?? []
                
                return books
            }
            .asDriver(onErrorJustReturn: [])
        
        self.output.openBookDetail = self.input?.selectedBookIndex
            .compactMap { [weak self] in
                guard let self = self else { return nil}
                
                return self.clubBooks[$0]
            }
            .asDriver(onErrorJustReturn: nil)
        
        self.output.trendingMemos = bookclubInfo.compactMap { $0?.trendingPosts }.asDriver(onErrorJustReturn: [])
    }
}
