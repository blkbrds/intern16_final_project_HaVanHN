//
//  TrendingCellViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/21/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

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
}
