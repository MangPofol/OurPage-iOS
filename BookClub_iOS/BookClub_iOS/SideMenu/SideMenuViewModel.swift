//
//  SideMenuViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/10.
//

import Foundation
import RxSwift
import RxCocoa

class SideMenuViewModel {
    
    // outputs
    let bookclubs = Observable<[String]>.of(["북클럽 1", "북클럽 2"])
    let joinedClubs = Observable<[String]>.of(["북클럽 3"])
    let alerts = Observable<[AlertModel]>.of([AlertModel(title: "북클럽 1", content: "알림 내용입니다", comment: "알림 댓글입니다"), AlertModel(title: "북클럽 2", content: "알림 내용입니다2", comment: "알림 댓글입니다2")])
    
    init() {
        
    }
}
