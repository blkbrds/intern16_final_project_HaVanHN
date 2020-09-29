//
//  Photo.swift
//  EateryTour
//
//  Created by NganHa on 9/29/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import ObjectMapper

final class Photo: Mappable {

    var imageURL: String = ""

    init?(map: Map) {
    }

    func mapping(map: Map) {
        var prefix: String = "defaultPrefix"
        var suffix: String = "defaultSuffix"
        var width: Int = 0
        var height: Int = 0
        prefix <- map["prefix"]
        suffix <- map["suffix"]
        width <- map["width"]
        height <- map["height"]
        imageURL = prefix + String(width) + "x" + String(height) + suffix
    }
}

final class PhotoBundle: Mappable {

    var photoList: [Photo] = []

    init?(map: Map) {
    }

    func mapping(map: Map) {
        photoList <- map["response.photos.items"]
    }
}
