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
    var viewModel: WriteViewModel!
    
    override func loadView() {
        self.view = customView
        setNavigationBar()
        // contentTextView placeholder
        setTextViewPlaceholder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WriteViewModel(
            input: (
                bookSelectionButtonTapped: customView.bookSelectionButton.button.rx.tap.asSignal(),
                isMemoOn: customView.memoButton.isOnRx.asObservable(),
                isTopicOn: customView.topicButton.isOnRx.asObservable()
            )
        )
        
        // bind outputs
        viewModel.bookSelection
            .observeOn(MainScheduler.instance)
            .bind {
                print($0)
            }
            .disposed(by: disposeBag)
        
        viewModel.isMemo
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .bind {
                print("isMemo", $0)
            }
            .disposed(by: disposeBag)
        
        viewModel.isTopic
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .bind {
                print("isTopic", $0)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private Funcs
    private func setNavigationBar() {
        guard let nav = self.navigationController else {
            return
        }
        nav.navigationBar.barTintColor = Constants.navigationbarColor
        nav.navigationBar.tintColor = .black
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.titleTextAttributes = [.font: UIFont.defaultFont(size: .big, bold: true)]

        // bar underline 삭제
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.shadowImage = UIImage()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: .sidebarButtonImage, style: .plain, target: nil, action: nil)
        
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
    
    private func setTextViewPlaceholder() {
        customView.contentTextView.rx.didBeginEditing
            .subscribe(onNext: { [self] in
                        if(customView.contentTextView.text == "내용을 입력하세요." ){
                            customView.contentTextView.text = nil
                            customView.contentTextView.textColor = .black
                            
                        }}).disposed(by: disposeBag)
        
        customView.contentTextView.rx.didEndEditing
            .subscribe(onNext: { [self] in
                        if(customView.contentTextView.text == nil || customView.contentTextView.text == ""){
                            customView.contentTextView.text = "내용을 입력하세요."
                            customView.contentTextView.textColor = .grayB0
                            
                        }}).disposed(by: disposeBag)
    }
}
