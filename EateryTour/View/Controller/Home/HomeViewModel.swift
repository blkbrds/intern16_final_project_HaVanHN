//
//  HomeViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/10/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

final class HomeViewModel: ViewModel {

    // MARK: - Properties
    private(set) var imageListSlide: [UIImage] = [#imageLiteral(resourceName: "slideFood3"), #imageLiteral(resourceName: "slideFood1"), #imageLiteral(resourceName: "slideFood4"), #imageLiteral(resourceName: "slideFood5"), #imageLiteral(resourceName: "slideFood2")]
    private(set) var restaurants: [Restaurant] = []

    // MARK: - Public functions
    func getImageForSlide(atIndexPath indexPath: IndexPath) -> SlideCellViewModel? {
        return SlideCellViewModel(image: imageListSlide[indexPath.row])
    }

    func getTrendingRestaurant(limit: Int, completion: @escaping APICompletion) {
        if let lat = LocationManager.shared.currentLatitude,
            let lng = LocationManager.shared.currentLongitude {
            let locationString = String(lat) + "," + String(lng)
            print(locationString)
            let params = Api.Trending.QueryParams(query: "restaurant", location: locationString, limit: String(limit))
            Api.Trending.getTrending(params: params) { result in
                switch result {
                case .success(let rest):
                    self.restaurants = rest
                    completion(.success)
                case .failure(let err):
                    completion(.failure(err))
                }
            }
        }
    }

    func updateApiSuccess(newRestaurant: Restaurant) {
        for (index, restaurant) in restaurants.enumerated() where restaurant.id == newRestaurant.id {
            restaurants[index] = newRestaurant
        }
    }

    func getCellForRowAt(atIndexPath indexPath: IndexPath) -> TrendingCellViewModel {
        return TrendingCellViewModel(restaurant: restaurants[indexPath.row])
    }

    func numberOfItems(inSection section: Int) -> Int {
        return restaurants.count
    }
}
