//
//  ProfileInformationViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/30.
//

import UIKit
import RxSwift

class ProfileInformationViewController: UIViewController {

    let customView = ProfileInformationView()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customView.rx.tap
            .bind {
                // 다음 페이지로
                print(#fileID, #function, #line, $0)
            }
            .disposed(by: disposeBag)
    }
}
