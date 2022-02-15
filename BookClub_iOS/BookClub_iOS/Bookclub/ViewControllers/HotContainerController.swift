//
//  HotContainerController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/26.
//

import UIKit
import Tabman
import Pageboy

class HotContainerController: TabmanViewController {
    private var viewControllers = [HotViewController(), UIViewController()]
    let bar = TMBar.ButtonBar()
    let lineView = LineView(color: .grayC3)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        
        // Create bar
        bar.layout.transitionStyle = .snap
        bar.backgroundView.style = .flat(color: .white)
        bar.layout.contentMode = .fit
        
        // Add to view
        addBar(bar, dataSource: self, at: .top)
        bar.snp.makeConstraints { $0.height.equalTo(30) }
        bar.indicator.tintColor = .mainColor
        bar.indicator.weight = .light
        bar.buttons.customize { (button) in
            button.font = .defaultFont(size: .medium)
            button.selectedFont = .defaultFont(size: .medium, bold: true)
            button.tintColor = .grayC3
            button.selectedTintColor = .mainColor
        }
        
        bar.indicator.superview?.insertSubview(lineView, belowSubview: bar.indicator)
        lineView.snp.makeConstraints {
            $0.top.bottom.equalTo(bar.indicator)
            $0.centerX.equalTo(bar)
            $0.width.equalTo(bar)
        }
    }
}

extension HotContainerController: PageboyViewControllerDataSource, TMBarDataSource {

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
        return TMBarItem(title: (index == 0) ? "핫한 메모" : "핫한 토픽")
    }
}
