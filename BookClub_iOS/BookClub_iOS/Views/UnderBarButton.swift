//
//  UnderBarButton.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/05.
//

import UIKit

class UnderBarButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
