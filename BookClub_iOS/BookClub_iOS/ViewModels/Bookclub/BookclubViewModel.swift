//
//  BookclubViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/26.
//

import Foundation
import RxSwift

class BookclubViewModel {
    
    // outputs
    let profiles = Observable.just([1, 2, 3, 4])
    var filterType: Observable<FilterTypeInBookclub>
    
    init(filterTapped: Observable<FilterTypeInBookclub>) {
        filterType = filterTapped.map { return $0 }
    }
}

enum FilterTypeInBookclub: String {
    case none = ""
    case search = "검색"
    case member = "클럽원"
    case sorting = "정렬"
}
