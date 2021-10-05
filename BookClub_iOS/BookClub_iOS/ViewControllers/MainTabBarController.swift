//
//  MainTabBarController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/15.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVCs()
        removeTabbarItemsText()
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = .grayC4
        tabBar.tintColor = .mainColor
        tabBar.addShadow(location: .top, color: .lightGray, opacity: 1.0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = CGFloat(Constants.getAdjustedHeight(75.0))
        tabBar.frame.size.height = height
        tabBar.frame.origin.y = view.frame.height - height
    }
    
    func setupVCs() {
        
        viewControllers = [
            createNavController(for: WriteViewController(), image: .writeViewIcon, title: "Record"),
            createNavController(for: MyLibraryViewController(), image: .myLibraryViewIcon, title: "내 서재"),
            createNavController(for: BookclubViewController(), image: .bookclubViewIcon, title: "북클럽")
        ]
        self.setViewControllers(viewControllers, animated: true)
        self.customizableViewControllers = viewControllers
        let array = self.customizableViewControllers
        for controller in array! {
            controller.tabBarItem.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: -10, right: 0)
        }

    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         image: UIImage, title: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navController
    }
    
    func removeTabbarItemsText() {
        if let items = tabBarController?.tabBar.items {
            for item in items {
                item.title = nil
//                item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -20, right: 0);
            }
        }
    }
}

//
//fileprivate func createNavController(for rootViewController: UIViewController,
//                                                title: String,
//                                                image: UIImage) -> UIViewController {
//      let navController = UINavigationController(rootViewController: rootViewController)
//      navController.tabBarItem.title = title
//      navController.tabBarItem.image = image
//      navController.navigationBar.prefersLargeTitles = true
//      rootViewController.navigationItem.title = title
//      return navController
//  }
//
//
//func setupVCs() {
//      viewControllers = [
//          createNavController(for: ViewController(), title: NSLocalizedString("Search", comment: ""), image: UIImage(systemName: "magnifyingglass")!),
//          createNavController(for: ViewController(), title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "house")!),
//          createNavController(for: ViewController(), title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person")!)
//      ]
//  }
