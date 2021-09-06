//
//  Constants.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/05.
//

import Foundation
import UIKit.UIScreen

class Constants {
    static let createBookClubTitleText = "북클럽 생성하기"
    static let screenSize = UIScreen.main.bounds.size
    static let navigationbarColor: UIColor = .white
    static let buttonStackSpacing = Constants.getAdjustedWidth(8.0)
    static let selectedControlHeight = Constants.getAdjustedHeight(26.0)
    
    static func bookListCellSize() -> CGSize {
        let width = Constants.getAdjustedWidth(102.0)
        let height = Constants.getAdjustedHeight(149.0)
        return CGSize(width: width, height: height)
    }
    
    static func bookclubSelectorSize() -> CGSize {
        let width = Constants.getAdjustedWidth(84.0)
        let height = Constants.getAdjustedHeight(19.0)
        return CGSize(width: width, height: height)
    }
    
    static func profileImageSize() -> CGSize {
        return CGSize(width: 50.0, height: 50.0)
    }
    
    static func getAdjustedWidth(_ value: Double) -> Double {
        return (Double(Constants.screenSize.width) * value) / 375
    }
    
    static func getAdjustedHeight(_ value: Double) -> Double {
        return (Double(Constants.screenSize.height) * value) / 759
    }
}

class LineView: UIView {
    convenience init(width: CGFloat = 1.0, color: UIColor = .black) {
        self.init(frame: .zero)
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
