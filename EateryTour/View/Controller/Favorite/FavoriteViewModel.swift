//
//  FavoriteViewModel.swift
//  EateryTour
//
//  Created by NganHa on 10/6/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import RealmSwift

final class FavoriteViewModel: ViewModel {

    private var notificationToken: NotificationToken?
    private(set) var restaurants: [Restaurant]?
    private(set) var details: [Detail]?

    func numberOfItems(inSection section: Int) -> Int {
        guard let restaurants = restaurants else { return 0 }
        return restaurants.count
    }

    func getCellForRowAt(atIndexPath indexPath: IndexPath) -> RestaurantCellViewModel? {
        guard let restautantList = restaurants else { return nil }
        guard 0 < restautantList.count && restautantList.count > indexPath.row else { return nil }
        return RestaurantCellViewModel(restaurant: restautantList[indexPath.row])
    }

    func getDataFromRealm(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let filterPredicateRestaurant = realm.objects(Restaurant.self)
            restaurants = Array(filterPredicateRestaurant)
            completion(.success)
        } catch {
            print("Can't fetch data from Realm")
            completion(.failure(error))
        }
    }

    func deleteFavoriteRestaurant(withId id: String, completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let predicate = NSPredicate(format: "id = %@", id)
            let result = realm.objects(Restaurant.self).filter(predicate)
            try realm.write {
                realm.delete(result)
                completion(.success)
            }
        } catch {
            completion(.failure(error))
        }
    }

    func deleteAllFavoriteRestaurant(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let result = realm.objects(Restaurant.self)
            try realm.write {
                realm.delete(result)
                completion(.success)
            }
        } catch {
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
}
