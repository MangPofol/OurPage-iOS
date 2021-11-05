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
    
    var viewModel: GenderBirthViewModel!
    
    override func loadView() {
        self.view = customView
        self.navigationItem.backButtonTitle = ""
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
                gender: Observable.merge(
                    self.customView.menButton.isOnRx.map { _ in "MALE" },
                    self.customView.womenButton.isOnRx.map { _ in "FEMALE" }
                ),
                birth: Observable.just("2020년 11월 3일"),
                nextButtonTapped: self.customView.nextButton.rx.tap
            )
        )
        
        
        // bind outputs {
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
//        self.customView.yearPickerView.subviews[1].backgroundColor = .textFieldBackgroundGray
        self.customView.yearPickerView.subviews[0].layoutMargins = UIEdgeInsets.zero
        self.customView.yearPickerView.subviews[0].subviews[0].layoutMargins = UIEdgeInsets.zero
        print(#fileID, #function, #line, self.customView.yearPickerView.subviews[0].subviews)
    }
}

extension GenderBirthViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Constants.getAdjustedWidth(200), height: Constants.getAdjustedHeight(60.0)))
            
        let pickerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Constants.getAdjustedWidth(200), height: Constants.getAdjustedHeight(60.0)))
        pickerLabel.font = .defaultFont(size: .medium, bold: true)
        pickerLabel.textAlignment = .center
        pickerLabel.textColor = .mainColor
        pickerLabel.text = "\(years[row])"
    
        view.addSubview(pickerLabel)
        return pickerLabel
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return Constants.getAdjustedHeight(40.0)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
}
