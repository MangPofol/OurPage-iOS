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
        self.navigationItem.title = "북클럽 설정"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: 북클럽 데이터 연결
    }
}
