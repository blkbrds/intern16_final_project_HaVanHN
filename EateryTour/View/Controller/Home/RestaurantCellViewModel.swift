//
//  TrendingCellViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/21/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

final class RestaurantCellViewModel {

    var detail: Detail?
    var restaurant: Restaurant?

    init( restaurant: Restaurant? = nil) {
        self.restaurant = restaurant
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
                restaurant.isLoadApiCompleted = true
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func formatAddresAndPrice() -> String {
        guard let restaurant = restaurant else { return "" }
        var price: String = ""
        switch restaurant.tier {
        case 1:
            price = "$"
        case 2:
            price = "$$"
        default:
            price = "$$$"
        }
        return "\(restaurant.formattedAddress.first ?? "Unknow address") - \(price)"
    }

    func formatDistance() -> String {
        guard let restaurant = restaurant else { return "" }
        let distanceString: String = String(format: "%.2f", restaurant.distance / 1_000)
        if distanceString.contains(".00") {
            return String(Int(restaurant.distance / 1_000)) + " km"
        }
        return String(format: "%.2f", restaurant.distance / 1_000) + " km"
    }

//    func formatRating() -> String {
//        guard let restaurant = restaurant else { return "" }
//        if restaurant.rating
//    }
}
