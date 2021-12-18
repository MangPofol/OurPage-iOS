//
//  ReadingStyleViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/05.
//

import UIKit

import RxSwift
import RxCocoa
import RxKeyboard

class ReadingStyleViewController: UIViewController {

    let customView = ReadingStyleView()
    
    var disposeBag = DisposeBag()
    
    var viewModel: ReadingStyleViewModel!
    
    override func loadView() {
        self.view = customView
        self.navigationItem.backButtonTitle = ""
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "건너뛰기", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFont.defaultFont(size: 14, boldLevel: .bold), .foregroundColor: UIColor.mainColor], for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // textview placeholder
        self.customView.customStyleTextField.rx.didBeginEditing
            .subscribe(onNext: { [self] in
                self.customView.style1Button.isOn = false
                self.customView.style2Button.isOn = false
                self.customView.style3Button.isOn = false
                if(self.customView.customStyleTextField.text == "+ 직접 입력하기 (최대 30자)" ) {
                    self.customView.customStyleTextField.text = nil
                    self.customView.customStyleTextField.textColor = .white
                    self.customView.customStyleTextField.backgroundColor = .mainColor
                } else {
                    self.customView.customStyleTextField.textColor = .white
                    self.customView.customStyleTextField.backgroundColor = .mainColor
                }
            }).disposed(by: disposeBag)
        
        self.customView.customStyleTextField.rx.didEndEditing
            .subscribe(onNext: { [self] in
                if(self.customView.customStyleTextField.text == nil || self.customView.customStyleTextField.text == "") {
                    self.customView.customStyleTextField.backgroundColor = UIColor(hexString: "EFF0F3")
                    self.customView.customStyleTextField.text = "+ 직접 입력하기 (최대 30자)"
                    self.customView.customStyleTextField.textColor = UIColor(hexString: "C3C5D1")
                    
                } else {
                    self.customView.customStyleTextField.backgroundColor = UIColor(hexString: "EFF0F3")
                    self.customView.customStyleTextField.textColor = UIColor(hexString: "C3C5D1")
                }
            }).disposed(by: disposeBag)

        viewModel = ReadingStyleViewModel(
            input: (
                styleText:
                    Observable.merge(
                        Observable.combineLatest(
                            self.customView.style1Button.isOnRx
                                .map { $0 ? self.customView.style1Button.title(for: .normal)! : "" },
                            self.customView.style2Button.isOnRx
                                .map { $0 ? self.customView.style2Button.title(for: .normal)! : "" },
                            self.customView.style3Button.isOnRx
                                .map { $0 ? self.customView.style3Button.title(for: .normal)! : "" }
                        ).map {
                            if $0 != "" || $1 != "" || $2 != "" {
                                self.customView.customStyleTextField.resignFirstResponder()
                                self.customView.customStyleTextField.backgroundColor = UIColor(hexString: "EFF0F3")
                                self.customView.customStyleTextField.textColor = UIColor(hexString: "C3C5D1")
                            }
        
                            if $0 != "" {
                                return $0
                            } else if $1 != "" {
                                return $1
                            } else if $2 != "" {
                                return $2
                            } else {
                                return ""
                            }
                        },
                        self.customView.customStyleTextField.rx.text
                            .filter { $0 != nil }
                            .filter { $0 != "+ 직접 입력하기 (최대 30자)"}
                            .map { $0! }.distinctUntilChanged()
                    ),
                nextButtonTapped: self.customView.nextButton.rx.tap
            )
        )
        
        // 글자 수 제한
        self.customView.customStyleTextField.rx.text.orEmpty
            .asObservable()
            .filter {
                $0 != "+ 직접 입력하기 (최대 30자)"
            }
            .scan("") { old, new in
                if new.count > 30 {
                    return old
                } else {
                    return new
                }
            }
            .bind(to: self.customView.customStyleTextField.rx.text)
            .disposed(by: disposeBag)
    
        // bind results {
        viewModel.isStyleSelected
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
        
        viewModel.isNextConfirmed
            .bind {
                if $0 {
                    print(SignUpViewModel.creatingUser)
                    self.navigationController?.pushViewController(GoalViewController(), animated: true)
                }
            }
            .disposed(by: disposeBag)
        // }
        
        self.navigationItem.rightBarButtonItem?
            .rx.tap
            .bind { [weak self] in
                SignUpViewModel.creatingUser.style = ""
                self?.navigationController?.pushViewController(GoalViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
            .skip(1)
            .drive(onNext: { [weak self] height in
                UIView.animate(withDuration: 0) {
                    if height == 0 {
                        self?.customView.nextInformationLabel.snp.updateConstraints {
                            $0.bottom.equalToSuperview().inset(Constants.getAdjustedHeight(75.0))
                        }
                    } else {
                        self?.customView.nextInformationLabel.snp.updateConstraints {
                            $0.bottom.equalToSuperview().inset(height)
                        }
                    }
                }
                self?.view.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
    }
    
    
}
