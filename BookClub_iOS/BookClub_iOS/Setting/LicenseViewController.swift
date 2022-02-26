//
//  LicenseViewController.swift
//  BookClub_iOS
//
//  Created by 이남준_개인 on 2022/02/27.
//

import UIKit
import Carte

final class LicenseViewController: CarteViewController {
    convenience override init(style: UITableView.Style) {
        self.init(style: style)
        self.navigationController?.navigationItem.leftBarButtonItem = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "오픈소스 라이선스"
        self.removeBackButtonTitle()
    }
}
