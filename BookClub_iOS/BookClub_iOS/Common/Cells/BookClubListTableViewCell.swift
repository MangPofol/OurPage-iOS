//
//  BookClubListTableViewCell.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/10.
//

import UIKit
import RxSwift

class BookClubListTableViewCell: UITableViewCell {

    static let identifier = "BookClubListTableViewCell"
    let disposeBag = DisposeBag()
    
    var titleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        $0.adjustsFontForContentSizeCategory = true
        $0.backgroundColor = .backgroundGray
        $0.setShadow(opacity: 1, color: .lightGray, offset: CGSize(width: 0, height: 3), radius: 1)
    }
    
    var exitButton = UIButton().then {
        $0.setTitle("삭제", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        $0.titleLabel?.adjustsFontForContentSizeCategory = true
        $0.backgroundColor = .backgroundGray
        $0.setShadow(opacity: 1, color: .lightGray, offset: CGSize(width: 0, height: 3), radius: 1)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(exitButton)
        self.contentView.backgroundColor = .white
        titleLabel.snp.makeConstraints {
            $0.left.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(5)
            $0.right.equalTo(exitButton.snp.left).offset(-5)
        }
        exitButton.snp.makeConstraints { [unowned self] in
            $0.right.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(5)
            $0.width.equalTo(self.contentView.bounds.width / 7.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .black
        
//        self.accessoryView = UIButton().then {
//            $0.setTitle("삭제", for: .normal)
//            $0.setTitleColor(.black, for: .normal)
//            $0.backgroundColor = .red
//        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
