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
    var lat: Float = 0.0
    var lng: Float = 0.0
    var formattedAddress: [String] = []
    var distance: Float = 0.0
    var currency: String = ""
    var rating: Float = 0.0
    var isLoadApiCompleted: Bool = false

    init?(map: Map) {
    }

    func mapping(map: Map) {
        id <- map["venue.id"]
        name <- map["venue.name"]
        lat <- map["venue.location.lat"]
        lng <- map["venue.location.lng"]
        formattedAddress <- map["venue.location.formattedAddress"]
        distance <- map["venue.location.distance"]
        currency <- map["venue.price.currency"]
        rating <- map["venue.rating"]
    }
}
