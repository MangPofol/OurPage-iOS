//
//  MyLibraryViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/13.
//

import Foundation
import RxSwift
import RxCocoa

class MyLibraryViewModel {
    let disposeBag = DisposeBag()
    var bookCollectionViewModel: BookCollectionViewModel?
        
    var sortBy = PublishSubject<SortBy>()
    
    // outputs
    var bookListType = Observable.just(BookListType.NOW)
    var filterType: Observable<FilterType>
    var bookclubs = Observable<[String]>.just([])
    
    init(
        input: (
            typeTapped: Observable<BookListType>,
            filterTapped: Observable<FilterType>,
            searchText: Observable<String>
        )
    ) {
        
        bookclubs = Observable<[String]>.just(["북클럽 1", "북클럽 2", "북클럽 3"])
        
        bookListType = input.typeTapped
            .map {
                return $0
            }
        
        filterType = input.filterTapped
            .map {
                return $0
            }
        
        Observable.combineLatest(filterType, sortBy)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { filterType, sortBy in
                // TODO: 맞는 필터 타입에 맞춰 data 재가공
                switch filterType {
                case .search:
                    print("Filtering Mode: \(filterType)")
                    _ = input.searchText.bind {
                        print("Searching...: \($0)")
                        self.bookCollectionViewModel?.filterBySearching(with: $0)
                    }
                case .bookclub:
                    print(filterType)
                case .sorting:
                    self.bookCollectionViewModel?.filterBySorting(with: sortBy)
                case .none:
                    self.bookCollectionViewModel?.allFilterDisable()
                }
            })
            .disposed(by: disposeBag)
    }
}

enum BookListType: String {
    case NOW = "NOW"
    case AFTER = "AFTER"
    case BEFORE = "BEFORE"
}

enum FilterType: String {
    case none = ""
    case search = "검색"
    case bookclub = "북클럽"
    case sorting = "정렬"
}

enum SortBy: String {
    case byNew = "최신순"
    case byOld = "오래된순"
    case byName = "이름순"
    case none = ""
}
