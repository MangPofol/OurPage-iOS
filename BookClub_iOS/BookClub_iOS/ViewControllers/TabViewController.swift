//
//  TabViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/27.
//

import UIKit

import Tabman
import Pageboy


class TabViewController: TabmanViewController {
    
    var viewControllers: [UIViewController] = [HomeViewController(), MyLibraryViewController(), BookclubViewController()]
    
    var images: [UIImage] = [
        .PersonIcon.resize(to: CGSize(width: 27, height: 30).resized(basedOn: .height)),
        .MyLibraryIcon.resize(to: CGSize(width: 26.98, height: 29).resized(basedOn: .height)),
        .BookclubIcon.resize(to: CGSize(width: 27.53, height: 29).resized(basedOn: .height))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        let bar = TMBar.TabBar().systemBar()
        
        addBar(bar, dataSource: self, at: .bottom)
    }
    
}

extension TabViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return PageboyViewController.Page.at(index: 0)
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(image: images[index], badgeValue: nil)
    }
}
