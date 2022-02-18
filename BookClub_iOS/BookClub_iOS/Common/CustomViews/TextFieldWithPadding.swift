//
//  TextFieldWithPadding.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/20.
//

import UIKit

class TextFieldWithPadding: UITextField {
    
    var padding: UIEdgeInsets!
    
    convenience init(padding: UIEdgeInsets, frame: CGRect) {
        self.init(frame: frame)
        self.padding = padding
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
