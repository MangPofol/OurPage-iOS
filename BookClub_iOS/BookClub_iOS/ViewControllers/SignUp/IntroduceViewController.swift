//
//  IntroduceViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/11/03.
//

import UIKit
import RxSwift
import RxCocoa

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
                    self.navigationController?.pushViewController(GenreViewController(), animated: true)
                }
            }
            .disposed(by: disposeBag)
        // }
    }
}
