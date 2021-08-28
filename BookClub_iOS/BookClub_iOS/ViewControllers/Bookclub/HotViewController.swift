//
//  HotViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/26.
//

import UIKit
import RxSwift
import RxCocoa

class HotViewController: UITableViewController {
    let disposeBag = DisposeBag()
    let viewModel = HotViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        
        self.tableView.register(HotViewCell.self, forCellReuseIdentifier: HotViewCell.identifier)
        // bind outputs
        viewModel.hots.bind(to: self.tableView.rx.items(cellIdentifier: HotViewCell.identifier, cellType: HotViewCell.self)) { (row, element, cell) in
            cell.titleLabel.text = element.content
            cell.bookLabel.text = element.book
        }.disposed(by: disposeBag)
    }
}

class HotViewCell: UITableViewCell {
    static let identifier = "HotViewCell"
    var titleLabel = UILabel().then {
        $0.font = .defaultFont(size: .cellFont)
        $0.textColor = .black
    }
    var bookLabel = UILabel().then {
        $0.font = .defaultFont(size: .cellFont)
        $0.textColor = .gray1
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(bookLabel)
        
        titleLabel.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview().inset(12)
            $0.width.equalToSuperview().multipliedBy(0.6)
        }
        bookLabel.snp.makeConstraints {
            $0.right.top.bottom.equalToSuperview().inset(12)
            $0.width.equalToSuperview().multipliedBy(0.4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
