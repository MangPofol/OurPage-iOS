//
//  BookclubSelectorCell.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/21.
//

import UIKit

class BookclubSelectorCell: UICollectionViewCell {
    static let identifier = "BookclubSelectorCell"
    
    var titleLabel = UILabel().then {
        $0.font = .defaultFont(size: .small)
        $0.textColor = .black
    }
    
    var checkMark = UILabel().then {
        $0.font = .defaultFont(size: .small)
        $0.textColor = .black
        $0.text = "✓ "
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(checkMark)
        titleLabel.snp.makeConstraints { $0.edges.equalToSuperview() }
        checkMark.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
            didSet {
                if self.isSelected {
                    backgroundColor = UIColor.mainColor
                    self.titleLabel.textColor = .white
                    self.checkMark.textColor = .white
                }
                else {
                    backgroundColor = UIColor.gray1
                    self.titleLabel.textColor = .black
                    self.checkMark.textColor = .black
                }
            }
        }
}
