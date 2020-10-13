//
//  CommentCellViewModel.swift
//  EateryTour
//
//  Created by NganHa on 10/4/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

final class CommentCellViewModel: ViewModel {

    private(set) var imageURL: String
    private(set) var name: String
    private(set) var createdAt: Int
    private(set) var text: String

    init(comment: Comment) {
        self.imageURL = comment.photoURL
        self.name = "\(comment.firstName) \(comment.lastName)"
        self.createdAt = comment.createdAt
        self.text = comment.text
    }

    func formatCreatedAtDate() -> String {
        let date = Date(timeIntervalSince1970: Double(createdAt))
        let dateFormatter = DateFormatter()
        // Set timezone that you want
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        // Specify your format that you want
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
