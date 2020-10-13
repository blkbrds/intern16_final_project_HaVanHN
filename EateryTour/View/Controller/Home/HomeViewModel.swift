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
import RealmSwift

enum HomeSectionType {
    case trending
    case recommend
}

final class HomeViewModel: ViewModel {

    // MARK: - Properties
    private var notificationToken: NotificationToken?
    private(set) var restaurantsTrending: [Restaurant] = []
    private(set) var restaurantsRecommend: [Restaurant] = []
    private var favoriteRestaurantsRecommend: [Restaurant] = []
    private(set) var detail: Detail?

    // MARK: - Public functions
    func getTrendingRestaurant(limit: Int, completion: @escaping APICompletion) {
        if let lat = LocationManager.shared.currentLatitude,
           let lng = LocationManager.shared.currentLongitude {
            let locationString = String(lat) + "," + String(lng)
            let params = Api.Trending.QueryParams(query: "restaurant", location: locationString, limit: String(limit))
            Api.Trending.getTrending(params: params) { result in
                switch result {
                case .success(let rest):
                    self.restaurantsTrending = rest
                    completion(.success)
                case .failure(let err):
                    completion(.failure(err))
                }
            }
        }
    }

    func getRecommendRestaurant(limit: Int, completion: @escaping APICompletion) {
        if let lat = LocationManager.shared.currentLatitude,
           let lng = LocationManager.shared.currentLongitude {
            let locationString = String(lat) + "," + String(lng)
            let params = Api.Recommend.QueryParams(section: "food", query: "restaurant", location: locationString, limit: String(limit), price: "2,3")
            Api.Recommend.getRecommend(params: params) { result in
                switch result {
                case .success(let rest):
                    self.restaurantsRecommend = rest
                    completion(.success)
                case .failure(let err):
                    completion(.failure(err))
                }
            }
        }
    }

    func getCellTrendingForRowAt(atIndexPath indexPath: IndexPath) -> TrendingCollectionCellViewModel? {
        return TrendingCollectionCellViewModel(restaurants: restaurantsTrending)
    }

    func getCellRecommendForRowAt(atIndexPath indexPath: IndexPath) -> RestaurantCellViewModel? {
        guard 0 <= indexPath.row && indexPath.row < restaurantsRecommend.count else { return nil }
        return RestaurantCellViewModel(restaurant: restaurantsRecommend[indexPath.row])
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
            return CustomHeaderViewModel(name: "Popular")
        case .recommend:
            return CustomHeaderViewModel(name: "Recommend")
        }
    }

    func numberOfRowInSection(inSection section: Int) -> Int {
        switch sectionType(inSection: section) {
        case .trending:
            return 1
        case .recommend:
            return restaurantsRecommend.count
        }
    }

    func heightForRowAt(atIndexPath indexPath: IndexPath) -> CGFloat {
        switch sectionType(inSection: indexPath.section) {
        case .trending:
            return 300
        case .recommend:
            return UITableView.automaticDimension
        }
    }

    func updateApiSuccess(newRestaurant: Restaurant) {
        for (index, restaurant) in restaurantsRecommend.enumerated() where restaurant.id == newRestaurant.id {
            restaurantsRecommend[index] = newRestaurant
        }
    }

    func pushDataToDetailVC(atIndexPath indexPath: IndexPath) -> DetailViewModel? {
        guard indexPath.row >= 0 && indexPath.row < restaurantsTrending.count || indexPath.row < restaurantsRecommend.count else { return nil }
        switch sectionType(inSection: indexPath.section) {
        case .trending:
            return DetailViewModel(restaurant: restaurantsTrending[indexPath.row])
        case .recommend:
            return DetailViewModel( restaurant: restaurantsRecommend[indexPath.row])
        }
    }

    func getDataFromRealm(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let filterPredicateRestaurant = realm.objects(Restaurant.self)
            favoriteRestaurantsRecommend = Array(filterPredicateRestaurant)
            completion(.success)
        } catch {
            print("Can't fetch data from Realm")
            completion(.failure(error))
        }
    }

    func setupObserver(completion: @escaping () -> Void) {
        do {
            let realm = try Realm()
            notificationToken = realm.objects(Restaurant.self).observe({ [weak self] _ in
                guard let this = self else { return }
                this.getDataFromRealm { _ in
                    completion()
                }
            })
        } catch { }
    }

    func changeFavoriteRestaurant(withId id: String, completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let predicate = NSPredicate(format: "id = %@", id)
            let result = realm.objects(Restaurant.self).filter(predicate)
            if let restaurant = result.first {
                try realm.write {
                    realm.delete(restaurant)
                    completion(.success)
                }
            } else {
                try realm.write {
                    for restaurant in restaurantsRecommend where restaurant.id == id {
                        realm.create(Restaurant.self, value: restaurant, update: .all)
                    }
                    completion(.success)
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
