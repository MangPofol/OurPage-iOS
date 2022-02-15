//
//  BookclubViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/26.
//

import UIKit
import RxSwift
import RxCocoa
import SideMenu

class BookclubViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let customView = BookclubView()
    var viewModel: BookclubViewModel!
    
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
        
        customView.hotContainer.addSubview(hotViewController.view)
        hotViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        customView.memberProfileCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        // viewModel
        viewModel = BookclubViewModel(
            filterTapped: Observable.merge(
                customView.searchButton.rx.tap.withUnretained(self).map { (owner, _) in
                    !owner.customView.searchButton.isOn ? FilterTypeInBookclub.none : FilterTypeInBookclub.search },
                customView.clubMemberButton.rx.tap.withUnretained(self).map { (owner, _) in
                    !owner.customView.clubMemberButton.isOn ? FilterTypeInBookclub.none: FilterTypeInBookclub.member },
                customView.sortingButton.rx.tap.withUnretained(self).map { (owner, _) in
                    !owner.customView.sortingButton.isOn ? FilterTypeInBookclub.none : FilterTypeInBookclub.sorting }),
            searchText: customView.searchBar
                .rx.text
                .orEmpty
                .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance)
                .distinctUntilChanged()
                .asObservable()
        )
        viewModel.bookCollectionViewModel = self.bookCollectionVC.viewModel
        
        self.navigationItem.leftBarButtonItem!
            .rx.tap
            .bind { [weak self] in
                let menu = SideMenuNavigationController(rootViewController: SideMenuViewController())
                menu.leftSide = true
                menu.presentationStyle = .menuSlideIn
                menu.menuWidth = Constants.screenSize.width * 0.85
                self?.present(menu, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(self.customView.byNewButton.isOnRx, self.customView.byOldButton.isOnRx, self.customView.byNameButton.isOnRx)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                print($0)
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
    
        // Book collection 스크롤 대응
        bookCollectionVC.collectionView.rx.didScroll
            .withUnretained(self)
            .bind { (owner, _) in
                if owner.bookCollectionVC.collectionView.contentOffset.y <= owner.customView.lowerView.bounds.height {
                    owner.customView.lowerView.snp.updateConstraints {
                        $0.top.equalTo(owner.customView.upperView.snp.bottom).offset(-owner.bookCollectionVC.collectionView.contentOffset.y - 20)
                    }
                } else {
                    owner.customView.lowerView.snp.updateConstraints {
                        $0.top.equalTo(owner.customView.upperView.snp.bottom).offset(-owner.customView.lowerView.bounds.height - 20)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        // bind outputs {
        viewModel.profiles
            .do { [weak self] in
                let count = CGFloat($0.count)
                self?.customView.memberProfileCollectionView.snp.updateConstraints {
                    $0.width.equalTo(Constants.profileImageSize().width * (count * 0.8) + (Constants.profileImageSize().width / 5.0))
                }
            }
            .bind(to: customView.memberProfileCollectionView
                    .rx
                    .items(cellIdentifier: MemberProfileCollectionViewCell.identifier, cellType: MemberProfileCollectionViewCell.self)) { (row, element, cell) in
                cell.profileImageView.image = .DefaultProfileImage
            }
                    .disposed(by: disposeBag)
        
        let filterButtonsTapped = Observable.combineLatest(self.customView.searchButton.isOnRx, self.customView.clubMemberButton.isOnRx, self.customView.sortingButton.isOnRx)
        filterButtonsTapped
            .skip(1)
            .bind { [weak self] in
                guard let self = self else { return }
                let status = $0.0 || $0.1 || $0.2
                self.customView.selectedControl.snp.updateConstraints { $0.height.equalTo(status ? Constants.getAdjustedHeight(26.0) : 0) }
                
                self.customView.searchBar.isHidden = !$0.0
                self.customView.clubMemeberSelector.isHidden = !$0.1
                self.customView.sortButtonStack.isHidden = !$0.2
            }
            .disposed(by: disposeBag)
        
        // }
        
        customView.makeView()
    }
    
    func setNavigationBar() {
        self.setDefaultConfiguration()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .updownArrowImage, style: .plain, target: nil, action: nil)
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
