//
//  NicknameInputViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/30.
//

import UIKit

import RxSwift
import RxCocoa

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
                    .do { _ in
                        self.customView.nextButton.animateButton()
                    }.map { true }
            )
        )
        
        // bind outputs {
        viewModel.nicknameConfirmed
            .bind {
                self.customView.nextInformationLabel.isHidden = !$0
                self.customView.nicknameConfirmMessageLabel.isHidden = $0
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
            .bind {
                if $0 {
                    self.navigationController?.pushViewController(GenderBirthViewController(), animated: true)
                }
            }
            .disposed(by: disposeBag)
        // }
    }

}
