//
//  MyLibraryTabViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/13.
//

import UIKit
import Tabman
import Pageboy

class MyLibraryTabViewController: TabmanViewController {
    private var viewControllers = [UIViewController(), UIViewController(), UIViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UIViewController()
        vc1.view.backgroundColor = .red
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .green
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .blue
        
        viewControllers = [vc1, vc2, vc3]
        
        
        self.dataSource = self
        
        
        // Create bar
        let bar = TMBar.ButtonBar()
        setUpBar(bar: bar)
    }
    
    private func setUpBar(bar: TMBar.ButtonBar) {
        bar.layout.transitionStyle = .snap
        bar.layout.contentMode = .fit
        bar.backgroundView.style = .flat(color: .white)
        
        // 버튼 속성 설정
        bar.buttons.customize { (button) in
            button.tintColor = .black
            button.selectedTintColor = .black
        }
        
        // 인디케이터 설정
        bar.indicator.weight = .medium
        bar.indicator.tintColor = .black
        
        // 오버 스크롤
        bar.indicator.overscrollBehavior = .compress
        
        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }
}

extension MyLibraryTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
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
        let title = "Page \(index)"
        return TMBarItem(title: title)
    }
}
