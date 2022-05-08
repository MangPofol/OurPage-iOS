//
//  BookclubPostViewController.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/05/05.
//

import UIKit

class BookclubPostViewController: UIViewController {
    private let customView = BookclubPostView()
    
    var post: PostModel? {
        didSet {
            guard let post = self.post else { return }
            self.customView.dateLabel.text = post.modifiedDate.toString(with: "yyyy/MM/dd HH:mm")

        }
    }
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setBarWhite()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customView.commentCollectionView.delegate = self
        self.customView.commentCollectionView.dataSource = self
    }
}

extension BookclubPostViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.post?.commentsDto.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        cell.comment = self.post?.commentsDto[indexPath.item]
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        // Get the view for the first header
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)

        // Use this view to calculate the optimal size based on the collection view's width
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required, // Width is fixed
                                                  verticalFittingPriority: .fittingSizeLevel) // Height can be as large as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BookclubPostHeaderView.identifier, for: indexPath) as! BookclubPostHeaderView
            headerView.post = post
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        
        return CGSize(width: Constants.screenSize.width - 40.0.adjustedHeight, height: 120.0.adjustedHeight)
        
    }
}


