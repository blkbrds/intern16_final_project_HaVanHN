//
//  CustomHeaderViewModel.swift
//  EateryTour
//
//  Created by NganHa on 10/1/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

final class CustomHeaderViewModel: ViewModel {

    // MARK: - Properties
    private(set) var name: String

    // MARK: - Initialize
    init(name: String) {
        self.name = name
    }
}
