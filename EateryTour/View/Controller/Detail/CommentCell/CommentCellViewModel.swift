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
    var createdAt: String
    var text: String

    init(comment: Comment) {
        self.imageURL = comment.photoURL
        self.name = "\(comment.firstName) \(comment.lastName)"
        self.createdAt = String(comment.createdAt)
        self.text = comment.text
    }
}
