//
//  CreateBookClubViewModel.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/08.
//

import Foundation
import UIKit.UIColor
import RxSwift
import RxCocoa

class CreateBookClubViewModel {
    // Outputs
    let isNameConfirmed: Driver<Bool>
    var selectedColor: Driver<String?>
    let createdBookClub: Driver<Bool>
    
    init(
        // inputs from View
        input: (
            nameText: Driver<String?>,
            redButtonTap: Signal<()>,
            greenButtonTap: Signal<()>,
            blueButtonTap: Signal<()>,
            createButtonTap: Signal<()>
        )
    ) {
        // bind outputs
        isNameConfirmed = input.nameText
            .map { nameText in
                return nameText != nil
            }
        
        selectedColor = input.redButtonTap
            .map {
                return "red"
            }
            .asDriver(onErrorJustReturn: nil)
        
        selectedColor = input.greenButtonTap
            .map {
                return "green"
            }
            .asDriver(onErrorJustReturn: nil)
        
        selectedColor = input.blueButtonTap
            .map {
                return "blue"
            }
            .asDriver(onErrorJustReturn: nil)
        
        
        
        let colorAndName = Driver.combineLatest(isNameConfirmed, selectedColor) { (name: $0, color: $1) }
        createdBookClub = input.createButtonTap.withLatestFrom(colorAndName)
            .map { pair in
                // TODO: 선택한 컬러 처리
                return pair.name
            }
            .asDriver(onErrorJustReturn: false)
        
    }
    
}
