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
        
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = Constants.navigationbarColor
        appearance.stackedLayoutAppearance.normal.iconColor = .grayC4
        appearance.stackedLayoutAppearance.selected.iconColor = .mainColor
        appearance.shadowImage = UIImage()
        appearance.backgroundImage = UIImage()
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
        }
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 2
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = CGFloat(Constants.getAdjustedHeight(75.0))
        tabBar.frame.size.height = height
        tabBar.frame.origin.y = view.frame.height - height
    }
    
    func setupVCs() {
        
        viewControllers = [
            createNavController(for: HomeViewController(), image: .PersonIcon.resize(to: CGSize(width: 27.adjustedWidth, height: 30.adjustedHeight)), title: ""),
            createNavController(for: MyLibraryViewController(), image: .MyLibraryIcon.resize(to: CGSize(width: 26.98.adjustedWidth, height: 29.adjustedHeight)), title: "내 서재"),
            createNavController(for: BookclubViewController(), image: .BookclubIcon.resize(to: CGSize(width: 27.53.adjustedWidth, height: 29.adjustedHeight)), title: "북클럽")
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
