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
    private(set) var lat: Float
    private(set) var lng: Float
    private(set) var name: String
    private(set) var address: String
    private(set) var contact: String

    init(openToday: String, openHours: String, lat: Float, lng: Float, name: String, address: String, contact: String) {
        self.openToday = openToday
        self.openHours = openHours
        self.lat = lat
        self.lng = lng
        self.name = name
        self.address = address
        self.contact = contact
    }
}
