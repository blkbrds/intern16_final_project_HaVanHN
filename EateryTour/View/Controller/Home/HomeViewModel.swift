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

enum HomeSectionType {
    case trending
    case recommend
}

final class HomeViewModel: ViewModel {

    // MARK: - Properties
    private(set) var restaurantsTrending: [Restaurant] = []
    private(set) var restaurantsRecommend: [Restaurant] = []

    // MARK: - Public functions

    func getTrendingRestaurant(limit: Int, completion: @escaping APICompletion) {
        if let lat = LocationManager.shared.currentLatitude,
            let lng = LocationManager.shared.currentLongitude {
            let locationString = String(lat) + "," + String(lng)
            print(locationString)
            let params = Api.Trending.QueryParams(query: "restaurant", location: locationString, limit: String(limit))
            Api.Trending.getTrending(params: params) { result in
                switch result {
                case .success(let rest):
                    print("data: \(rest.count)")
                    self.restaurantsTrending = rest
                    completion(.success)
                case .failure(let err):
                    completion(.failure(err))
                }
            }
        }
    }

    func getCellForRowAt(atIndexPath indexPath: IndexPath) -> CellViewModel {
        switch sectionType(inSection: indexPath.section) {
        case .trending:
            print("trendingRestaurant: \(restaurantsTrending)")
            return CellViewModel(restaurants: restaurantsTrending)
        case .recommend:
            return CellViewModel(restaurants: restaurantsRecommend)
        }
    }

    func viewModelForItemAt(indexPath: IndexPath) -> CellViewModel {
        return CellViewModel(restaurants: restaurantsTrending)
    }

    func sectionType(inSection section: Int) -> HomeSectionType {
        switch section {
        case 0:
            return .trending
        case 1:
            return .recommend
        default:
            return .recommend
        }
    }

    func viewForHeaderInSection(inSection section: Int) -> CustomHeaderViewModel? {
        switch sectionType(inSection: section) {
        case .trending:
            return CustomHeaderViewModel(name: "Trending")
        case .recommend:
            return CustomHeaderViewModel(name: "Recommend")
        }
    }

    func numberOfRowInSection(inSection section: Int) -> Int {
        switch sectionType(inSection: section) {
        case .trending:
            return 1
        case .recommend:
            return 20
        }
    }

    func heightForRowAt(atIndexPath indexPath: IndexPath) -> CGFloat {
        switch sectionType(inSection: indexPath.section) {
        case .trending:
            return 260
        case .recommend:
            return 120
        }
    }
}
