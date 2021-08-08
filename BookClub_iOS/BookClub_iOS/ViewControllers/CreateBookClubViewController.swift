//
//  CreateBookClubViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/05.
//

import UIKit
import SnapKit
import Then

class CreateBookClubViewController: UIViewController {
    lazy var customView = CreateBookClubView()
    lazy var underBarButton = UnderBarButton()
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(customView)
        self.view.addSubview(underBarButton)
        underBarButton.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.height.equalTo(Constants.screenSize.height / 12.5)
        }
        customView.snp.makeConstraints {
            $0.bottom.equalTo(underBarButton.snp.top)
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
        }
        customView.makeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .lightGray
        
        let viewModel = CreateBookClubViewModel(
            input: (
                nameText: customView.nameTextField
                    .rx.text
                    .skip(1)
                    .distinctUntilChanged()
                    .asDriver(onErrorJustReturn: nil),
                redButtonTap: customView.redButton.rx.tap.asSignal(),
                greenButtonTap: customView.greenButton.rx.tap.asSignal(),
                blueButtonTap: customView.blueButton.rx.tap.asSignal(),
                createButtonTap: customView.createButton.rx.tap.asSignal()
            )
        )
        
        // TODO: bind to result {
            
        // }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        makeButtonsCircular(buttons: [customView.redButton, customView.blueButton, customView.greenButton])
        
    }
    
    private func makeButtonsCircular(buttons: [UIButton]) {
        buttons.forEach {
//            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = $0.frame.width/2
        }
    }
}
