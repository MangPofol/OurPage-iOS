//
//  BookclubBookViewModel.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/05/01.
//

import Foundation

import RxSwift
import RxCocoa

final class BookclubBookViewModel: ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        var searchedInfo: Driver<SearchedBook?>!
        var posts: Driver<[PostModel]>!
    }
    
    var input: Input?
    var output: Output = Output()
    
    private var bookclubBook: BookclubBook?
    private var bookclubId: Int?
    
    private var disposeBag = DisposeBag()
    
    init(bookclubBook: BookclubBook, bookclubId: Int?) {
        self.bookclubBook = bookclubBook
        
        guard let bookclubBook = self.bookclubBook, let bookclubId = bookclubId else {
            return
        }
        
        self.output.searchedInfo = SearchServices.searchBookBy(isbn: bookclubBook.isbn)
            .map { $0.first }
            .asDriver(onErrorJustReturn: nil)
        
        self.output.posts = PostServices.getPostsByBookIdAndClubId(bookId: bookclubBook.bookId, bookclubId: bookclubId).asDriver(onErrorJustReturn: [])
    }
}
