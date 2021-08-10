//
//  WriteViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/10.
//

import UIKit
import RxSwift
import RxCocoa
import SideMenu

class WriteViewController: UIViewController {
    let disposeBag = DisposeBag()
    let customView = WriteView()
    
    override func loadView() {
        self.view = customView
        self.setNavigationBar()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "text.justify"), style: .plain, target: nil, action: nil)
        customView.makeView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TextView placeholder 세팅
        setupTextView()
        
        // navigation bar button
        self.navigationItem.leftBarButtonItem!
            .rx.tap
            .bind {
                let menu = SideMenuNavigationController(rootViewController: SideMenuViewController())
                menu.leftSide = true
                menu.presentationStyle = .menuSlideIn
                menu.menuWidth = Constants.screenSize.width * 0.85
                self.present(menu, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
    private func setupTextView(){
        customView.contentTextView.rx.didBeginEditing
            .subscribe(onNext: { [self] in
                        if(customView.contentTextView.text == "내용을 입력 해 주세요." ){
                            customView.contentTextView.text = nil
                            customView.contentTextView.textColor = .black
                            
                        }}).disposed(by: disposeBag)
        
        customView.contentTextView.rx.didEndEditing
            .subscribe(onNext: { [self] in
                        if(customView.contentTextView.text == nil || customView.contentTextView.text == ""){
                            customView.contentTextView.text = "내용을 입력 해 주세요."
                            customView.contentTextView.textColor = .lightGray
                        }}).disposed(by: disposeBag)
    }

}
