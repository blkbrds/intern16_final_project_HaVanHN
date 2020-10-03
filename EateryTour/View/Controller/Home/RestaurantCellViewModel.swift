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
                this.detail?.sumaryLikes = data.sumaryLikes
                this.detail?.comments = data.comments
                this.detail?.bestPhoto = data.bestPhoto
                this.detail?.openDate = data.openDate
                this.detail?.openTime = data.openTime
                this.detail?.isOpen = data.isOpen
                this.restaurant?.isLoadApiCompleted = true
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getAddressAndCurrencyLabel() -> String {
        guard let restaurant = restaurant else { return "" }
        return "\(restaurant.formattedAddress.first ?? "Unknow address") - \(restaurant.currency)"
    }
}
