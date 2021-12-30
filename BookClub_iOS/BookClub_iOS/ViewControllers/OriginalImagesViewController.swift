//
//  OriginalImagesViewController.swift
//  OffOff_iOS
//
//  Created by Lee Nam Jun on 2021/12/11.
//

import UIKit

import RxSwift

final class OriginalImagesViewController: UIViewController {

    let customView = OriginalImagesView()

    var disposeBag = DisposeBag()
    var firstIndex: Int!

    var originalImages: Observable<[String]>!
    
    let pageControl = UIPageControl().then {
        $0.hidesForSinglePage = true
        $0.pageIndicatorTintColor = UIColor(hexString: "303860")
        $0.currentPageIndicatorTintColor = .white
    }
    
    convenience init(originalImages: Observable<[String]>, firstIndex: Int) {
        self.init()
        self.firstIndex = firstIndex
        self.originalImages = originalImages
    }

    override func loadView() {
        self.view = customView
        self.view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(62.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        customView.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        originalImages
            .do { [weak self] in
                self?.pageControl.numberOfPages = $0.count
            }
            .bind(to: customView.collectionView.rx.items(cellIdentifier: OriginalImagesViewCell.identifier, cellType: OriginalImagesViewCell.self)) { (row, element, cell) in
                cell.imageView.kf.setImage(with: URL(string: element))
            }
            .disposed(by: disposeBag)

        customView.closeButton
            .rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)

        customView.collectionView
            .rx.willEndDragging
            .bind { [weak self] (velocity, targetContentOffset) in
                guard let layout = self?.customView.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

                let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing

                let estimatedIndex = (self?.customView.collectionView.contentOffset.x)! / cellWidthIncludingSpacing
                let index: Int
                if velocity.x > 0 {
                    index = Int(ceil(estimatedIndex))
                } else if velocity.x < 0 {
                    index = Int(floor(estimatedIndex))
                } else {
                    index = Int(round(estimatedIndex))
                }
                
                targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing, y: 0)
                
                let page = round(targetContentOffset.pointee.x / (self?.customView.collectionView.frame.width)!)
                self?.pageControl.currentPage = Int(page)
            }
            .disposed(by: disposeBag)

    }

}

extension OriginalImagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return customView.collectionView.frame.size
    }
}
