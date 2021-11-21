//
//  GenderBirthViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/03.
//

import Foundation
import RxSwift
import RxCocoa

class GenderBirthViewModel {
    var genderConfirmed: Observable<Bool>
    var birthConfirmed: Observable<Bool>
    
    var newDays: Observable<Int>
    
    var isAbleToProgress: Observable<Bool>
    var nextConfirmed: Observable<Bool>
    
    var disposeBag = DisposeBag()
    
    // Initial date
    var selectedYear = BehaviorSubject(value: 1997)
    var selectedMonth = BehaviorSubject(value: 1)
    var selectedDay = BehaviorSubject(value: 1)
    
    init(
        input: (
            isMenSelected: Observable<Bool>,
            isWomenSelected: Observable<Bool>,
            nextButtonTapped: ControlEvent<()>
        )
    ) {
        let dateComponents = BehaviorSubject(value: (1997, 1, 1))
        Observable.combineLatest(selectedYear.asObservable(), selectedMonth.asObservable(), selectedDay.asObservable())
            .bind {
                dateComponents.onNext(($0, $1, $2))
            }.disposed(by: disposeBag)
        
        let selectedGender = input.isMenSelected.withLatestFrom(input.isWomenSelected) { men, women -> String? in
            if men { return "MALE" }
            if women { return "FEMALE" }
            return nil
        }
        
        genderConfirmed = selectedGender
            .do {
                if $0 != nil {
                    SignUpViewModel.creatingUser.sex = $0!
                }
            }
            .map { $0 != nil }
        
        birthConfirmed = Observable.just(true)
        
        newDays = Observable.combineLatest(selectedYear, selectedMonth)
            .map {
                let calendar = Calendar.current
                let date = Date.date(year: $0, month: $1, day: 1)!

                let interval = calendar.dateInterval(of: .month, for: date)!
                let days = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
                return days
            }.distinctUntilChanged()
        
        isAbleToProgress = Observable.combineLatest(genderConfirmed, birthConfirmed).map { $0 && $1 }
        
        nextConfirmed = input.nextButtonTapped.withLatestFrom(dateComponents)
            .map {
                let birth = "\($0)-\($1)-\($2)T11:11:11"
                SignUpViewModel.creatingUser.birthdate = birth
                print(#fileID, #function, #line, SignUpViewModel.creatingUser)
                return true
            }
    }
}
