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
    }
    
    func setupVCs() {
        
        viewControllers = [
            createNavController(for: HomeViewController(), image: .PersonIcon.resize(to: CGSize(width: 27, height: 30).resized(basedOn: .height)), title: ""),
            createNavController(for: MyLibraryViewController(), image: .MyLibraryIcon.resize(to: CGSize(width: 26.98, height: 29).resized(basedOn: .height)), title: "")
        ]
        removeTabbarItemsText()
        self.setViewControllers(viewControllers, animated: false)
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         image: UIImage, title: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        let bottomInset = tabBar.bounds.height - 11.adjustedHeight - image.size.height
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 11.adjustedHeight, left: 0, bottom: -bottomInset, right: 0)
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
