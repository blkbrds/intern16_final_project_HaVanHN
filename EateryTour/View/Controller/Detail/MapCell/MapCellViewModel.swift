//
//  MapCellViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/27/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

final class MapCellViewModel {

    private(set) var openToday: String
    private(set) var openHours: String

    init(openToday: String, openHours: String) {
        self.openToday = openToday
        self.openHours = openHours
    }
}
