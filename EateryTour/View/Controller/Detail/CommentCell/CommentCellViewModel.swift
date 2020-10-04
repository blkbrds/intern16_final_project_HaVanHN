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

    init(imageURL: String, name: String, createdAt: String, text: String) {
        self.imageURL = imageURL
        self.name = name
        self.createdAt = createdAt
        self.text = text
    }
}
