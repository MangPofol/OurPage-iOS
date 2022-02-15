//
//  GenreViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/04.
//

import UIKit

import RxSwift
import RxCocoa

class GenreViewController: UIViewController {

    let customView = GenreView()
    
    var disposeBag = DisposeBag()
    
    var viewModel: GenreViewModel!
    
    let items = [["소설", "시", "에세이", "경제/경영"], ["자기계발", "인문학", "역사/문화"], ["종교", "정치/사회", "여행", "만화"], ["사회과학", "역사", "예술/대중문화"], ["과학", "기술/공학", "컴퓨터/IT", "기타"]]
    
    var selectedItems: [String] = [] {
        didSet {
            viewModel.selectedGenres.onNext(selectedItems)
        }
    }
    
    override func loadView() {
        self.view = customView
        self.navigationItem.backButtonTitle = ""
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "건너뛰기", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFont.defaultFont(size: 14, boldLevel: .bold), .foregroundColor: UIColor.mainColor], for: .normal)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customView.genreCollectionView.delegate = self
        self.customView.genreCollectionView.dataSource = self
        
        viewModel = GenreViewModel(nextButtonTapped: self.customView.nextButton.rx.tap)
        
        viewModel.isAbleToProgress
            .withUnretained(self)
            .bind { (owner, isOk) in
                owner.customView.nextInformationLabel.isHidden = !isOk
                if isOk {
                    owner.customView.nextButton.isUserInteractionEnabled = true
                    owner.customView.nextButton.backgroundColor = .mainPink
                    owner.customView.nextButton.setTitleColor(.white, for: .normal)
                } else {
                    owner.customView.nextButton.isUserInteractionEnabled = false
                    owner.customView.nextButton.backgroundColor = .textFieldBackgroundGray
                    owner.customView.nextButton.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.isNextConfirmed
            .bind { [weak self] in
                if $0 {
                    print(SignUpViewModel.creatingUser)
                    self?.navigationController?.pushViewController(ReadingStyleViewController(), animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        self.navigationItem.rightBarButtonItem?
            .rx.tap
            .bind { [weak self] in
                self?.navigationController?.pushViewController(ReadingStyleViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}

extension GenreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0.0, height: 10.0)
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
