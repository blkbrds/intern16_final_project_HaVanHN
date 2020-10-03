//
//  Detail.swift
//  EateryTour
//
//  Created by NganHa on 9/23/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

@objcMembers final class Detail: Object, Mappable {

    // MARK: - Properties
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var address: String =  ""
    dynamic var lat: Float = 0.0
    dynamic var lng: Float = 0.0
    dynamic var state: String = ""
    dynamic var country: String = ""
    dynamic var currency: String = ""
    dynamic var sumaryLikes: String = ""
    dynamic var rating: Float = 0.0
    dynamic var bestPhoto: String = ""
    dynamic var openDate: String = ""
    dynamic var openTime: String = ""
    dynamic var isOpen: Bool = false
    dynamic var openStatus: String = ""
    dynamic var amoutOfLikes: String = ""
    dynamic var isFavorite: Bool = false

    // MARK: - Initialize
    init?(map: Map) {
    }

    required init() {
    }

    // MARK: - Override functions
    override static func primaryKey() -> String? {
        return "id"
    }

    // MARK: - Public functions
    func mapping(map: Map) {
        id <- map["response.venue.id"]
        name <- map["response.venue.name"]
        address <- map["response.venue.location.address"]
        lat <- map["response.venue.location.lat"]
        lng <- map["response.venue.location.lng"]
        state <- map["response.venue.location.state"]
        country <- map["response.venue.location.country"]
        currency <- map["response.venue.price.currency"]
        sumaryLikes <- map["response.venue.likes.summary"]
        rating <- map["response.venue.rating"]
        var prefix: String = ""
        var suffix: String = ""
        var width: Int = 0
        var height: Int = 0
        prefix <- map["response.venue.bestPhoto.prefix"]
        suffix <- map["response.venue.bestPhoto.suffix"]
        width <- map["response.venue.bestPhoto.width"]
        height <- map["response.venue.bestPhoto.height"]
        bestPhoto = prefix + "\(width)x\(height)" + suffix
        isOpen <- map["response.venue.hours.isOpen"]
        var timeFrames: JSArray = [[:]]
        timeFrames <- map["response.venue.hours.timeframes"]
        if let firstTimeFrames = timeFrames.first {
            guard let openDays: String = firstTimeFrames["days"] as? String else { return }
            openDate = openDays
            guard let open: JSArray = firstTimeFrames["open"] as? JSArray else { return }
            if let firstElement: JSObject = open.first {
                if let time = firstElement["renderedTime"] as? String {
                    openTime = time
                }
            }
        }
        openStatus <- map["response.venue.hours.status"]
        amoutOfLikes <- map["response.venue.likes.summary"]
    }
}
