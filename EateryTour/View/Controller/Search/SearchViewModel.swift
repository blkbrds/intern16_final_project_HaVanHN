//
//  SearchViewModel.swift
//  EateryTour
//
//  Created by NganHa on 10/7/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

final class SearchViewModel: ViewModel {

    var restaurants: [RestaurantSearching]?

    func numberOfItems(inSection section: Int) -> Int {
        guard let restaurants = restaurants  else { return 0 }
        return restaurants.count
    }

    func getCellForRowAt(atIndexPath indexPath: IndexPath) -> SearchCellViewModel? {
        guard let restaurants = restaurants else { return nil }
        guard 0 <= indexPath.row && indexPath.row < restaurants.count else { return nil }
        return SearchCellViewModel(restaurant: restaurants[indexPath.row])
    }

    func getRestaurantsForSearching(queryString: String, completion: @escaping APICompletion) {
        if let lat = LocationManager.shared.currentLatitude,
           let lng = LocationManager.shared.currentLongitude {
            let locationString = String(lat) + "," + String(lng)
            let params = Api.Search.QueryParams(location: locationString, query: "restaurant" + queryString)
            Api.Search.searching(params: params) { [weak self] result in
                guard let this = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let restaurants):
                        this.restaurants = restaurants
                        completion(.success)
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }

    func updateApiSuccess(newRestaurant: RestaurantSearching) {
        guard var restaurants = restaurants else { return }
        for (index, restaurant) in restaurants.enumerated() where restaurant.id == newRestaurant.id {
            restaurants[index] = newRestaurant
            self.restaurants = restaurants
        }
    }
}
