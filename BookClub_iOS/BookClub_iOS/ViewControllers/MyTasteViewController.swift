//
//  MyTasteViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/08.
//

import UIKit

import RxSwift
import RxCocoa

class MyTasteViewController: UIViewController {

    let customView = MyTasteView()
    
    var disposeBag = DisposeBag()
    
    let items = [["소설", "시", "에세이", "경제/경영"], ["자기계발", "인문학", "역사/문화"], ["종교", "정치/사회", "여행", "만화"], ["사회과학", "역사", "예술/대중문화"], ["과학", "기술/공학", "컴퓨터/IT", "기타"]]
    
    var selectedItems: [String] = [] {
        didSet {
//            viewModel.selectedGenres.onNext(selectedItems)
            print(#fileID, #function, #line, selectedItems)
        }
    }
    
    override func loadView() {
        self.view = customView
        self.navigationController?.navigationBar.setDefault()
        self.removeBackButtonTitle()
        self.title = "당신의 취향"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFont.defaultFont(size: 14, boldLevel: .bold)], for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customView.genreCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        self.customView.genreCollectionView.rx.setDataSource(self).disposed(by: disposeBag)
    }
    
}

extension MyTasteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.3.adjustedHeight
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0.0, height: 8.3.adjustedHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as! GenreCollectionViewCell
        cell.configure(name: items[indexPath.section][indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? GenreCollectionViewCell {
            cell.isSelected = true
            cell.setSelected(true)
            selectedItems.append(cell.titleLabel.text!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? GenreCollectionViewCell {
            cell.isSelected = false
            cell.setSelected(false)
            selectedItems.remove(at: selectedItems.firstIndex(of: cell.titleLabel.text!)!)
        }
    }
}
