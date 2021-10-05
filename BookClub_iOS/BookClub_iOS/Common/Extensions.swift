//
//  Extensions.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/10.
//

import Foundation
import UIKit.UITableView
import BetterSegmentedControl

extension UITableView {
    func removeExtraLine() {
        tableFooterView = UIView(frame: .zero)
    }
    
    func insertRow(indexPath: IndexPath, with animation: UITableView.RowAnimation) {
        self.beginUpdates()
        self.insertRows(at: [indexPath], with: animation)
        self.endUpdates()
    }
    
    func deleteRow(indexPath: IndexPath, with animation: UITableView.RowAnimation) {
        self.beginUpdates()
        self.deleteRows(at: [indexPath], with: animation)
        self.endUpdates()
    }
}

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: self)
    }
}

extension BetterSegmentedControl {
    func setCustomSegment(underlineColor: UIColor, indicatorHeight: Double) {
        self.setOptions([.backgroundColor(.clear), .indicatorViewBackgroundColor(.clear)])
        let customSubview = UIView(frame: .zero)
        customSubview.backgroundColor = underlineColor
        self.indicatorView.addSubview(customSubview)
        customSubview.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(indicatorHeight)
        }
    }
}

extension UIFont {
    enum FontSize: CGFloat {
        case name_20 = 20.0
        case big = 18.0
        case medium = 14.0
        case cellFont = 12.0
        case introducing = 13.0
        case small = 10.0
    }
    
    // Make preferred font bold or italic {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
    // }
    
    static func defaultFont(size: FontSize, bold: Bool = false) -> UIFont {
        UIFont(name: bold ? "Poppins-Bold" : "Poppins-Regular", size: size.rawValue)!
    }
}

extension UIView {
    enum VerticalLocation {
        case bottom
        case top
        case left
        case right
    }

    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 1, radius: CGFloat = 5.0, offset: CGFloat = 2.5) {
        switch location {
        case .bottom:
             addShadow(offset: CGSize(width: 0, height: offset), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -offset), color: color, opacity: opacity, radius: radius)
        case .left:
            addShadow(offset: CGSize(width: -offset, height: 0), color: color, opacity: opacity, radius: radius)
        case .right:
            addShadow(offset: CGSize(width: offset, height: 0), color: color, opacity: opacity, radius: radius)
        }
    }

    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.1, radius: CGFloat = 3.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}

extension UIView {
    // Make Shadow of view
    func setShadow(opacity: Float = 1, color: UIColor = .black, offset: CGSize = CGSize(width: 0, height: 0), radius: CGFloat = 10) {
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
    }
    
    func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = radius > 0
    }
    
    func makeBorder(color: CGColor = UIColor.black.cgColor, width: CGFloat = CGFloat(1.0), cornerRadius: CGFloat = CGFloat(0.0)) {
        self.layer.borderColor = color
        self.layer.borderWidth = width
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = cornerRadius > 0
    }
    
    // 특정 위치만 radius 주기
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func topRoundCorner(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
    }
    
    func bottomRightCorner(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMaxYCorner] // Top right corner, Top left corner respectively
    }
}

extension UIColor {
    static let backgroundGray = UIColor(named: "BackgroundGray")!
    static let mainColor = UIColor(named: "MainColor")!
    static let gray1 = UIColor(named: "Gray1")!
    static let black = UIColor(named: "Black")!
    static let grayC3 = UIColor(named: "GrayC3")!
    static let grayC4 = UIColor(named: "GrayC4")!
    static let grayB0 = UIColor(named: "GrayB0")!
    static let gray7A = UIColor(named: "Gray7A")!
    static let grayD1 = UIColor(named: "GrayD1")!
    static let grayE3 = UIColor(named: "GrayE3")!
    static let lightMainColor = UIColor(named: "LightMainColor")!
    static let pink_E5949D = UIColor(named: "Pink_E5949D")!
}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}

extension UIImage {
    static let writeViewIcon = UIImage(named: "WriteViewIcon")!
    static let myLibraryViewIcon = UIImage(named: "MyLibraryViewIcon")!
    static let bookclubViewIcon = UIImage(named: "BookclubViewIcon")!
    static let sidebarButtonImage = UIImage(named: "SidebarButton")!
    static let updownArrowImage = UIImage(named: "UpDownArrow")!
    static let rightArrowImage = UIImage(named: "RightArrow")!.withRenderingMode(.alwaysTemplate)
    static let leftArrowImage = UIImage(named: "LeftArrow")!
    static let searchImage = UIImage(named: "Search")!
    static let bookclubLevelImage = UIImage(named: "BookClubLevel")!
    static let alertIcon = UIImage(named: "AlertIcon")!.withRenderingMode(.alwaysTemplate)
    static let myLibraryIcon = UIImage(named: "MyLibraryIcon")!.withRenderingMode(.alwaysTemplate)
    static let settingIcon = UIImage(named: "SettingIcon")!.withRenderingMode(.alwaysTemplate)
    static let uploadIcon = UIImage(named: "UploadIcon")!.withRenderingMode(.alwaysTemplate)
    static let cameraIcon = UIImage(named: "CameraIcon")!.withRenderingMode(.alwaysTemplate)
    static let deleteButtonImage = UIImage(named: "DeleteButtonImage")!
}

extension UIButton {
    func setInsets(forContentPadding contentPadding: UIEdgeInsets, imageTitlePadding: CGFloat) {
        self.contentEdgeInsets = UIEdgeInsets(
            top: contentPadding.top,
            left: contentPadding.left + imageTitlePadding,
            bottom: contentPadding.bottom,
            right: contentPadding.left
        )
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageTitlePadding,
            bottom: 0,
            right: imageTitlePadding
        )
    }
    
    func alignTextBelow(spacing: CGFloat = 8.0) {
        guard let image = self.imageView?.image else {
            return
        }
        
        guard let titleLabel = self.titleLabel else {
            return
        }
        
        guard let titleText = titleLabel.text else {
            return
        }
        
        let titleSize = titleText.size(withAttributes: [
            NSAttributedString.Key.font: titleLabel.font as Any
        ])
        
        titleEdgeInsets = UIEdgeInsets(top: spacing, left: -image.size.width, bottom: -image.size.height, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
    }
}
