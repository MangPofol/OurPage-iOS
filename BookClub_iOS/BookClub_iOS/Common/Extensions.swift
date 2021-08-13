//
//  Extensions.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/10.
//

import Foundation
import UIKit.UITableView

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

extension UIViewController {
    func setNavigationBar() {
        guard let nav = self.navigationController else {
            return
        }
        nav.navigationBar.barTintColor = Constants.navigationbarColor
        nav.navigationBar.tintColor = .black
        nav.navigationBar.isTranslucent = false

        // bar underline 삭제
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.shadowImage = UIImage()

        let buttonImage = UIImage(systemName: "text.justify")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: buttonImage, style: .plain, target: nil, action: nil)
    }
}

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: self)
    }
}
