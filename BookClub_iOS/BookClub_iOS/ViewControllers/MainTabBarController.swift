//
//  MainTabBarController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/15.
//

import UIKit
import Tabman
import Pageboy

class MainTabBarController: TabmanViewController {
    
    private var viewControllers = [UIViewController(), UIViewController(), UIViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: MyLibraryViewController())
        let vc2 = UINavigationController(rootViewController: BookclubViewController())
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .blue
        
        viewControllers = [vc1, vc2, vc3]
        
        
        self.dataSource = self
        self.isScrollEnabled = false
        // Create bar
        let bar = TMBar.TabBar()

        setUpBar(bar: bar)
    }
    
    private func setUpBar(bar: TMBar.TabBar) {
        bar.layout.transitionStyle = .none
        
        // 버튼 속성 설정
        bar.buttons.customize { (button) in
            button.tintColor = .gray1
            button.selectedTintColor = .mainColor
        }
                
        // 오버 스크롤
        bar.indicator.overscrollBehavior = .compress
        
        let systemBar = bar.systemBar()
        systemBar.setShadow()
        systemBar.backgroundStyle = .flat(color: .white)
        
        // Add to view
        addBar(systemBar, dataSource: self, at: .bottom)
    }
}

extension MainTabBarController: PageboyViewControllerDataSource, TMBarDataSource {
    
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
        return TMBarItem(image: UIImage(systemName: "person")!)
    }
}
