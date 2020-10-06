//
//  Restaurant.swift
//  EateryTour
//
//  Created by NganHa on 9/17/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

@objcMembers final class Restaurant: Object, Mappable {

    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var lat: Float = 0.0
    dynamic var lng: Float = 0.0
    dynamic var address: String = ""
    dynamic var phone: String = ""
    dynamic var distance: Float = 0.0
    dynamic var tier: Int = 0
    dynamic var rating: Float = 0.0
    dynamic var isLoadApiCompleted: Bool = false
    dynamic var contact: String = ""

    init?(map: Map) {
    }

    required init() {
    }

    func mapping(map: Map) {
        id <- map["venue.id"]
        name <- map["venue.name"]
        lat <- map["venue.location.lat"]
        lng <- map["venue.location.lng"]
        var formattedAddress: [String] = []
        formattedAddress <- map["venue.location.formattedAddress"]
        if let address = formattedAddress.first {
            self.address = address
        }
        phone <- map["venue.contact.phone"]
        distance <- map["venue.location.distance"]
        tier <- map["venue.price.tier"]
        rating <- map["venue.rating"]
        contact <- map["venue.contact.phone"]
    }

    override class func primaryKey() -> String? {
        return "id"
    }
}
