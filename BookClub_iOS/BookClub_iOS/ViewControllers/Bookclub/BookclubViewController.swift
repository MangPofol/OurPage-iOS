//
//  BookclubViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/26.
//

import UIKit
import RxSwift
import RxCocoa

class BookclubViewController: UIViewController {

    let disposeBag = DisposeBag()
    let customView = BookclubView()
    let viewModel = BookclubViewModel()
    
    let hotViewController = HotContainerController()
    var bookCollectionVC = BookCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override func loadView() {
        self.view = customView
        setNavigationBar()
        customView.bookCollectionContainer.addSubview(bookCollectionVC.view)
        bookCollectionVC.view.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.memberProfileCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.profiles
            .bind(to: customView.memberProfileCollectionView
                    .rx
                    .items(cellIdentifier: MemberProfileCollectionViewCell.identifier, cellType: MemberProfileCollectionViewCell.self)) { (row, element, cell) in
                print(row, element)
                cell.profileImageView.image = UIImage(named: "SampleProfile")
            }
            .disposed(by: disposeBag)
        
        
        customView.hotContainer.addSubview(hotViewController.view)
        hotViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        customView.makeView()
    }
    
    func setNavigationBar() {
        guard let nav = self.navigationController else {
            return
        }
        self.title = "북클럽 A"
        nav.navigationBar.barTintColor = .mainColor
        nav.navigationBar.tintColor = .white
        nav.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.defaultFont(size: .big, bold: true), .foregroundColor: UIColor.white]

        // bar underline 삭제
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.shadowImage = UIImage()

        let buttonImage = UIImage(systemName: "text.justify")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: buttonImage, style: .plain, target: nil, action: nil)
    }
}

extension BookclubViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.profileImageSize()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
}
