//
//  Restaurant.swift
//  EateryTour
//
//  Created by NganHa on 9/17/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import ObjectMapper

final class Restaurant: Mappable {

    var id: String = ""
    var name: String = ""
    var address: String = ""
    var lat: Float = 0.0
    var lng: Float = 0.0
    var distance: Int = 0
    var city: String = ""

    init?(map: Map) {
    }

    func mapping(map: Map) {
        id <- map["venue.id"]
        name <- map["venue.name"]
        address <- map["venue.location.address"]
        lat <- map["venue.location.lat"]
        lng <- map["venue.location.lng"]
        distance <- map["location.distance"]
        city <- map["location.city"]
    }
}
