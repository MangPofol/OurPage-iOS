//
//  CheckListViewController.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/02.
//

import UIKit

import RxSwift
import RxCocoa

class CheckListViewController: UIViewController {

    private let customView = CheckListView()
    private var viewModel: CheckListViewModel!
    
    private let disposeBag = DisposeBag()
    private var cellDisposebag = DisposeBag()
    
    private var monthlyTodos: [[Todo]] = [] {
        didSet {
            self.cellDisposebag = DisposeBag()
            self.customView.monthlyCheckListTableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = UIView()
        self.title = "체크리스트 관리"
        self.view.backgroundColor = .white
        
        self.view.addSubview(customView)
        
        customView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.customView.makeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = CheckListViewModel()
        
        self.customView.monthlyCheckListTableView.estimatedRowHeight = 220.adjustedHeight
        self.customView.monthlyCheckListTableView.dataSource = self
        self.customView.monthlyCheckListTableView.delegate = self
        
        self.viewModel.monthlyTodos
            .bind { [weak self] in
                guard let self = self else { return }
                self.monthlyTodos = $0
            }
            .disposed(by: disposeBag)
        
        self.viewModel.indexToOpen
            .bind { [weak self] idx in
                guard let self = self else { return }
                guard let cell = self.customView.monthlyCheckListTableView.cellForRow(at: IndexPath(row: idx, section: 0)) as? MonthlyCheckListCell else {
                    return
                }
                cell.checkListOpened.toggle()
                
                self.customView.monthlyCheckListTableView.beginUpdates()
                if cell.checkListOpened {
                    cell.header.topRoundCorner(radius: 8.adjustedHeight)
                }
                
                cell.toDoListTableView.snp.updateConstraints {
                    $0.height.equalTo(cell.checkListOpened ? 178.adjustedHeight : 0)
                }
                
                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                    self.view.layoutIfNeeded()
                    if cell.checkListOpened {
                        cell.header.openButton.rotateWithoutAnimation(degree: Double.pi)
                    } else {
                        cell.header.openButton.transform = CGAffineTransform.identity
                    }
                    
                }, completion: { _ in
                    if !cell.checkListOpened {
                        cell.header.setCornerRadius(radius: 8.adjustedHeight)
                    }
                    
                    UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                        self.view.layoutIfNeeded()
                    })
                })
                self.customView.monthlyCheckListTableView.endUpdates()
                
            }
            .disposed(by: disposeBag)
    }

}

extension CheckListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.monthlyTodos.count == 1 && self.monthlyTodos.first?.count == 0 {
            return 0
        }
        return self.monthlyTodos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MonthlyCheckListCell.identifier, for: indexPath) as! MonthlyCheckListCell
        cell.todos = self.monthlyTodos[indexPath.row]
        cell.header.openButton.rx.tap
            .map { indexPath.row }
            .bind(to: self.viewModel.indexToOpen)
            .disposed(by: cellDisposebag)
        cell.viewModel = self.viewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 223.adjustedHeight
    }
}
