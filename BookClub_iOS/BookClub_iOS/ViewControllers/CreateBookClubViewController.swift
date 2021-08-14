//
//  CreateBookClubViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/05.
//

import UIKit
import RxSwift
import SnapKit
import Then
import SideMenu

class CreateBookClubViewController: UIViewController {
    lazy var customView = CreateBookClubView()
    lazy var underBarButton = UnderBarButton()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(customView)
        self.view.addSubview(underBarButton)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "text.justify"), style: .plain, target: nil, action: nil)
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
        
        self.navigationItem.leftBarButtonItem!
            .rx.tap
            .bind {
                // Define the menu
                let menu = SideMenuNavigationController(rootViewController: SideMenuViewController())
                menu.leftSide = true
                menu.presentationStyle = .menuSlideIn
                menu.menuWidth = Constants.screenSize.width * 0.85
                // SideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
                // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
                // let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
                self.present(menu, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
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
