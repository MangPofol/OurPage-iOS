//
//  SideMenuViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/09.
//

import UIKit
import RxCocoa
import RxSwift

class SideMenuViewController: UIViewController {
    let disposeBag = DisposeBag()
    let sideMenuView = SideMenuView()
    var cellHeight = Constants.screenSize.height / 20.0
    
    override func loadView() {
        self.view = sideMenuView
        self.view.backgroundColor = .white
        self.view.setShadow(opacity: 1, color: .lightGray, offset: CGSize(width: 0, height: 3), radius: 1)
        self.navigationController?.isNavigationBarHidden = true
        sideMenuView.makeView()
        setUpTableViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = SideMenuViewModel()
        
        // tableview에 표시할 데이터에 tableview bind {
        viewModel.bookclubs
            // 셀 개수에 따라 tableview 크기 맞추기
            .do(onNext: { clubs in
                self.sideMenuView.myBookClubTableView.snp.makeConstraints { $0.height.equalTo(self.cellHeight * CGFloat(clubs.count)) }
            })
            .observeOn(MainScheduler.instance)
            .bind(to: sideMenuView.myBookClubTableView.rx.items) { (tableView: UITableView, index: Int, element) in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: BookClubListTableViewCell.identifier, for: indexPath) as! BookClubListTableViewCell
                cell.titleLabel.text = " " + element
                cell.exitButton.rx.tap.bind { print("buttonTap") }.disposed(by: cell.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.joinedClubs
            // 셀 개수에 따라 tableview 크기 맞추기
            .do(onNext: { clubs in
                self.sideMenuView.joinedClubTableView.snp.makeConstraints {
                    $0.height.equalTo(self.cellHeight * CGFloat(clubs.count)) }
            })
            .observeOn(MainScheduler.instance)
            .bind(to: sideMenuView.joinedClubTableView.rx.items) { (tableView: UITableView, index: Int, element) in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: BookClubListTableViewCell.identifier, for: indexPath) as! BookClubListTableViewCell
                cell.titleLabel.text = " " + element
                cell.exitButton.setTitle("탈퇴", for: .normal)
                cell.exitButton.rx.tap.bind { print("buttonTap") }.disposed(by: cell.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.alerts
            .do(onNext: { alerts in
                self.sideMenuView.alertTableView.snp.makeConstraints {
                    $0.height.equalTo(self.cellHeight * CGFloat(alerts.count) * 2.0) }
            })
            .observeOn(MainScheduler.instance)
            .bind(to: sideMenuView.alertTableView.rx.items) { (tableView: UITableView, index: Int, element: AlertModel) in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: AlertTableViewCell.identifier, for: indexPath) as! AlertTableViewCell
                cell.titleLabel.text = " " + element.title + " "
                cell.contentLabel.text = " " + element.content
                cell.commentLabel.text = " " + (element.comment ?? "")
                return cell
            }
            .disposed(by: disposeBag)
        // }
        
        // select row at {
        sideMenuView.myBookClubTableView.rx.modelSelected(String.self)
            .subscribe(onNext:  { value in
                print("Tapped `\(value)`")
            })
            .disposed(by: disposeBag)
        
        sideMenuView.joinedClubTableView.rx.modelSelected(String.self)
            .subscribe(onNext:  { value in
                print("Tapped `\(value)`")
            })
            .disposed(by: disposeBag)
        
        sideMenuView.alertTableView.rx.modelSelected(AlertModel.self)
            .subscribe(onNext:  { value in
                print("Tapped `\(value)`")
            })
            .disposed(by: disposeBag)
        // }
        
        // bind inputs {
        sideMenuView.myBookClubButton.rx.tap
            .bind {
                // TODO:
                self.sideMenuView.myBookClubTableView.snp.makeConstraints {
                    $0.height.equalTo(0)
                }
            }
            .disposed(by: disposeBag)
        // }
        
        // ▶︎
    }
    
    private func setUpTableViews() {
        sideMenuView.myBookClubTableView.register(BookClubListTableViewCell.classForCoder(), forCellReuseIdentifier: BookClubListTableViewCell.identifier)
        sideMenuView.joinedClubTableView.register(BookClubListTableViewCell.classForCoder(), forCellReuseIdentifier: BookClubListTableViewCell.identifier)
        sideMenuView.alertTableView.register(AlertTableViewCell.classForCoder(), forCellReuseIdentifier: AlertTableViewCell.identifier)
        sideMenuView.myBookClubTableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        sideMenuView.joinedClubTableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        sideMenuView.alertTableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == sideMenuView.alertTableView {
            return UITableView.automaticDimension
        }
        cellHeight = UITableView.automaticDimension
        return cellHeight
    }
}
