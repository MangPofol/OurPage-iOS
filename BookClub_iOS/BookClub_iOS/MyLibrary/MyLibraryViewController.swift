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
        
        self.addChild(bookCollectionVC)
        customView.bookCollectionContainer.addSubview(bookCollectionVC.view)
        bookCollectionVC.didMove(toParent: self)
        
        bookCollectionVC.view.backgroundColor = .white
        bookCollectionVC.collectionView.backgroundColor = .white
        bookCollectionVC.view.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        // Left navigation button
        setNavigationBar()
    }
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MyLibraryViewModel(
            input: (
                typeTapped: customView.typeControl.rx.controlEvent(.valueChanged)
                    .withUnretained(self)
                    .map { (owner, _) in
                        switch owner.customView.typeControl.index {
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
                    customView.searchButton.rx.tap.withUnretained(self).map { (owner, _) in
                        !owner.customView.searchButton.isOn ? FilterType.none : FilterType.search },
                    customView.bookclubButton.rx.tap.withUnretained(self).map { (owner, _) in
                        !owner.customView.bookclubButton.isOn ? FilterType.none: FilterType.bookclub },
                    customView.sortingButton.rx.tap.withUnretained(self).map { (owner, _) in
                        !owner.customView.sortingButton.isOn ? FilterType.none : FilterType.sorting }
                ),
                searchText: customView.searchTextField
                    .rx.text
                    .orEmpty
                    .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance)
                    .distinctUntilChanged()
                    .asObservable()
            )
        )
        viewModel?.bookCollectionViewModel = bookCollectionVC.viewModel
        
        // bind inputs {
        
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
        
        // 검색 바 처리/akjdlsfdlsfsdlkfhlsdflsdkfhls
        //        customView.searchBar
        //            .rx.text
        //            .orEmpty
        //            .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance)
        //            .distinctUntilChanged()
        //            .subscribe(onNext: { print($0) })
        //            .disposed(by: disposeBag)
        
        customView.bookclubSelector
            .rx.itemSelected
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        // }
        
        // bind outputs {
        viewModel!.bookListType
            .bind { [weak self] in
                self?.bookCollectionVC.viewModel.category.accept($0)
            }
            .disposed(by: disposeBag)
        
        // 필터 버튼 중 하나라도 상태가 변하는 것에 대응
        let filterButtonsTapped = Observable.combineLatest(self.customView.searchButton.isOnRx, self.customView.bookclubButton.isOnRx, self.customView.sortingButton.isOnRx)
        filterButtonsTapped
            .skip(1)
            .bind { [weak self] in
                guard let self = self else { return }
                let status = $0.0 || $0.1 || $0.2
                
                if $0.0 {
                    self.customView.searchTextField.isHidden = false
                } else if $0.1 {
                    self.customView.bookclubSelector.isHidden = false
                } else if $0.2 {
                    self.customView.sortButtonStack.isHidden = false
                } else {
                    self.customView.searchTextField.isHidden = true
                    self.customView.bookclubSelector.isHidden = true
                    self.customView.sortButtonStack.isHidden = true
                }
                
                self.customView.bookCollectionContainer.snp.updateConstraints {
                    $0.top.equalTo(self.customView.upperView.snp.bottom).offset(status ? 64.adjustedHeight : 20.adjustedHeight)
                }
            }
            .disposed(by: disposeBag)
        
        self.customView.searchButton.isOnRx
            .skip(1)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.setSearchBar($0)
            })
            .disposed(by: disposeBag)
        
        self.customView.bookclubButton.isOnRx
            .skip(1)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.setBookclubSelector($0)
            })
            .disposed(by: disposeBag)
        
        self.customView.sortingButton.isOnRx
            .skip(1)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.setSortButtons($0)
            })
            .disposed(by: disposeBag)
        
        // 필터 방식
        Observable.combineLatest(customView.byNewButton.isOnRx, customView.byOldButton.isOnRx, customView.byNameButton.isOnRx)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if $0.0 {
                    self.viewModel?.sortBy.onNext(SortBy.byNew)
                } else if $0.1 {
                    self.viewModel?.sortBy.onNext(SortBy.byOld)
                } else if $0.2 {
                    self.viewModel?.sortBy.onNext(SortBy.byName)
                } else {
                    self.viewModel?.sortBy.onNext(SortBy.none)
                }
            }).disposed(by: disposeBag)
        
        // cell을 모두 configure 한 후 autolayout 세팅
        customView.makeView()
        
        // 뷰 모델로 부터 소속된 북클럽을 받아와서 북클럽 필터에 표시
        viewModel!.bookclubs
            .do { [weak self] clubs in
                guard let self = self else { return }
                self.customView.bookclubSelector.snp.updateConstraints {
                    $0.width.equalTo((84.adjustedHeight + 8.0) * Double(clubs.count))
                }
            }
            .bind(to: customView.bookclubSelector
                    .rx
                    .items(cellIdentifier: BookclubSelectorCell.identifier, cellType: BookclubSelectorCell.self)) { (row, element, cell) in
                cell.contentView.backgroundColor = .gray1
                cell.titleLabel.text = " \(element)"
                cell.contentView.setCornerRadius(radius: CGFloat(Constants.getAdjustedWidth(3.0)))
            }
                    .disposed(by: disposeBag)
        
        // }
        
        
        // 스크롤시 상단 버튼 숨기기
        bookCollectionVC.collectionView.rx.didScroll
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in
                guard let self = self else { return }
                if self.bookCollectionVC.collectionView.contentOffset.y <= self.customView.upperView.bounds.height {
                    self.customView.upperView.snp.updateConstraints {
                        $0.top.equalToSuperview().offset(-self.bookCollectionVC.collectionView.contentOffset.y)
                    }
                } else {
                    UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                        self.customView.upperView.snp.updateConstraints {
                            $0.top.equalToSuperview().offset(-self.customView.upperView.frame.height)
                        }
                        self.customView.layoutIfNeeded()
                    })
                }
            }
            .disposed(by: disposeBag)
        
        bookCollectionVC.viewModel.tappedBook
            .bind { [weak self] in
                let vc = BookViewController(book: $0.bookModel)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
    }
    
    // private funcs
    func setSearchBar(_ isOn: Bool) {
        self.customView.searchTextField.isHidden = !isOn
        self.customView.searchTextField.text = nil
    }
    
    func setBookclubSelector(_ isOn: Bool) {
        self.customView.bookclubSelector.reloadData()
        self.customView.bookclubSelector.isHidden = !isOn
        self.customView.searchTextField.text = nil
    }
    
    func setSortButtons(_ isOn: Bool) {
        self.customView.sortButtonStack.isHidden = !isOn
        self.customView.byNewButton.isOn = false
        self.customView.byOldButton.isOn = false
        self.customView.byNameButton.isOn = false
        self.viewModel!.sortBy.onNext(.none)
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.setDefault()
        self.setDefaultConfiguration()
    }
}

extension MyLibraryViewController: UICollectionViewDelegateFlowLayout {
    // 한 가로줄에 cell이 3개만 들어가도록 크기 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.bookclubSelectorSize()
    }
}
