//
//  TrendingCellViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/21/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import RealmSwift

final class RestaurantCellViewModel {

    var detail: Detail?
    var restaurant: Restaurant?
    var favorite: Bool = false

    init( restaurant: Restaurant? = nil, favorite: Bool = false) {
        self.restaurant = restaurant
        self.favorite = favorite
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
        if restaurant.address != "" {
            return "\(restaurant.address) - \(price)"
        } else {
            return "Unknown address - \(price)"
        }
    }

    func formatDistance() -> String {
        guard let restaurant = restaurant else { return "" }
        let distanceString: String = String(format: "%.2f", restaurant.distance / 1_000)
        if distanceString.contains(".00") {
            return String(Int(restaurant.distance / 1_000)) + " km"
        }
        return String(format: "%.2f", restaurant.distance / 1_000) + " km"
    }

    func checkIsFavorite() -> Bool {
        guard let restaurant = restaurant else { return false }
        do {
            let realm = try Realm()
            let predicate = NSPredicate(format: "id = %@", restaurant.id)
            let filterPredicateRestaurant = realm.objects(Restaurant.self).filter(predicate)
            if filterPredicateRestaurant.first != nil {
                favorite = true
                return favorite
            }
            favorite = false
            return false
        } catch {
            favorite = false
            print("can't fetch data")
            return favorite
        }
    }
}
