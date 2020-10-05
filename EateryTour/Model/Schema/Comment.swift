//
//  Comment.swift
//  EateryTour
//
//  Created by NganHa on 10/3/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import ObjectMapper

final class Comment: Mappable {
    var firstName: String = ""
    var lastName: String = ""
    var text: String = ""
    var photoURL: String = ""

    init?(map: Map) {
    }

    func mapping(map: Map) {
        firstName <- map["user.firstName"]
        lastName <- map["user.lastName"]
        text <- map["text"]
        var prefix: String = ""
        var suffix: String = ""
        prefix <- map["user.photo.prefix"]
        suffix <- map["user.photo.suffix"]
        photoURL = prefix + suffix
    }
}
