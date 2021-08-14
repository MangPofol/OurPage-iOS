//
//  AlertTableViewCell.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/10.
//

import UIKit

class AlertTableViewCell: UITableViewCell {
    
    static let identifier = "AlertTableViewCell"
    
    var titleLabel = UILabel().then {
        $0.text = "알림 제목"
        $0.font = UIFont.preferredFont(forTextStyle: .callout)
        $0.adjustsFontSizeToFitWidth = true
    }
    var contentLabel = UILabel().then {
        $0.text = "AA님께서 ‘7년의 밤’ 기록물에 댓글을 남기셨습니다."
        $0.font = UIFont.preferredFont(forTextStyle:  .callout)
        $0.adjustsFontSizeToFitWidth = true
    }
    var commentLabel = UILabel().then {
        $0.text = "> 저도 그렇게 생각했어요. 역시 작가님은 천재~"
        $0.textColor = .gray
        $0.font = UIFont.preferredFont(forTextStyle:  .callout)
        $0.adjustsFontSizeToFitWidth = true
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, contentLabel, commentLabel]).then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 1.5
        $0.backgroundColor = .backgroundGray
        $0.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        $0.isLayoutMarginsRelativeArrangement = true
        $0.setShadow(opacity: 1, color: .lightGray, offset: CGSize(width: 0, height: 3), radius: 1)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(stackView)
        self.contentView.backgroundColor = .white
        stackView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.top.equalToSuperview().inset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
