//
//  AppDelegate.swift
//  EateryTour
//
//  Created by Khoa Vo T.A. on 9/7/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

enum RootType {
    case tutorial
    case tabbar
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static var shared: AppDelegate = {
        guard let shared = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can't cast UIApplication.shared.delegate to AppDelegate")
        }
        return shared
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configWindow()
        return true
    }

    private func configWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let secondUse = UserDefaults.standard.bool(forKey: "secondUse")
        print(secondUse)
        if secondUse {
            changeRoot(rootType: .tabbar)
        } else {
            changeRoot(rootType: .tutorial)
        }
        window?.makeKeyAndVisible()
    }

    func changeRoot(rootType: RootType) {
        switch rootType {
        case .tutorial:
            window?.rootViewController = TutorialViewController()
        case .tabbar:
            window?.rootViewController = TabbarViewController()
        }
    }
}
