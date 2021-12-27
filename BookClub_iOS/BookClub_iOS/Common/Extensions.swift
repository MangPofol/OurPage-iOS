//
//  Extensions.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/10.
//

import Foundation
import UIKit.UITableView
import BetterSegmentedControl
import UIKit
import CryptoKit

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

extension String {
    func toSHA256() -> String {
        let original = self.data(using: .utf8)!
        let sha256 = SHA256.hash(data: original)
        return sha256.compactMap {
            String(format: "%02x", $0)
        }.joined()
    }
    
    subscript(_ range: Range<Int>) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: range.startIndex)
        let toIndex = self.index(self.startIndex,offsetBy: range.endIndex)
        return String(self[fromIndex..<toIndex])
    }
    
}

extension Date {
    func toEnglishMonthDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd"
//        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self)
    }
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: self)
    }
    
    static func date(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, seconds: Int = 0) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: "\(year)-\(month)-\(day) \(hour):\(minute):\(seconds)")
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
    enum FontSize: Double {
        case name_20 = 20.0
        case big = 18.0
        case medium = 14.0
        case cellFont = 12.0
        case introducing = 13.0
        case small = 10.0
    }
    
    enum BoldLevel: String {
        case black = "Black"
        case extraBold = "ExtraBold"
        case bold = "Bold"
        case semiBold = "SemiBold"
        case medium = "Medium"
        case regular = "Regular"
        case light = "Light"
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
        UIFont(name: bold ? "Poppins-Bold" : "Poppins-Regular", size: size.rawValue.adjustedHeight)!
    }
    
    static func defaultFont(size: Double, boldLevel: BoldLevel = .regular) -> UIFont {
        UIFont(name: "Poppins-\(boldLevel.rawValue)", size: size.adjustedHeight)!
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
    
    func removeShadow() {
        self.layer.shadowOffset = CGSize(width: 0 , height: 0)
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 0.0
        self.layer.shadowRadius = 0.0
        self.layer.shadowOpacity = 0.0
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
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
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
    
    func bottomRoundCorner(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func bottomRightCorner(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMaxYCorner] // Top right corner, Top left corner respectively
    }
    
    // button tap animation
    func showAnimation(_ completionBlock: @escaping (() -> Void)) {
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)}) { (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
}

extension UIColor {
    static let backgroundGray = UIColor(named: "BackgroundGray")!
    static let mainColor = UIColor(named: "MainColor")!
    static let mainPink =  UIColor(hexString: "E5949D")
    static let gray1 = UIColor(named: "Gray1")!
//    static let black = UIColor(named: "Black")!
    static let grayC3 = UIColor(named: "GrayC3")!
    static let grayC4 = UIColor(named: "GrayC4")!
    static let grayB0 = UIColor(named: "GrayB0")!
    static let gray7A = UIColor(named: "Gray7A")!
    static let grayD1 = UIColor(named: "GrayD1")!
    static let grayE3 = UIColor(named: "GrayE3")!
    static let lightMainColor = UIColor(named: "LightMainColor")!
    static let pink_E5949D = UIColor(named: "Pink_E5949D")!
    static let textFieldBackgroundGray = UIColor(hexString: "EFF0F3")
    
    // Hex to color
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
            
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
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
    static let updownArrowImage = UIImage(named: "UpDownArrow")!
    static let rightArrowImage = UIImage(named: "RightArrow")!.withRenderingMode(.alwaysTemplate)
    static let leftArrowImage = UIImage(named: "LeftArrow")!
    static let SearchIconRegular = UIImage(named: "SearchIconRegular")!.withRenderingMode(.alwaysTemplate)
    static let bookclubLevelImage = UIImage(named: "BookClubLevel")!
    static let alertIcon = UIImage(named: "AlertIcon")!.withRenderingMode(.alwaysTemplate)
    static let settingIcon = UIImage(named: "SettingIcon")!.withRenderingMode(.alwaysTemplate)
    static let uploadIcon = UIImage(named: "UploadIcon")!.withRenderingMode(.alwaysTemplate)
    static let cameraIcon = UIImage(named: "CameraIcon")!.withRenderingMode(.alwaysTemplate)
    static let deleteButtonImage = UIImage(named: "DeleteButtonIcon")!
    static let mainLogo = UIImage(named: "MainLogo")!
    static let backbuttonImage = UIImage(named: "backbuttonImage")!
    
    // Icons
    static let PersonIcon = UIImage(named: "PersonIcon")!.withRenderingMode(.alwaysTemplate)
    static let MyLibraryIcon = UIImage(named: "MyLibraryIcon")!.withRenderingMode(.alwaysTemplate)
    static let SidebarButtonImage = UIImage(named: "SideMenuIcon")!
    static let BookclubIcon = UIImage(named: "BookclubIcon")!
    static let RightArrowBoldIcon = UIImage(named: "RightArrowBoldIcon")!
    static let RightArrowWithLeftPadding = UIImage(named: "RightArrowWithLeftPadding")!
    static let RightArrowButtonImage = UIImage(named: "RightArrowButtonImage")!
    static let DownArrow = UIImage(named: "DownArrow")!
    static let WriteIcon = UIImage(named: "WriteViewIcon")!.withRenderingMode(.alwaysTemplate)
    static let SettingIconWithBackground = UIImage(named: "SettingIconWithBackground")!
    static let UpArrow = UIImage(named: "UpArrow")!
    static let XIcon = UIImage(named: "XIcon")!
    static let LinkIcon = UIImage(named: "LinkIcon")!
    static let ClockIcon = UIImage(named: "ClockIcon")!
    static let PlaceIcon = UIImage(named: "PlaceIcon")!
    static let PlainCheckBoxIcon = UIImage(named: "PlainCheckBoxIcon")!
    static let AddIcon = UIImage(named: "AddIcon")!
    static let CheckedCheckBoxIcon = UIImage(named: "CheckedCheckBoxIcon")!
    static let MemoIcon = UIImage(named: "MemoIcon")!
    
    // Images
    static let HomeBackgroundImage = UIImage(named: "HomeBackgroundImage")!
    static let BookLoadingImage = UIImage(named: "BookLoadingImage")!
    static let BackgroundLogoImage = UIImage(named: "BackgroundLogoImage")!
    static let DefaultProfileImage = UIImage(named: "DefaultProfileImage")!
    static let DefaultBookImage = UIImage(named: "DefaultBookImage")!
    
    func resize(to size: CGSize, isAlwaysTemplate: Bool = true) -> UIImage {
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { [weak self] context in
            self?.draw(in: CGRect(origin: .zero, size: size))
        }
        
        if isAlwaysTemplate {
            return renderImage.withRenderingMode(.alwaysTemplate)
        } else {
            return renderImage
        }
    }
}

extension CGSize {
    static var baseSize: CGSize {
        return CGSize(width: 375.0, height: 812.0)
    }
    
    func resized(basedOn dimension: Dimension) -> CGSize {
        let screenWidth  = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        var ratio:  CGFloat = 0.0
        var width:  CGFloat = 0.0
        var height: CGFloat = 0.0
        
        switch dimension {
        case .width:
            ratio  = self.height / self.width
            width  = screenWidth * (self.width / CGSize.baseSize.width)
            height = width * ratio
        case .height:
            ratio  = self.width / self.height
            height = screenHeight * (self.height / CGSize.baseSize.height)
            width  = height * ratio
        }
        
        return CGSize(width: width, height: height)
    }
}

enum Dimension {
    case width
    case height
}

extension Double {
    var adjustedWidth: Double {
        (Double(Constants.screenSize.width) * self) / 375.0
    }
    
    var adjustedHeight: Double {
        (Double(Constants.screenSize.height) * self) / 812.0
    }
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
    
    // Animation
    func animateButton(duration: Double = 0.1, scale: Double = 0.9) {
        self.isUserInteractionEnabled = false
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
            self?.transform = CGAffineTransform.init(scaleX: scale, y: scale)}) { (done) in
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] _ in
                self?.isUserInteractionEnabled = true
            }
        }
    }
}

extension UINavigationBar {
    func setDefault() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.mainColor, .font: UIFont.defaultFont(size: 18, boldLevel: .extraBold)]
        appearance.shadowColor = nil
        appearance.setBackIndicatorImage(.leftArrowImage.resize(to: CGSize(width: 6.34, height: 11).resized(basedOn: .height)), transitionMaskImage: .leftArrowImage.resize(to: CGSize(width: 6.34, height: 11).resized(basedOn: .height)))
        
        self.isTranslucent = false
        self.tintColor = .mainColor
        self.standardAppearance = appearance
        self.scrollEdgeAppearance = appearance
        self.compactAppearance = appearance
        if #available(iOS 15.0, *) {
            self.compactScrollEdgeAppearance = appearance
        }
        self.layoutIfNeeded()
        
    }
    
    func setBarShadow() {
        self.addShadow(location: .bottom, color: .lightGray)
    }
    
    func removeBarShadow() {
        self.removeShadow()
    }
}

extension UIViewController {
    func setDefaultConfiguration() {
        guard let nav = self.navigationController else {
            return
        }
        // bar underline 삭제
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.shadowImage = nil
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: .SidebarButtonImage.resize(to: CGSize(width: 15.21, height: 16.05).resized(basedOn: .height)), style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        
        // 백 버튼 텍스트 지우기
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .mainColor
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func removeBackButtonTitle() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .mainColor
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
}

extension UITextField {
    func addLeftPadding(value: Double) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        print(#fileID, #function, #line, "")
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 75.adjustedHeight // 원하는 길이
        return sizeThatFits
    }
}

extension UIView {
    private static let kRotationAnimationKey = "rotationanimationkey"
    
    func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func rotateWithoutAnimation(degree: Double) {
        self.transform = CGAffineTransform(rotationAngle: CGFloat(degree))
    }
    
    func rotateBack() {
        self.transform = CGAffineTransform.identity
    }
    
    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func isRotating() -> Bool {
        return layer.animation(forKey: UIView.kRotationAnimationKey) != nil
    }
    
    static func iconWithPaddingView(iconImage: UIImage, tintColor: UIColor, paddingDirection: PaddingDirectionType, padding: Double, iconSize: CGSize) -> UIView {
        var view = UIView()
        var imageView = UIImageView()
        
        switch paddingDirection {
        case .Left, .Right:
            view = UIView(frame: CGRect(x: 0, y: 0, width: iconSize.width + padding, height: iconSize.height))
        case .Up, .Down:
            view = UIView(frame: CGRect(x: 0, y: 0, width: iconSize.width, height: iconSize.height + padding))
        }
        
        switch paddingDirection {
        case .Left:
            imageView = UIImageView(frame: CGRect(x: padding, y: 0, width: iconSize.width, height: iconSize.height))
        case .Right:
            imageView = UIImageView(frame: CGRect(x: -padding, y: 0, width: iconSize.width, height: iconSize.height))
        case .Up:
            imageView = UIImageView(frame: CGRect(x: 0, y: padding, width: iconSize.width, height: iconSize.height))
        case .Down:
            imageView = UIImageView(frame: CGRect(x: 0, y: -padding, width: iconSize.width, height: iconSize.height))
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = tintColor
        imageView.image = iconImage
        view.addSubview(imageView)
        return view
    }
}

enum PaddingDirectionType {
    case Left
    case Right
    case Up
    case Down
}
