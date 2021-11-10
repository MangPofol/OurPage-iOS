//
//  GenderBirthViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/30.
//

import UIKit

import RxSwift
import RxCocoa

class GenderBirthViewController: UIViewController {
    
    var customView = GenderBirthView()
    
    var disposeBag = DisposeBag()
    
    var years = Array(1920...2010)
    var months = Array(1...12)
    var days = Array(1...31) {
        didSet {
            self.customView.dayPickerView.reloadAllComponents()
        }
    }
    
    var viewModel: GenderBirthViewModel!
    
    override func loadView() {
        self.view = customView
        self.navigationItem.backButtonTitle = ""
        
        self.customView.yearPickerView.selectRow(77, inComponent: 0, animated: true)
        self.customView.monthPickerView.selectRow(0, inComponent: 0, animated: true)
        self.customView.dayPickerView.selectRow(0, inComponent: 0, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customView.yearPickerView.rx.setDelegate(self).disposed(by: disposeBag)
        self.customView.yearPickerView.dataSource = self
        
        self.customView.monthPickerView.rx.setDelegate(self).disposed(by: disposeBag)
        self.customView.monthPickerView.dataSource = self
        
        self.customView.dayPickerView.rx.setDelegate(self).disposed(by: disposeBag)
        self.customView.dayPickerView.dataSource = self
        
        viewModel = GenderBirthViewModel(
            input: (
                isMenSelected: self.customView.menButton.isOnRx,
                isWomenSelected: self.customView.womenButton.isOnRx,
                nextButtonTapped: self.customView.nextButton.rx.tap
            )
        )
        
        // bind inputs {
        self.customView.yearPickerView.rx.itemSelected
            .bind {
                self.viewModel.selectedYear.onNext(self.years[$0.row])
            }
            .disposed(by: disposeBag)
        
        self.customView.monthPickerView.rx.itemSelected
            .bind {
                self.viewModel.selectedMonth.onNext(self.months[$0.row])
            }
            .disposed(by: disposeBag)
        
        self.customView.dayPickerView.rx.itemSelected
            .bind {
                self.viewModel.selectedDay.onNext(self.days[$0.row])
            }
            .disposed(by: disposeBag)
        // }
        
        // bind outputs {
        viewModel.newDays
            .bind {
                self.days = Array(1...$0)
            }
            .disposed(by: disposeBag)
        
        viewModel.isAbleToProgress
            .bind {
                self.customView.nextInformationLabel.isHidden = !$0
                if $0 {
                    self.customView.nextButton.isUserInteractionEnabled = true
                    self.customView.nextButton.backgroundColor = .mainPink
                    self.customView.nextButton.setTitleColor(.white, for: .normal)
                } else {
                    self.customView.nextButton.isUserInteractionEnabled = false
                    self.customView.nextButton.backgroundColor = .textFieldBackgroundGray
                    self.customView.nextButton.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.nextConfirmed
            .filter { $0 }
            .bind {
                if $0 {
                    self.navigationController?.pushViewController(IntroduceViewController(), animated: true)
                }
            }
            .disposed(by: disposeBag)
        // }
    }
    
    override func viewWillLayoutSubviews() {
        self.customView.yearPickerView.subviews[0].layoutMargins = UIEdgeInsets.zero
        self.customView.yearPickerView.subviews[0].subviews[0].layoutMargins = UIEdgeInsets.zero
    
    }
}

extension GenderBirthViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Constants.getAdjustedWidth(200), height: Constants.getAdjustedHeight(60.0)))
        pickerLabel.font = .defaultFont(size: .medium, bold: true)
        pickerLabel.textAlignment = .center
        pickerLabel.textColor = .mainColor
    
        switch pickerView {
        case self.customView.yearPickerView:
            pickerLabel.text = "\(years[row])"
        case self.customView.monthPickerView:
            pickerLabel.text = "\(months[row])"
        case self.customView.dayPickerView:
            pickerLabel.text = "\(days[row])"
        default:
            break
        }
        
        return pickerLabel
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return Constants.getAdjustedHeight(40.0)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case self.customView.yearPickerView:
            return years.count
        case self.customView.monthPickerView:
            return months.count
        case self.customView.dayPickerView:
            return days.count
        default:
            return 0
        }
    }
}
