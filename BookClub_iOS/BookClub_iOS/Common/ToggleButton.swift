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
    
    var onBorderColor: UIColor?
    var normalBorderColor: UIColor?
    
    var isOnRx = BehaviorSubject<Bool>(value: false)
    let disposeBag = DisposeBag()
    
    var relatedButtons: [ToggleButton] = []
    
    var isOn = false {
        didSet {
            isOnRx.onNext(isOn)
            self.backgroundColor = isOn ? onColor : normalColor
            self.setTitleColor( isOn ? onTextColor : normalTextColor, for: .normal)
            self.tintColor = isOn ? onTextColor : normalTextColor
            
            if onBorderColor != nil && normalBorderColor != nil {
                let color = isOn ? onBorderColor : normalBorderColor
                self.drawBorder(color: color!.cgColor)
            }
            
            if let imgView = self.imageView {
                imgView.backgroundColor = isOn ? onColor : normalColor
            }
            if isOn == true {
                relatedButtons.forEach {
                    $0.isOn = false
                }
            }
            
        }
    }
    
    required init(normalColor: UIColor, onColor: UIColor, onBorderColor: UIColor? = nil, normalBorderColor: UIColor? = nil) {
        self.normalColor = normalColor
        self.onColor = onColor
        self.onBorderColor = onBorderColor
        self.normalBorderColor = normalBorderColor
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
