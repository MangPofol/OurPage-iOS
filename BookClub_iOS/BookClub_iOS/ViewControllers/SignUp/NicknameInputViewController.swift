//
//  NicknameInputViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/30.
//

import UIKit

import RxSwift
import RxCocoa
import RxKeyboard

class NicknameInputViewController: UIViewController {

    let customView = NicknameInputView()
    
    var viewModel: NicknameViewModel!
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = customView
        self.navigationItem.backButtonTitle = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = NicknameViewModel(
            input: (
                nicknameText: self.customView.nicknameTextField.rx.text
                    .filter { $0 != nil }.map { $0! },
                nextButtonTapped: self.customView.nextButton.rx.tap
                    .do { [weak self] _ in
                        self?.customView.nextButton.animateButton()
                    }.map { true }
            )
        )
        
        // bind outputs {
        viewModel.nicknameConfirmed
            .withUnretained(self)
            .bind { (owner, bool) in
                owner.customView.nextInformationLabel.isHidden = !bool
                owner.customView.nicknameConfirmMessageLabel.isHidden = bool
                if bool {
                    owner.customView.nextButton.isUserInteractionEnabled = true
                    owner.customView.nextButton.backgroundColor = .mainPink
                    owner.customView.nextButton.setTitleColor(.white, for: .normal)
                } else {
                    owner.customView.nextButton.isUserInteractionEnabled = false
                    owner.customView.nextButton.backgroundColor = .textFieldBackgroundGray
                    owner.customView.nextButton.setTitleColor(UIColor(hexString: "C3C5D1"), for: .normal)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.nextConfirmed
            .bind { [weak self] in
                if $0 {
                    self?.navigationController?.pushViewController(GenderBirthViewController(), animated: true)
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
