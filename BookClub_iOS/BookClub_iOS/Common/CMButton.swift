//
//  CMButton.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/01.
//

import UIKit

final class CMButton: UIButton {
    var defaultBackgroundColor: UIColor = .mainPink {
        didSet {
            self.backgroundColor = defaultBackgroundColor
        }
    }
    var disabledBackgroundColor: UIColor = .textFieldBackgroundGray
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = defaultBackgroundColor.withAlphaComponent(0.75)
            } else {
                self.backgroundColor = defaultBackgroundColor
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.backgroundColor = defaultBackgroundColor
            } else {
                self.backgroundColor = disabledBackgroundColor
            }
        }
    }
}
