//
//  RecommendCellViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/28/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

final class TrendingCollectionCellViewModel: ViewModel {

    // MARK: - Properties
    var restaurants: [Restaurant]

    // MARK: - Initialize
    init(restaurants: [Restaurant] = []) {
        self.restaurants = restaurants
    }

    // MARK: - Public functions
    func getCellForRowAt(atIndexPath indexPath: IndexPath) -> RestaurantCellViewModel? {
        return RestaurantCellViewModel(restaurant: restaurants[indexPath.row])
    }

    func numberOfRowInSection() -> Int {
        return restaurants.count
    }

    func updateApiSuccess(newRestaurant: Restaurant) {
        for (index, restaurant) in restaurants.enumerated() where restaurant.id == newRestaurant.id {
            restaurants[index] = newRestaurant
        }
    }
}
