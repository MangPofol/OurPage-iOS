//
//  OriginalImagesView.swift
//  OffOff_iOS
//
//  Created by Lee Nam Jun on 2021/12/11.
//

import UIKit

final class OriginalImagesView: UIView {
    
    let flowLayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
        $0.scrollDirection = .horizontal
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
        $0.register(OriginalImagesViewCell.self, forCellWithReuseIdentifier: OriginalImagesViewCell.identifier)
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .black
    }
    
    var closeButton = UIButton().then {
        $0.setImage(.XIcon.resize(to: CGSize(width: 15, height: 15).resized(basedOn: .height)), for: .normal)
        $0.imageView?.tintColor = .white
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.addSubview(collectionView)
        self.addSubview(closeButton)
        makeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
        collectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(27.adjustedWidth)
        }
        
        closeButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(21.adjustedWidth)
            $0.top.equalToSuperview().inset(65.adjustedHeight)
        }
    }
}

final class OriginalImagesViewCell: UICollectionViewCell {
    static let identifier = "OriginalImagesViewCell"
    
    var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.kf.indicatorType = .activity
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        self.contentView.backgroundColor = .black
        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
