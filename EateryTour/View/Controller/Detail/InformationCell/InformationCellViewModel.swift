//
//  InformationCellViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/27/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import RealmSwift

final class InformationCellViewModel: ViewModel {

    private(set) var imageURL: String
    private(set) var name: String
    private(set) var price: String
    private(set) var address: String
    private(set) var rating: Float
    private(set) var amountOfRating: String
    private(set) var isFavorite: Bool

    init(imageURL: String, name: String, price: String, address: String, rating: Float, amountOfRating: String, isFavorite: Bool) {
        self.imageURL = imageURL
        self.name = name
        self.price = price
        self.address = address
        self.rating = rating
        self.amountOfRating = amountOfRating
        self.isFavorite = isFavorite
    }
}
