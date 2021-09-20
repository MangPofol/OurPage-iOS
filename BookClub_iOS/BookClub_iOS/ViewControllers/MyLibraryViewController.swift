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
    var bookCollectionVC = BookCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - loadView()
    override func loadView() {
        // add and configure collection view
//        customView.collectionView.register(BookListViewCell.self, forCellWithReuseIdentifier: BookListViewCell.identifier)
        customView.bookclubSelector.register(BookclubSelectorCell.self, forCellWithReuseIdentifier: BookclubSelectorCell.identifier)
        customView.bookclubSelector.rx.setDelegate(self).disposed(by: disposeBag)
        self.view = customView
        customView.bookCollectionContainer.addSubview(bookCollectionVC.view)
        bookCollectionVC.view.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MyLibraryViewModel(
            input: (
                typeTapped: customView.typeControl.rx.controlEvent(.valueChanged)
                    .map {
                        switch self.customView.typeControl.index {
                        case 0:
                            return BookListType.NOW
                        case 1:
                            return BookListType.AFTER
                        case 2:
                            return BookListType.BEFORE
                        default:
                            return BookListType.NOW
                        }
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
        
        // Left navigation button
        setNavigationBar()
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
        
        // 검색 바 처리
        customView.searchBar
            .rx.text
            .orEmpty
            .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        customView.bookclubSelector
            .rx.itemSelected
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)

        // }
        
        // bind outputs {
        viewModel!.bookListType
            .bind {
                self.bookCollectionVC.viewModel.category.onNext($0)
                print($0)
            }
            .disposed(by: disposeBag)
        
        // 필터 버튼 중 하나라도 상태가 변하는 것에 대응
        let filterButtonsTapped = Observable.combineLatest(self.customView.searchButton.isOnRx, self.customView.bookclubButton.isOnRx, self.customView.sortingButton.isOnRx)
        filterButtonsTapped
            .skip(1)
            .bind {
                let status = $0.0 || $0.1 || $0.2
                self.customView.selectedControl.snp.updateConstraints { $0.height.equalTo(status ? Constants.selectedControlHeight : 0) }
            }
            .disposed(by: disposeBag)
        
        self.customView.searchButton.isOnRx
            .skip(1)
            .subscribe(onNext: {
                setSearchBar($0)
            })
            .disposed(by: disposeBag)
        
        self.customView.bookclubButton.isOnRx
            .skip(1)
            .subscribe(onNext: {
                setBookclubSelector($0)
            })
            .disposed(by: disposeBag)
        
        self.customView.sortingButton.isOnRx
            .skip(1)
            .subscribe(onNext: {
                setSortButtons($0)
            })
            .disposed(by: disposeBag)

        // 필터 방식
        self.customView.byNewButton.isOnRx
            .skip(1)
            .subscribe(onNext: {
                if $0 { self.viewModel?.filterBy.onNext(FilterBy.byNew) }
            })
            .disposed(by: disposeBag)
        self.customView.byOldButton.isOnRx
            .skip(1)
            .subscribe(onNext: {
                if $0 { self.viewModel?.filterBy.onNext(FilterBy.byOld) }
            })
            .disposed(by: disposeBag)
        self.customView.byNameButton.isOnRx
            .skip(1)
            .subscribe(onNext: {
                if $0 { self.viewModel?.filterBy.onNext(FilterBy.byName) }
            })
            .disposed(by: disposeBag)
        
        // 뷰 모델로 부터 소속된 북클럽을 받아와서 북클럽 필터에 표시
        viewModel!.bookclubs
            .bind(to: self.customView.bookclubSelector
                    .rx
                    .items(cellIdentifier: BookclubSelectorCell.identifier, cellType: BookclubSelectorCell.self)) { (row, element, cell) in
                cell.contentView.backgroundColor = .gray1
                cell.titleLabel.text = " \(element)"
                cell.contentView.setCornerRadius(radius: CGFloat(Constants.getAdjustedWidth(3.0)))
            }
            .disposed(by: disposeBag)
        
        // cell을 모두 configure 한 후 autolayout 세팅
        customView.makeView()
        
        // }
        
        
        // 스크롤시 상단 버튼 숨기기
        bookCollectionVC.collectionView.rx.didScroll
            .observeOn(MainScheduler.asyncInstance)
            .bind {
                if self.bookCollectionVC.collectionView.contentOffset.y <= self.customView.typeControl.bounds.height {
                    self.customView.typeControl.snp.updateConstraints {
                        $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(-self.bookCollectionVC.collectionView.contentOffset.y)
                    }
                } else {
                    UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                        self.customView.typeControl.snp.updateConstraints {
                            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(-upperSize())
                        }
                        self.customView.layoutIfNeeded()
                    })
                }
            }
            .disposed(by: disposeBag)
        
        // private funcs
        func upperSize() -> Double {
            return Double(self.customView.typeControl.bounds.height + self.customView.buttonStack.bounds.height + self.customView.selectedControl.bounds.height + CGFloat(Constants.getAdjustedHeight(23.0) + Constants.getAdjustedHeight(14.0) + Constants.getAdjustedHeight(23.0)))
        }
        
        func setSearchBar(_ isOn: Bool) {
            self.customView.searchBar.isHidden = !isOn
            self.customView.searchBar.text = nil
        }
        
        func setBookclubSelector(_ isOn: Bool) {
            self.customView.bookclubSelector.reloadData()
            self.customView.bookclubSelector.isHidden = !isOn
            self.customView.searchBar.text = nil
        }
        
        func setSortButtons(_ isOn: Bool) {
            self.customView.sortButtonStack.isHidden = !isOn
            self.customView.byNewButton.isOn = false
            self.customView.byOldButton.isOn = false
            self.customView.byNameButton.isOn = false
            self.viewModel!.filterBy.onNext(.none)
        }
        
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

            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: .sidebarButtonImage, style: .plain, target: nil, action: nil)
        }
    }
}

extension MyLibraryViewController: UICollectionViewDelegateFlowLayout {
    // 한 가로줄에 cell이 3개만 들어가도록 크기 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return Constants.bookclubSelectorSize()
    }
}
