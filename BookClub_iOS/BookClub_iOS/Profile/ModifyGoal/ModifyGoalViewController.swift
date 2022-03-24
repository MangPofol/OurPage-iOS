//
//  ModifyGoalViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/08.
//

import UIKit

import RxSwift
import RxCocoa
import BetterSegmentedControl

class ModifyGoalViewController: UIViewController {

    let customView = ModifyGoalView()
    
    var periods = Array(1...30).map { String($0) }
    var units = ["년", "개월", "일"]
    var booksGoals = Array(1...100).map { String($0) }
    
    var viewModel: ModifyGoalViewModel!
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = customView
        self.title = "목표 관리"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFont.defaultFont(size: 14, boldLevel: .bold)], for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Constants.CurrentUser
            .compactMap { $0 }
            .bind { [weak self] in
                guard let self = self,
                      let goal = $0.goal,
                      !goal.isEmpty else { return }
                
                let strs = goal.components(separatedBy: " ")
                
                var period: [String] = []
                var unit: [String] = []
                
                if let str = strs.first {
                    str
                        .map { String($0) }
                        .forEach {
                            if Int($0) != nil {
                                period.append($0)
                            } else {
                                unit.append($0)
                            }
                        }
                }
                
                let _period = Int(period.joined())!
                print("@@@", _period)
                self.customView.periodPickerView.selectRow(_period - 1, inComponent: 0, animated: false)
                
                var _unit = 0
                switch unit.joined() {
                case "년":
                   _unit = 0
                case "개월":
                    _unit = 1
                case "일":
                    _unit = 2
                default:
                    break
                }
                
                self.customView.unitPickerView.selectRow(_unit, inComponent: 0, animated: false)
                
                let str = strs[2]
                var book: [String] = []
                str
                    .map { String($0) }
                    .forEach {
                        if Int($0) != nil {
                            book.append($0)
                        }
                    }
                
                let _book = Int(book.joined())!
                self.customView.booksPickerView.selectRow(_book - 1, inComponent: 0, animated: false)
                
                LoadingHUD.hide()
            }
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadingHUD.show()
        
        self.customView.periodPickerView.rx.setDelegate(self).disposed(by: disposeBag)
        self.customView.periodPickerView.dataSource = self
        self.customView.unitPickerView.rx.setDelegate(self).disposed(by: disposeBag)
        self.customView.unitPickerView.dataSource = self
        self.customView.booksPickerView.rx.setDelegate(self).disposed(by: disposeBag)
        self.customView.booksPickerView.dataSource = self
        
        self.customView.unitPickerView.selectRow(1, inComponent: 0, animated: false)
        self.customView.booksPickerView.selectRow(9, inComponent: 0, animated: false)
        
        viewModel = ModifyGoalViewModel()
        
        self.navigationItem.rightBarButtonItem!.rx.tap
            .map { [weak self] in
                guard let self = self else { return "" }
                return "\(self.customView.periodPickerView.selectedRow(inComponent: 0) + 1)\(self.units[self.customView.unitPickerView.selectedRow(inComponent: 0)]) 동안 \(self.customView.booksPickerView.selectedRow(inComponent: 0) + 1)권의 책을 기록하기"
            }
            .bind(to: self.viewModel.goalSentence)
            .disposed(by: disposeBag)
            
        // outputs
        viewModel.isModified
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in
                if $0 {
                    self?.navigationController?.popViewController(animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
    

//    "\($0)\($1) 동안 \($2)권의 책을 기록하기"
//    private func goalStringToComponents(goal: String) -> [String] {
//        let goalArr = goal.map { String($0) }
//        var arr: [String] = []
//
//        arr.append(goalArr[0] + goalArr[1])
//        arr.append(goalArr[4] + goalArr[5])
//        arr.append(goalArr[7] + goalArr[8])
//        return arr
//    }
}

extension ModifyGoalViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Constants.getAdjustedWidth(200), height: Constants.getAdjustedHeight(60.0)))
        pickerLabel.font = .defaultFont(size: 14, boldLevel: .bold)
        pickerLabel.textAlignment = .center
        pickerLabel.textColor = .mainColor
        
        switch pickerView {
        case self.customView.periodPickerView:
            pickerLabel.text = periods[row]
        case self.customView.unitPickerView:
            pickerLabel.text = units[row]
        case self.customView.booksPickerView:
            pickerLabel.text = booksGoals[row]
        default:
            break
        }
        
        return pickerLabel
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0.adjustedHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case self.customView.periodPickerView:
            return periods.count
        case self.customView.unitPickerView:
            return units.count
        case self.customView.booksPickerView:
            return booksGoals.count
        default:
            return 0
        }
    }
}
