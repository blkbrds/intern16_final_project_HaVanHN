//
//  Detail.swift
//  EateryTour
//
//  Created by NganHa on 9/23/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import ObjectMapper

final class Detail: Mappable {

    var name: String = ""
    var address: String =  ""
    var lat: String = ""
    var lng: String = ""
    var state: String = ""
    var country: String = ""
    var currency: String = ""
    var sumaryLikes: String = ""
    var rating: Float = 0.0
    var bestPhoto: String = ""
    var openDate: String = ""
    var openTime: String = ""
    var isOpen: Bool = false

    init?(map: Map) {
    }

    func mapping(map: Map) {
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
            guard let openDays: String = firstTimeFrames["days"] as? String else { fatalError() }
            openDate = openDays
            guard let open: JSArray = firstTimeFrames["open"] as? JSArray else { fatalError() }
            if let firstElement: JSObject = open.first {
                if let time = firstElement["renderedTime"] as? String {
                    openTime = time
                }
            }
        }
    }
}
