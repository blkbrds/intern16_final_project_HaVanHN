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
    var phone: String = ""
    var distance: Float = 0.0
    var tier: Int = 0
    var rating: Float = 0.0
    var isLoadApiCompleted: Bool = false
    var contact: String = ""

    init?(map: Map) {
    }

    func mapping(map: Map) {
        id <- map["venue.id"]
        name <- map["venue.name"]
        lat <- map["venue.location.lat"]
        lng <- map["venue.location.lng"]
        formattedAddress <- map["venue.location.formattedAddress"]
        phone <- map["venue.contact.phone"]
        distance <- map["venue.location.distance"]
        tier <- map["venue.price.tier"]
        rating <- map["venue.rating"]
        contact <- map["venue.contact.phone"]
    }
}
