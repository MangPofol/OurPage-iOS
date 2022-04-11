//
//  BookclubDetailViewController.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/04/06.
//

import UIKit

class BookclubDetailViewController: UIViewController {
    private let customView = BookclubDetailView()
    
    override func loadView() {
        self.view = UIScrollView()
        self.view.backgroundColor = .white
        self.view.addSubview(customView)
        self.customView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
}
