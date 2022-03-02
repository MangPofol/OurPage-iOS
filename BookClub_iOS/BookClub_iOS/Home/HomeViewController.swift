//
//  HomeViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/29.
//

import UIKit

import RxSwift
import RxCocoa
import RxGesture
import FFPopup

class HomeViewController: UIViewController {

    let customView = HomeView()
    
    var viewModel: HomeViewModel!
    var disposeBag = DisposeBag()
    private var alertDisposeBag = DisposeBag()
    
    var checkListOpened = false
    
    private var popup: FFPopup!
    
    var todos: [Todo?] = [] {
        didSet {
            self.customView.toDoListTableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = customView
        self.navigationController?.navigationBar.setDefault()
        self.setDefaultConfiguration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.removeBarShadow()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customView.toDoListTableView.delegate = self
        self.customView.toDoListTableView.dataSource = self
        
        viewModel = HomeViewModel(
            checkListButtonTapped: customView.toDoListHeader.openButton.rx.tap,
            myProfileButtonTapped: customView.myProfileButton.rx.tap,
            goalButtonTapped: customView.goalButton.rx.tapGesture().when(.recognized),
            writeButtonTapped: customView.writeButton.rx.tapGesture().when(.recognized)
        )
        
    // bind outputs {
        self.navigationItem.leftBarButtonItem!.rx.tap
            .bind { [weak self] in
                let transition = CATransition()
                transition.duration = 0.3
                transition.type = CATransitionType.moveIn
                transition.subtype = CATransitionSubtype.fromLeft
                self?.view.window!.layer.add(transition, forKey: kCATransition)
                
                let vc = UINavigationController(rootViewController: SettingViewController())
                vc.modalPresentationStyle = .fullScreen
        
                self?.present(vc, animated: false, completion: nil)
                
            }
            .disposed(by: disposeBag)
        
        Constants.CurrentUser
            .debug()
            .compactMap { $0 }
            .withUnretained(self)
            .bind { (owner, user) in
                owner.customView.userNameLabel.text = "\(user.nickname!)님"
                if user.goal != "" {
                    owner.customView.goalButton.titleLabel.text = user.goal
                }
                
            }
            .disposed(by: disposeBag)
        
        viewModel.checkListToggle
            .withUnretained(self)
            .do {(owner, _) in owner.checkListOpened.toggle()}
            .bind { (owner, _) in
                if owner.checkListOpened {
                    owner.customView.toDoListHeader.topRoundCorner(radius: 8.adjustedHeight)
                }
                owner.customView.toDoListTableView.snp.updateConstraints {
                    $0.height.equalTo(owner.checkListOpened ? 178.adjustedHeight : 0)
                }

                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                    owner.view.layoutIfNeeded()
                    if owner.checkListOpened {
                        owner.customView.toDoListHeader.openButton.rotateWithoutAnimation(degree: Double.pi)
                    } else {
                        owner.customView.toDoListHeader.openButton.transform = CGAffineTransform.identity
                    }
                    
                }, completion: { _ in
                    if !owner.checkListOpened {
                        owner.customView.toDoListHeader.setCornerRadius(radius: 8.adjustedHeight)
                    }
                    UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                        owner.view.layoutIfNeeded()
                    })
                })
            }
            .disposed(by: disposeBag)
        
        viewModel.openMyProfileView
            .withUnretained(self)
            .bind { (owner, _) in
                let vc = MyProfileViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.openModifyGoalView
            .withUnretained(self)
            .bind { (owner, _) in
                owner.navigationController?.pushViewController(ModifyGoalViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.openWriteView
            .withUnretained(self)
            .bind { (owner, _) in
                owner.navigationController?.pushViewController(WriteViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.totalCount
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { (owenr, count) in
                if count == nil {
                    owenr.customView.totalPageLabel.text = "total \(0) pages"
                } else {
                    owenr.customView.totalPageLabel.text = "total \(count!) pages"
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.todos
            .do { _ in
                LoadingHUD.hide()
            }
            .withUnretained(self)
            .bind { (owner, todos) in
                owner.todos = todos
            }
            .disposed(by: disposeBag)
    // }
    }
    
    private func showCreateTodoAlert() {
        self.alertDisposeBag = DisposeBag()
        let view = IntroduceUpdateAlertView(introduce: "").then {
            $0.titleLabel.text = "CHECK LIST"
            $0.subtitleLabel.text = "독서 체크리스트를 입력해주세요!"
        }
        let layout = FFPopupLayout(horizontal: .center, vertical: .aboveCenter)
        
        popup = FFPopup(contentView: view, showType: .bounceIn, dismissType: .shrinkOut, maskType: .dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)
        popup.show(layout: layout)
        
        view.cancelButton.rx.tap
            .bind { [weak self] in
                self?.popup.dismiss(animated: true)
            }
            .disposed(by: alertDisposeBag)
        
        view.finishButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.newTodoText.accept(view.introduceTextView.text)
                self?.popup.dismiss(animated: false)
                LoadingHUD.show()
            }
            .disposed(by: alertDisposeBag)
        
        view.introduceTextView.rx.text
            .orEmpty
            .bind {
                view.finishButton.isEnabled = $0.count > 0
            }
            .disposed(by: alertDisposeBag)
        
        view.introduceTextView.rx.setDelegate(self).disposed(by: alertDisposeBag)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.todos[indexPath.row] == nil {
            return tableView.dequeueReusableCell(withIdentifier: EmptyTodoTableViewCell.identifier, for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as! TodoTableViewCell
            cell.todo = self.todos[indexPath.row]
            cell.completeButton.tag = indexPath.row
            cell.deleteButton.tag = indexPath.row
            
            cell.completeTodoAt
                .map { [weak self] in
                    guard let self = self else { return nil }
                    return self.todos[$0]
                }
                .compactMap { $0 }
                .bind(to: self.viewModel.completeTodo)
                .disposed(by: disposeBag)
            
            cell.deleteTodoAt
                .map { [weak self] in
                    guard let self = self else { return nil }
                    return self.todos[$0]
                }
                .compactMap { $0 }
                .bind(to: self.viewModel.deleteTodo)
                .disposed(by: disposeBag)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 34.adjustedHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.todos[indexPath.row] == nil {
            self.showCreateTodoAlert()
        } else {
            
        }
    }
}

// 체크리스트 20자 제한
extension HomeViewController: UITextViewDelegate {
    private func textLimit(existingText: String?, newText: String, limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return self.textLimit(existingText: textView.text,
                              newText: text,
                              limit: 20)
    }
}
