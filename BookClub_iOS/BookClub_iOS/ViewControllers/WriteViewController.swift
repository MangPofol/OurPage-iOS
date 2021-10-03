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
    
    var selectedBook: Book!
    
    override func loadView() {
        self.view = customView
        setNavigationBar()
        // contentTextView placeholder
        setTextViewPlaceholder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if selectedBook != nil {
            customView.bookSelectionButton.button.setTitle(selectedBook.bookModel.name, for: .normal)
        } else {
            customView.bookSelectionButton.button.setTitle("기록할 책을 선택하세요.", for: .normal)
        }
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
                if $0 {
                    self.navigationController?.pushViewController(BookSelectViewController(), animated: true)
                }
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

        nav.navigationBar.titleTextAttributes = [.font: UIFont.defaultFont(size: .big, bold: true)]
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: .sidebarButtonImage, style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "올리기", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = .mainColor
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFont.defaultFont(size: .medium, bold: true)], for: .normal)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFont.defaultFont(size: .medium, bold: true)], for: .selected)
        
        // 백 버튼 텍스트 지우기
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .mainColor
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        // navigation bar button
        self.navigationItem.leftBarButtonItem!
            .rx.tap
            .bind {
                let menu = SideMenuNavigationController(rootViewController: SideMenuViewController())
                menu.leftSide = true
                menu.presentationStyle = .menuSlideIn
                menu.menuWidth = CGFloat(Constants.getAdjustedWidth(280.0))
                menu.presentationStyle.presentingEndAlpha = 0.5
                
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
