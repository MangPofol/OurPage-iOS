//
//  MyLibraryViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/13.
//

import UIKit
import RxSwift
import RxCocoa
import BetterSegmentedControl
import SideMenu

class MyLibraryViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var viewModel = BookListViewModel()
    
    // custom segment control
    let typeControl = BetterSegmentedControl(frame: .zero)
    let control = BetterSegmentedControl(frame: .zero)
    
    // collectionView
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()

    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // navigation bar button
        self.setNavigationBar()
    
        self.view.addSubview(typeControl)
        self.view.addSubview(control)
        
        // add and configure collection view
        self.collectionView.register(BookListViewCell.self, forCellWithReuseIdentifier: BookListViewCell.identifier)
        self.view.addSubview(self.collectionView)
        self.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        setAutolayouts()
        setSegmentedControls()
        
        // bind inputs
        typeControl.rx.controlEvent(.valueChanged)
            .bind {
                print(self.typeControl.index)
            }
            .disposed(by: disposeBag)
        
        control.rx.controlEvent(.valueChanged)
            .bind {
                print(self.control.index)
            }
            .disposed(by: disposeBag)
        
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
        
        // bind outputs
        viewModel.data
            .bind(to:
                    self.collectionView
                    .rx
                    .items(cellIdentifier: BookListViewCell.identifier, cellType: BookListViewCell.self)) { (row, element, cell) in
                cell.bookImageView.image = UIImage(named: element.image)
                cell.bookTitleLabel.text = element.title
            }.disposed(by: disposeBag)
        
        //                maincollectionView.rx
        //                    .modelSelected(BotMenu.self)
        //                    .subscribe({ (item) in
        //                        print(item.element?.path ?? "")
        //                        let pushVC = PushViewController()
        //                        self.present(pushVC, animated: true, completion: nil)
        //                    }).disposed(by: disposeBag)
        
    }
    
    // MARK: - Private functions
    private func setSegmentedControls() {
        typeControl.segments = LabelSegment.segments(withTitles: ["읽는 중", "완독", "읽고 싶은"],
                                                     normalFont: UIFont.preferredFont(forTextStyle: .title2),
                                                     normalTextColor: .gray,
                                                     selectedFont: UIFont.preferredFont(forTextStyle: .title2).bold(),
                                                     selectedTextColor: .black)
        control.segments = LabelSegment.segments(withTitles: ["나만보기", "북클럽 A", "북클럽 B", "북클럽 C"],
                                                 normalFont: UIFont.preferredFont(forTextStyle: .caption1),
                                                 normalTextColor: .gray,
                                                 selectedFont: UIFont.preferredFont(forTextStyle: .caption1).bold(),
                                                 selectedTextColor: .black)
        typeControl.setCustomSegment(underlineColor: .black, indicatorHeight: 1.5)
        control.setCustomSegment(underlineColor: .black, indicatorHeight: 1.0)
    }
    
    private func setAutolayouts() {
        // autolayout set
        typeControl.snp.makeConstraints {
            $0.top.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(10)
        }
        control.snp.makeConstraints {
            $0.left.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            $0.top.equalTo(typeControl.snp.bottom).offset(10)
        }
        self.collectionView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            $0.top.equalTo(control.snp.bottom).offset(10)
        }
    }
}

extension MyLibraryViewController: UICollectionViewDelegateFlowLayout {
    // 한 가로줄에 cell이 3개만 들어가도록 크기 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let width = collectionView.bounds.width
           let cellWidth = (width - 30) / 3 // compute your cell width
           return CGSize(width: cellWidth, height: cellWidth / 0.6)
       }
}
