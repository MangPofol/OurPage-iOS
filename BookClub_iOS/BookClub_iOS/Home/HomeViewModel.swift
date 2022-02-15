//
//  HomeViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/29.
//

import Foundation

import UIKit.UITapGestureRecognizer
import RxSwift
import RxCocoa
import RxGesture

class HomeViewModel {
    var checkListToggle: Observable<Bool>
    var openMyProfileView: Observable<Bool>
    var openModifyGoalView : Observable<Bool>
    var openWriteView: Observable<Bool>
    var totalCount: Observable<Int?>
    
    init(checkListButtonTapped: ControlEvent<()>, myProfileButtonTapped: ControlEvent<()>, goalButtonTapped: Observable<UITapGestureRecognizer>, writeButtonTapped: Observable<UITapGestureRecognizer>) {
        checkListToggle = checkListButtonTapped.map { true }
        openMyProfileView = myProfileButtonTapped.map { true }
        openModifyGoalView = goalButtonTapped.map { _ in true }
        openWriteView = writeButtonTapped.map { _ in true }
        totalCount = PostServices.getTotalCount()
    }
}
