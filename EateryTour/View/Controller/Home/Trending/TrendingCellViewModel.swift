//
//  TrendingCellViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/21/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

final class TrendingCellViewModel {

    var id: String?
    var name: String?
    var address: String?
    var lat: Float?
    var lng: Float?
    var city: String?
    var rating: Float?
    var currency: String?
    var image: String?
    var isCallAPI: Bool = false

    init(id: String, name: String, address: String, lat: Float, lng: Float, city: String) {
        self.id = id
        self.name = name
        self.address = address
        self.lat = lat
        self.lng = lng
        self.city = city
    }

    func loadMoreInformation(completion: @escaping CompletionResultRestaurant) {
        guard let newId = id else {
            completion(false)
            return }
        Api.Detail.getDetail(restaurantId: newId) { result in
            switch result {
                case .success(let data):
                    self.rating = data.rating
                    self.currency = data.currency
                    self.image = data.bestPhoto
                    self.isCallAPI = true
                completion(true)
                case .failure(_):
                    completion(false)
            }
        }
    }
}
