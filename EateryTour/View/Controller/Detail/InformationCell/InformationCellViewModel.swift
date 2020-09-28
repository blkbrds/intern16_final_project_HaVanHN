//
//  InformationCellViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/27/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

final class InformationCellViewModel {
    
    private(set) var imageURL: String
    private(set) var name: String
    private(set) var currency: String
    private(set) var address: String
    private(set) var rating: String
    private(set) var amountOfRating: String

    init(imageURL: String, name: String, currency: String, address: String, rating: String, amountOfRating: String) {
        self.imageURL = imageURL
        self.name = name
        self.currency = currency
        self.address = address
        self.rating = rating
        self.amountOfRating = amountOfRating
    }
}
