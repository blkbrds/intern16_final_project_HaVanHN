//
//  TabbarViewController.swift
//  EateryTour
//
//  Created by NganHa on 9/9/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

final class TabbarViewController: TabBarController {

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabbar()
    }

    // MARK: - Private functions
    private func configTabbar() {
        let homeNavigationController = UINavigationController(rootViewController: HomeViewController())
        homeNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 0)
        let searchNavigationController = UINavigationController(rootViewController: SearchViewController())
        searchNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), tag: 1)
        let mapNavigationController = UINavigationController(rootViewController: MapViewController())
        mapNavigationController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "location"), tag: 2)
        let favoriteNavigationController = UINavigationController(rootViewController: FavoriteViewController())
        favoriteNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "suit.heart"), tag: 3)
        let settingViewController = SettingViewController()
        settingViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "setting"), tag: 4)
        setViewControllers([homeNavigationController, searchNavigationController,
                            mapNavigationController, favoriteNavigationController, settingViewController], animated: true)
        tabBar.tintColor = #colorLiteral(red: 0.10909646, green: 0.2660153806, blue: 0.2814711332, alpha: 1)
        tabBar.backgroundColor = UIColor.white
        tabBar.layer.borderColor = #colorLiteral(red: 0.10909646, green: 0.2660153806, blue: 0.2814711332, alpha: 1)
        tabBar.layer.borderWidth = 1
        tabBar.clipsToBounds = true
        tabBar.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    }
}
