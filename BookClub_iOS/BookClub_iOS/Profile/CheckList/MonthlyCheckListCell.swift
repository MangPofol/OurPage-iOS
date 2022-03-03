//
//  MonthlyCheckListCell.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/02.
//

import UIKit

import RxSwift
import RxCocoa

class MonthlyCheckListCell: UITableViewCell {
    static let identifier = "MonthlyCheckListCell"
    
    private var containerView = UIView()
    private var disposeBag = DisposeBag()
    private var cellDisposeBag = DisposeBag()
    
    var viewModel: CheckListViewModel!
    var checkListOpened = false
    var todos: [Todo] = [] {
        didSet {
            self.todoCountLabel.text = "\(todos.count)"
            self.header.titleLabel.text = todos.first?.createDate.toString(with: "yyyy.MM") ?? ""
            cellDisposeBag = DisposeBag()
            self.toDoListTableView.reloadData()
        }
    }
    
    var todoCountLabel = UILabel()
    var header = CheckListButton()
    var toDoListTableView = UITableView().then {
        $0.backgroundColor = UIColor(hexString: "EFF0F3")
        $0.bottomRoundCorner(radius: 8.adjustedHeight)
        $0.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
        $0.separatorStyle = .none
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.toDoListTableView.dataSource = self
        self.toDoListTableView.delegate = self
        
        self.contentView.addSubview(header)
        self.addSubview(todoCountLabel)
        self.contentView.addSubview(toDoListTableView)
        
        self.header.then {
            $0.settingButton.removeFromSuperview()
            $0.lineView.removeFromSuperview()
        }.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(34.adjustedHeight)
        }
        
        self.todoCountLabel.then {
            $0.font = .defaultFont(size: 10, boldLevel: .medium)
            $0.textColor = .mainColor
        }.snp.makeConstraints {
            $0.centerY.equalTo(header)
            $0.right.equalTo(header).offset(-37.adjustedHeight)
        }
        
        self.toDoListTableView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10.adjustedHeight).priority(999)
            $0.height.equalTo(0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension MonthlyCheckListCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as! TodoTableViewCell
        cell.todo = todos[indexPath.row]
        
        cell.completeButton.rx.tap
            .map { [weak self] in
                guard let self = self else { return nil }
                return self.todos[indexPath.row]
            }
            .compactMap { $0 }
            .bind(to: self.viewModel.todoToIncomplete)
            .disposed(by: cellDisposeBag)
        
        cell.deleteButton.rx.tap
            .map { [weak self] in
                guard let self = self else { return nil }
                return self.todos[indexPath.row]
            }
            .compactMap { $0 }
            .bind(to: self.viewModel.todoToDelete)
            .disposed(by: cellDisposeBag)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 34.adjustedHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SELECTED")
    }
}
