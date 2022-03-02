//
//  TodoTableViewCell.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/01.
//

import UIKit
import RxSwift

class TodoTableViewCell: UITableViewCell {
    static let identifier = "TodoTableViewCell"

    private var containerView = UIView()
    var completeButton = UIButton()
    var contentLabel = UILabel()
    var deleteButton = UIButton()
    
    var completeTodoAt: Observable<Int>!
    var deleteTodoAt: Observable<Int>!
    
    var todo: Todo? {
        didSet {
            guard let todo = todo else {
                return
            }
            self.contentLabel.text = todo.content
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.containerView.addSubview(completeButton)
        self.containerView.addSubview(contentLabel)
        self.containerView.addSubview(deleteButton)
        
        self.contentView.addSubview(containerView)
        self.contentView.backgroundColor = UIColor(hexString: "EFF0F3")
        
        self.containerView.then {
            $0.backgroundColor = .white
            $0.setCornerRadius(radius: 12.adjustedHeight)
        }.snp.makeConstraints {
            $0.height.equalTo(24.adjustedHeight)
            $0.left.right.equalToSuperview().inset(14.adjustedHeight)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10.adjustedHeight)
        }
        
        
        self.completeButton.then {
            $0.setImage(UIImage(named: "CompleteButtonImage")?.resize(to: CGSize(width: 9.48, height: 9.48).resized(basedOn: .height)), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.imageView?.tintColor = UIColor(hexString: "646A88")
        }.snp.makeConstraints {
            $0.width.equalTo(22.adjustedHeight)
            $0.height.equalTo(20.adjustedHeight)
            $0.left.equalToSuperview().inset(6.adjustedHeight)
            $0.centerY.equalToSuperview()
        }
        
        self.contentLabel.then {
            $0.font = .defaultFont(size: 12, boldLevel: .light)
            $0.textColor = UIColor(hexString: "646A88")
            $0.textAlignment = .left
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(completeButton.snp.right).offset(7.adjustedHeight)
            $0.right.equalToSuperview().inset(31.adjustedHeight)
        }
        
        self.deleteButton.then {
            $0.setImage(UIImage(named: "DeleteTodoImage")?.resize(to: CGSize(width: 5, height: 5).resized(basedOn: .height)), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.imageView?.tintColor = UIColor(hexString: "E5949D")
        }.snp.makeConstraints {
            $0.width.equalTo(22.adjustedHeight)
            $0.height.equalTo(20.adjustedHeight)
            $0.right.equalToSuperview().inset(6.adjustedHeight)
            $0.centerY.equalToSuperview()
        }
        
        self.completeTodoAt = self.completeButton.rx.tap
            .map { [weak self] in
                self?.completeButton.tag ?? -1
            }
        
        self.deleteTodoAt = self.deleteButton.rx.tap
            .map { [weak self] in
                self?.deleteButton.tag ?? -1
            }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
