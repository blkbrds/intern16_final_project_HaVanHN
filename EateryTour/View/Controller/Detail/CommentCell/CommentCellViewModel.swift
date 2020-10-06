//
//  CommentCellViewModel.swift
//  EateryTour
//
//  Created by NganHa on 10/4/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

final class CommentCellViewModel {

    var imageURL: String
    var name: String
    var createdAt: Int
    var text: String

    init(comment: Comment) {
        self.imageURL = comment.photoURL
        self.name = "\(comment.firstName) \(comment.lastName)"
        self.createdAt = comment.createdAt
        self.text = comment.text
    }

    func formatCreatedAtDate() -> String {
        let date = Date(timeIntervalSince1970: Double(createdAt))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
