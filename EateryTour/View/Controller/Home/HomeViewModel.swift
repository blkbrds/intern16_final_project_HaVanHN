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

typealias CompletionResultRestaurant = (Bool) -> Void

final class HomeViewModel: ViewModel {

    // MARK: - Properties
    var imageListSlide: [UIImage] = [#imageLiteral(resourceName: "slideFood3"), #imageLiteral(resourceName: "slideFood1"), #imageLiteral(resourceName: "slideFood4"), #imageLiteral(resourceName: "slideFood5"), #imageLiteral(resourceName: "slideFood2")]
    var restaurants: [Restaurant] = []
    var location: CLLocation?

    // MARK: - Public functions
    func getImageForSlide(atIndexPath indexPath: IndexPath) -> SlideCellViewModel? {
        return SlideCellViewModel(image: imageListSlide[indexPath.row])
    }

    func getTrendingRestaurant(completion: @escaping CompletionResultRestaurant) {
        Api.Trending.getTrending { result in
            switch result {
            case .success(let rest):
                self.restaurants = rest
                completion(true)
            case .failure(let err):
                print(err.errorsString)
                completion(false)
            }
        }
    }

    func updateApiSuccess(newRestaurant: Restaurant) {
        for (index, restaurant) in restaurants.enumerated() where restaurant.id == newRestaurant.id {
            restaurants[index].isLoadApiCompleted = newRestaurant.isLoadApiCompleted
            restaurants[index].image = newRestaurant.image
        }
    }

    func getCellForRowAt(atIndexPath indexPath: IndexPath) -> TrendingCellViewModel {
        return TrendingCellViewModel(restaurant: restaurants[indexPath.row])
    }
}
