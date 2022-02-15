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
        $0.textColor = .mainColor
    }
    
    var checkMark = UILabel().then {
        $0.font = .defaultFont(size: .small)
        $0.textColor = .mainColor
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
                    self.contentView.backgroundColor = UIColor.mainColor
                    self.titleLabel.textColor = .white
                    self.checkMark.textColor = .white
                }
                else {
                    self.contentView.backgroundColor = UIColor(hexString: "EFF0F3")
                    self.titleLabel.textColor = .mainColor
                    self.checkMark.textColor = .mainColor
                }
            }
        }
}
