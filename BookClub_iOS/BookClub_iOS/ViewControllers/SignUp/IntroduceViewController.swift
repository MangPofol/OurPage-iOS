//
//  IntroduceViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/03.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard

class IntroduceViewController: UIViewController {

    let customView = IntroduceView()
    
    var viewModel: IntroduceViewModel!
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = customView
        self.navigationItem.backButtonTitle = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = IntroduceViewModel(
            input: (
                introduceText: self.customView.introduceTextField.rx.text
                    .filter { $0 != nil }.map { $0! },
                nextButtonTapped: self.customView.nextButton.rx.tap
            )
        )
        
        // bind outputs {
        viewModel.isIntroduceConfirmed
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
                    self.navigationController?.pushViewController(GenreViewController(), animated: true)
                }
            }
            .disposed(by: disposeBag)
        // }
        
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
