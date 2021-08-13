//
//  BookListTabViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/13.
//

import UIKit
import Tabman
import Pageboy

// TODO: 가입한 북클럽만큼 Tab bar 세팅해주기
class BookListTabViewController: TabmanViewController {
    private var viewControllers = [UIViewController(), UIViewController(), UIViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UIViewController()
        vc1.view.backgroundColor = .red
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .green
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .blue
        let vc4 = UIViewController()
        vc4.view.backgroundColor = .yellow
        
        viewControllers = [BookListViewController(), vc2, vc3, vc4]
        
        
        self.dataSource = self
        
        // Create bar
        let bar = TMBar.ButtonBar()
        setUpBar(bar: bar)
    }
    
    private func setUpBar(bar: TMBar.ButtonBar) {
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
        bar.layout.transitionStyle = .snap
        bar.backgroundView.style = .flat(color: .white)
        
        // 버튼 속성 설정
        bar.buttons.customize { (button) in
            button.font = UIFont.preferredFont(forTextStyle: .caption1)
            button.tintColor = .gray
            button.selectedTintColor = .black
        }
        
        // 인디케이터 설정
//        bar.indicator.weight = .medium
//        bar.indicator.tintColor = .black
        bar.indicator.isHidden = true
        
        // 오버 스크롤
//        bar.indicator.overscrollBehavior = .compress
        
        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }
}

extension BookListTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "나만보기")
        case 1:
            return TMBarItem(title: "북클럽 A")
        case 2:
            return TMBarItem(title: "북클럽 B")
        case 3:
            return TMBarItem(title: "북클럽 B")
        default:
            return TMBarItem(title: "")
        }
    }
}
