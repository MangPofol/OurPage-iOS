//
//  ToggleButton.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/19.
//

import UIKit

class ToggleButton: UIButton {
    
    var normalColor: UIColor
    var onColor: UIColor
    var normalTextColor: UIColor = .black
    var onTextColor: UIColor = .white
    
    var isOn = false {
        didSet {
            self.backgroundColor = isOn ? onColor : normalColor
            self.setTitleColor( isOn ? onTextColor : normalTextColor, for: .normal)
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
