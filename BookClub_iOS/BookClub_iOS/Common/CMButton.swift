//
//  CMButton.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/01.
//

import UIKit

final class CMButton: UIButton {
    var defaultBackgroundColor: UIColor = .mainPink
    var disabledBackgroundColor: UIColor = .textFieldBackgroundGray
    
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
