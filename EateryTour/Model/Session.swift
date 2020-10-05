//
//  App.swift
//  FinalProject
//
//  Created by Bien Le Q. on 8/26/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation

final class Session {

    static let shared = Session()

    private init() {}

    var secondUse: Bool {
        get {
            return ud.bool(forKey: App.UserDefaultKeys.secondUse)
        }
        set {
            ud.set(newValue, forKey: App.UserDefaultKeys.secondUse)
        }
    }

}

// MARK: - Protocol
protocol SessionProtocol: class {
}
