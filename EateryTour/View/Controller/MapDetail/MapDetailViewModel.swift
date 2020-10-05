//
//  MapDetailViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/30/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

final class MapDetailViewModel {

    private(set) var lat: Float
    private(set) var lng: Float

    init(lat: Float, lng: Float) {
        self.lat = lat
        self.lng = lng
    }
}
