//
//  BookclubSettingViewController.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/29.
//

import UIKit

class BookclubSettingViewController: UIViewController {
    private let customView = BookclubSettingView()
    
    override func loadView() {
        self.view = customView
        self.setNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: 북클럽 데이터 연결
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "북클럽 설정"
        self.navigationController?.navigationBar.setDefault()
        self.navigationController?.navigationBar.setBarShadow()
        self.setDefaultConfiguration()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .updownArrowImage, style: .plain, target: nil, action: nil)
    }
}
