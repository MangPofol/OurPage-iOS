//
//  SideMenuItemsController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/03.
//

import UIKit
import Tabman
import Pageboy

class SideMenuItemsController: TabmanViewController {

    private var viewControllers = [UIViewController(), UIViewController(), UIViewController()]
    private let vcTitles = ["알림", "나의 북클럽", "설정"]
    private let vcIcons: [UIImage] = [.alertIcon, .MyLibraryIcon, .settingIcon]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        let bar = TMBar.TabBar()
        bar.layout.transitionStyle = .snap // Customize
        addBar(bar.systemBar(), dataSource: self, at: .top)
        bar.backgroundView.tintColor = .white
        bar.backgroundColor = .white
        bar.snp.makeConstraints {
            $0.height.equalTo(Constants.getAdjustedHeight(60.0))
        }
        
        bar.buttons.customize { button in
            button.selectedTintColor = .mainColor
            button.tintColor = .grayC3
            button.imageContentMode = .scaleAspectFit
            button.imageViewSize = CGSize(width: Constants.getAdjustedHeight(24.0), height: Constants.getAdjustedHeight(24.0))
            button.font = .defaultFont(size: .small)
        }
    }
}

extension SideMenuItemsController: PageboyViewControllerDataSource, TMBarDataSource {
    
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
        let item = TMBarItem(title: vcTitles[index])
        item.image = vcIcons[index]
        return item
    }
}
