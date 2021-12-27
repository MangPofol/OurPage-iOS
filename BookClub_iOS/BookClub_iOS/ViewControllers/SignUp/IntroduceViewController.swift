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
        
        customView.introduceTextField
            .rx.text
            .orEmpty
            .scan("") { (previous, new) -> String in
                if new.count > 20 {
                    return previous ?? String(new.prefix(20))
                } else {
                    return new
                }
            }
            .subscribe(customView.introduceTextField.rx.text)
            .disposed(by: disposeBag)
        
        // bind outputs {
        viewModel.isIntroduceConfirmed
            .withUnretained(self)
            .bind { (owner, bool) in
                owner.customView.nextInformationLabel.isHidden = !bool
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
        
        viewModel.isNextConfirmed
            .bind { [weak self] in
                if $0 {
                    self?.navigationController?.pushViewController(GenreViewController(), animated: true)
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
