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

    dynamic var id: String = ""
    dynamic var sumaryLikes: String = ""
    dynamic var bestPhoto: String = ""
    dynamic var openDate: String = ""
    dynamic var openTime: String = ""
    dynamic var openState: String = ""
    dynamic var comments: [Comment] = []

    init?(map: Map) {
    }

    required init() {
    }

    func mapping(map: Map) {
        id <- map["response.venue.id"]
        sumaryLikes <- map["response.venue.likes.summary"]
        var prefix: String = ""
        var suffix: String = ""
        var width: Int = 0
        var height: Int = 0
        var groups: JSArray = [[:]]
        prefix <- map["response.venue.bestPhoto.prefix"]
        suffix <- map["response.venue.bestPhoto.suffix"]
        width <- map["response.venue.bestPhoto.width"]
        height <- map["response.venue.bestPhoto.height"]
        bestPhoto = prefix + "\(width)x\(height)" + suffix
        openState <- map["response.venue.hours.status"]
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
        groups <- map["response.venue.tips.groups"]
        let groupSecond = groups[1]
        guard let commentList = groupSecond["items"] as? JSArray else { return }
        comments = Mapper<Comment>().mapArray(JSONArray: commentList)
    }

    override class func primaryKey() -> String? {
        return "id"
    }
}
