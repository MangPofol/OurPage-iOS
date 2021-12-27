//
//  HomeViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/29.
//

import Foundation

import RxSwift
import RxCocoa

class HomeViewModel {
    var checkListToggle: Observable<Bool>
    var openMyProfileView: Observable<Bool>
    var openModifyGoalView : Observable<Bool>
    var openWriteView: Observable<Bool>
    var totalCount: Observable<Int?>
    
    init(checkListButtonTapped: ControlEvent<()>, myProfileButtonTapped: ControlEvent<()>, goalButtonTapped: ControlEvent<()>, writeButtonTapped: ControlEvent<()>) {
        checkListToggle = checkListButtonTapped.map { true }
        openMyProfileView = myProfileButtonTapped.map { true }
        openModifyGoalView = goalButtonTapped.map { true }
        openWriteView = writeButtonTapped.map { true }
        totalCount = PostServices.getTotalCount()
    }
}
