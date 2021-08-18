//
//  MyLibraryViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/13.
//

import UIKit
import RxSwift
import RxCocoa
import SideMenu
import SnapKit

class MyLibraryViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var viewModel: MyLibraryViewModel?
    lazy var customView = MyLibraryView()
    
    // MARK: - loadView()
    override func loadView() {
        // add and configure collection view
        customView.collectionView.register(BookListViewCell.self, forCellWithReuseIdentifier: BookListViewCell.identifier)
        customView.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
//        customView.makeView()
        self.view = customView
    }
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MyLibraryViewModel(
            input: (
                typeTapped: customView.typeControl.rx.controlEvent(.valueChanged)
                    .map {
                        BookListType(rawValue: self.customView.typeControl.index)!
                    },
                filterTapped: Observable.merge(
                    customView.searchButton.rx.tap.map { _ in
                        !self.customView.searchButton.isOn ? FilterType.none : FilterType.search },
                    customView.bookclubButton.rx.tap.map { _ in
                        !self.customView.bookclubButton.isOn ? FilterType.none: FilterType.bookclub },
                    customView.sortingButton.rx.tap.map { _ in
                        !self.customView.sortingButton.isOn ? FilterType.none : FilterType.sorting }
                )
            )
        )
        self.view.backgroundColor = .white
        self.title = "내 서재"
        
        // navigation bar configure
        self.setNavigationBar()
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.defaultFont(size: .big, bold: true)]
        
        // bind inputs {
        
        self.navigationItem.leftBarButtonItem!
            .rx.tap
            .bind {
                let menu = SideMenuNavigationController(rootViewController: SideMenuViewController())
                menu.leftSide = true
                menu.presentationStyle = .menuSlideIn
                menu.menuWidth = Constants.screenSize.width * 0.85
                self.present(menu, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        // }
        
        // 스크롤시 상단 버튼 숨기기
//        customView.collectionView.rx.didScroll
//            .bind {
//                if self.customView.collectionView.contentOffset.y <= self.customView.controlStack.bounds.height {
//                    self.customView.controlStack.snp.updateConstraints {
//                        $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(-self.customView.collectionView.contentOffset.y)
//                    }
//                } else {
//                    self.customView.controlStack.snp.updateConstraints {
//                        $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(-self.customView.controlStack.bounds.height)
//                    }
//                }
//            }
//            .disposed(by: disposeBag)
        
        // bind outputs {
        viewModel!.data
            .bind(to:
                    self.customView.collectionView
                    .rx
                    .items(cellIdentifier: BookListViewCell.identifier, cellType: BookListViewCell.self)) { (row, element, cell) in
                cell.bookImageView.image = UIImage(named: element.image)
                cell.bookTitleLabel.text = element.title
            }.disposed(by: disposeBag)
        
        viewModel!.bookListType
            .bind {
                print($0)
            }
            .disposed(by: disposeBag)
        
        viewModel!.filterType
            .bind {
                self.customView.bookclubButton.isOn = false
                self.customView.searchButton.isOn = false
                self.customView.sortingButton.isOn = false
                
                switch $0 {
                case .none:
                    break
                case .bookclub:
                    self.customView.bookclubButton.isOn = true
                case .search:
                    self.customView.searchButton.isOn = true
                case .sorting:
                    self.customView.sortingButton.isOn = true
                }
            }
            .disposed(by: disposeBag)
        
        // cell을 모두 configure 한 후 autolayout 세팅
        customView.makeView()
        
        //                maincollectionView.rx
        //                    .modelSelected(BotMenu.self)
        //                    .subscribe({ (item) in
        //                        print(item.element?.path ?? "")
        //                        let pushVC = PushViewController()
        //                        self.present(pushVC, animated: true, completion: nil)
        //                    }).disposed(by: disposeBag)
        
        // }
    }
}

extension MyLibraryViewController: UICollectionViewDelegateFlowLayout {
    // 한 가로줄에 cell이 3개만 들어가도록 크기 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Constants.screenSize.width * 0.9
        let cellWidth = (width - 30) / 3 // compute your cell width
        return CGSize(width: cellWidth, height: cellWidth / 0.6)
    }
}
