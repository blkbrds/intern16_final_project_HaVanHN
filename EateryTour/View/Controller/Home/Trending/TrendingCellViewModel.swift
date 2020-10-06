//
//  TrendingCellViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/21/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import CoreLocation

final class TrendingCellViewModel {

    var detail: Detail?
    var restaurant: Restaurant?

    init( restaurant: Restaurant? = nil) {
        self.restaurant = restaurant
        if let restaurantImage = restaurant?.image {
            self.detail?.bestPhoto = restaurantImage
        }
    }

    func loadMoreInformation(completion: @escaping APICompletion) {
        guard let restaurant = restaurant, !restaurant.isLoadApiCompleted  else {
            completion(.failure(Api.Error.invalid))
            return }
        Api.Detail.getDetail(restaurantId: restaurant.id) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                this.detail = data
                this.restaurant?.isLoadApiCompleted = true
                this.restaurant?.image = data.bestPhoto
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func calculateDistance() -> String {
        guard let userLocation = LocationManager.shared.currentLocation else { return "" }
        guard let detail = detail else { return "" }
        let restaurantLocation: CLLocation = CLLocation(latitude: CLLocationDegrees(detail.lat), longitude: CLLocationDegrees(detail.lng))
        let distance = userLocation.distance(from: restaurantLocation)
        let distanceKm = distance / 1_000
        return String(format: "%.2f", distanceKm) + " km"
    }

    func getAddressAndCurrency() -> String {
        guard let detail = detail else { return "" }
        return "\(detail.address), \(detail.country) - \(detail.currency)"
    }
}
