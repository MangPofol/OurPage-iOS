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
    
    var bookclubs: [Club?] = [] {
        didSet {
            self.customView.bookclubCollectionView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = customView
        self.navigationItem.title = "CLUB LIST"
        self.setNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customView.bookclubCollectionView.delegate = self
        self.customView.bookclubCollectionView.dataSource = self
        
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
        
        self.viewModel.output.bookclub
            .drive { [weak self] in
                self?.bookclubs = $0
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setBarWhite()
        self.navigationController?.navigationBar.setBarShadow()
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.setBarShadow()
        self.setDefaultConfiguration()
        let backBarButtonItem = UIBarButtonItem(title: "CLUB LIST", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white
        backBarButtonItem.setTitleTextAttributes([.font: UIFont.defaultFont(size: 10.0, boldLevel: .bold)], for: .normal)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .updownArrowImage, style: .plain, target: nil, action: nil)
    }
}

extension BookclubHomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return self.bookclubs.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.section == 1 else { return UICollectionViewCell() }
        
        if self.bookclubs[indexPath.item] == nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookclubHomeEmptyCell.identifier, for: IndexPath(item: indexPath.item, section: 0)) as! BookclubHomeEmptyCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookclubHomeCollectionViewCell.identifier, for: IndexPath(item: indexPath.item, section: 0)) as! BookclubHomeCollectionViewCell
            cell.bookclub = self.bookclubs[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10.adjustedHeight, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? BookclubHomeCollectionViewCell {
            LoadingHUD.show()
            let vc = BookclubDetailViewController(bookclub: cell.bookclub!)
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}
