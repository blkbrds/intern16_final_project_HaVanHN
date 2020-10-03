//
//  TrendingCellViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/21/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

final class TrendingCellViewModel {

//    var id: String = ""
//    var name: String = ""
//    var address: String = ""
//    var lat: Float = 0.0
//    var lng: Float = 0.0
//    var city: String = ""
//    var rating: Float = 0.0
//    var currency: String = ""
//    var image: String = ""
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
                this.detail?.rating = data.rating
                this.detail?.currency = data.currency
                this.detail?.sumaryLikes = data.sumaryLikes
                this.restaurant?.isLoadApiCompleted = true
                this.restaurant?.image = data.bestPhoto
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
