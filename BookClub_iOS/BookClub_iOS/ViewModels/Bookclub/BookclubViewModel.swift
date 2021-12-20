//
//  BookclubViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/26.
//

import Foundation
import RxSwift

class BookclubViewModel {
    var disposeBag = DisposeBag()
    
    var bookCollectionViewModel: BookCollectionViewModel?
    var sortBy = PublishSubject<SortBy>()
    
    // outputs
    let profiles = Observable.just([1, 2, 3, 4])
    var filterType: Observable<FilterTypeInBookclub>
    
    init(filterTapped: Observable<FilterTypeInBookclub>, searchText: Observable<String>) {
        filterType = filterTapped.map { return $0 }
        
        Observable.combineLatest(filterTapped, sortBy.distinctUntilChanged())
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { [weak self] filterType, sortBy in
                guard let self = self else { return }
                switch filterType {
                case .search:
                    print("Filtering Mode: \(filterType)")
                    _ = searchText.bind {
                        print("Searching...: \($0)")
                        self.bookCollectionViewModel?.filterBySearching(with: $0)
                    }
                case .member:
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

enum FilterTypeInBookclub: String {
    case none = ""
    case search = "검색"
    case member = "클럽원"
    case sorting = "정렬"
}
