//
//  AppDelegate.swift
//  EateryTour
//
//  Created by Khoa Vo T.A. on 9/7/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit
import SVProgressHUD

enum RootType {
    case tutorial
    case tabbar
}

let ud = UserDefaults.standard
let screenSize = UIScreen.main.bounds
typealias HUD = SVProgressHUD

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
        configHUD()
        return true
    }

    private func configHUD() {
        HUD.setDefaultMaskType(.clear)
    }

    private func configWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        if Session.shared.secondUse {
            setRoot(rootType: .tabbar)
        } else {
            setRoot(rootType: .tutorial)
        }
        let vc = TutorialViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }

    func setRoot(rootType: RootType) {
        switch rootType {
        case .tutorial:
            window?.rootViewController = TutorialViewController()
        case .tabbar:
            window?.rootViewController = TabbarViewController()
        }
    }
}
