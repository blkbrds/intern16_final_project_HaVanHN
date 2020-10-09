//
//  MapViewModel.swift
//  EateryTour
//
//  Created by NganHa on 10/9/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

final class MapViewModel: ViewModel {

    private(set) var restaurants: [Restaurant]?

    func exploringRestaurant(radius: String, completion: @escaping APICompletion) {
        if let lat = LocationManager.shared.currentLatitude,
            let lng = LocationManager.shared.currentLongitude {
            let locationString = String(lat) + "," + String(lng)
            let params = Api.Map.QueryParams(radius: radius, query: "restaurant", location: locationString)
            Api.Map.exploring(params: params) { result in
                switch result {
                case .success(let restaurants):
                    self.restaurants = restaurants
                    completion(.success)
                case .failure(let err):
                    completion(.failure(err))
                }
            }
        }
    }

    func loadMoreInformation(index: Int, completion: @escaping APICompletion) {
        guard let restaurants = restaurants else { return }
        Api.Detail.getDetail(restaurantId: restaurants[index].id) { result in
            switch result {
            case .success(let data):
                restaurants[index].isLoadApiCompleted = true
                restaurants[index].summaryLikes = data.sumaryLikes
                restaurants[index].bestPhotoURL = data.bestPhoto
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
