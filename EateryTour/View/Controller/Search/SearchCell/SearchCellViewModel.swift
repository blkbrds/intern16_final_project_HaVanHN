//
//  SearchCellViewModel.swift
//  EateryTour
//
//  Created by NganHa on 10/8/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

final class SearchCellViewModel {
    private(set) var restaurant: RestaurantSearching?
    private(set) var detail: Detail?

    init(restaurant: RestaurantSearching) {
        self.restaurant = restaurant
    }

    func formatAddress() -> String {
        guard let restaurant = restaurant else { return "unknown address" }
        if restaurant.address == "" {
            return "uknown address"
        } else {
            return restaurant.address
        }
    }

    func getMoreInformationForCell(completion: @escaping APICompletion) {
        guard let restaurant = restaurant else { return }
        Api.Detail.getDetail(restaurantId: restaurant.id) { [weak self] result in
            DispatchQueue.main.async {
                guard let this = self else { return }
                switch result {
                case .success(let detail):
                    this.detail = detail
                    completion(.success)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
