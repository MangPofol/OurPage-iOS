//
//  BookclubHomeViewController.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/23.
//

import UIKit

import RxSwift
import RxCocoa

final class BookclubHomeViewController: UIViewController {
    private let customView = BookclubHomeView()
    private let disposeBag = DisposeBag()
    private var viewModel: BookclubHomeViewModel!
    
    override func loadView() {
        self.view = customView
        self.navigationItem.title = "BOOK CLUB"
        self.setNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = BookclubHomeViewModel(
            input: BookclubHomeViewModel.Input(
                createBookclubTapped: self.customView.createBookclubButton.rx.tapGesture().when(.recognized),
                bookclubSettingTapped: self.customView.bookclubSettingButton.rx.tapGesture().when(.recognized)
            )
        )
        
        // TODO: 북클럽 데이터 연결
        
        // bind outputs {
        self.viewModel.output.openBookclubSetting
            .drive { [weak self] in
                if $0, let self = self {
                    self.navigationController?.pushViewController(BookclubSettingViewController(), animated: true)
                }
            }
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.openAddBookclub
            .drive { [weak self] in
                if $0, let self = self {
                    self.navigationController?.pushViewController(BookclubCreateViewController(), animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        self.navigationItem.leftBarButtonItem!.rx.tap
            .bind { [weak self] in
                let transition = CATransition()
                transition.duration = 0.3
                transition.type = CATransitionType.moveIn
                transition.subtype = CATransitionSubtype.fromLeft
                self?.view.window!.layer.add(transition, forKey: kCATransition)
                
                let vc = UINavigationController(rootViewController: SettingViewController())
                vc.modalPresentationStyle = .fullScreen
        
                self?.present(vc, animated: false, completion: nil)
                
            }
            .disposed(by: disposeBag)
        // }
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.setDefault()
        self.navigationController?.navigationBar.setBarShadow()
        self.setDefaultConfiguration()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .updownArrowImage, style: .plain, target: nil, action: nil)
    }
}
