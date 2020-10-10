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
        homeNavigationController.tabBarItem = UITabBarItem(title: "",
                                                           image: #imageLiteral(resourceName: "ic-home"),
                                                           selectedImage: #imageLiteral(resourceName: "ic-home"))

        let mapNavigationController = UINavigationController(rootViewController: MapViewController())
        mapNavigationController.tabBarItem = UITabBarItem(title: "",
                                                          image: #imageLiteral(resourceName: "ic-map"),
                                                          selectedImage: #imageLiteral(resourceName: "ic-map"))

        let favoriteNavigationController = UINavigationController(rootViewController: FavoriteViewController())
        favoriteNavigationController.tabBarItem = UITabBarItem(title: "",
                                                               image: #imageLiteral(resourceName: "ic-favorite"),
                                                               selectedImage: #imageLiteral(resourceName: "ic-favorite"))

        viewControllers = [homeNavigationController,
                           mapNavigationController, favoriteNavigationController]
        tabBar.tintColor = #colorLiteral(red: 0.10909646, green: 0.2660153806, blue: 0.2814711332, alpha: 1)
        tabBar.backgroundColor = UIColor.white
        tabBar.isTranslucent = false
        tabBar.clipsToBounds = true
    }
}
