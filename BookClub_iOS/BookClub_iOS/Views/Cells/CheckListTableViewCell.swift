//
//  CheckListTableViewCell.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/26.
//

import UIKit

class CheckListTableViewCell: UITableViewCell {
    static let identifier = "CheckListTableViewCell"
    
    var checkButton = UIButton().then {
        $0.setImage(.PlainCheckBoxIcon.resize(to: CGSize(width: 9.48, height: 9.48).resized(basedOn: .height)), for: .normal)
        $0.imageView?.snp.remakeConstraints {
            $0.left.equalToSuperview().inset(5.adjustedHeight)
            $0.centerY.equalToSuperview()
        }
    }
    var titleLabel = UILabel().then {
        $0.font = .defaultFont(size: 12, boldLevel: .light)
        $0.textColor = UIColor(hexString: "646A88")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
