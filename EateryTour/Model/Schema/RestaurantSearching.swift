//
//  RestaurantSearching.swift
//  EateryTour
//
//  Created by NganHa on 10/8/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import ObjectMapper

final class RestaurantSearching: Mappable {

    private(set) var id: String = ""
    private(set) var name: String = ""
    private(set) var contact: String = ""
    private(set) var address: String = ""
    private(set) var lat: Float = 0.0
    private(set) var lng: Float = 0.0
    private(set) var distance: Int = 0

    init?(map: Map) {
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        contact <- map["contact.phone"]
        address <- map["location.address"]
        lat <- map["location.lat"]
        lng <- map["location.lng"]
        distance <- map["location.distance"]
    }
}
