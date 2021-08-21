//
//  ToggleButton.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/19.
//

import UIKit
import RxSwift

class ToggleButton: UIButton {
    
    var normalColor: UIColor
    var onColor: UIColor
    var normalTextColor: UIColor = .black
    var onTextColor: UIColor = .white
    
    var isOnRx = BehaviorSubject<Bool>(value: false)
    let disposeBag = DisposeBag()
    
    var relatedButtons: [ToggleButton] = []
    
    var isOn = false {
        didSet {
            isOnRx.onNext(isOn)
            self.backgroundColor = isOn ? onColor : normalColor
            self.setTitleColor( isOn ? onTextColor : normalTextColor, for: .normal)
            if isOn == true {
                relatedButtons.forEach {
                    $0.isOn = false
                }
            }
            
        }
    }
    
    required init(normalColor: UIColor, onColor: UIColor) {
        self.normalColor = normalColor
        self.onColor = onColor
        super.init(frame: .zero)
        addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tap() {
        isOn.toggle()
    }
}
