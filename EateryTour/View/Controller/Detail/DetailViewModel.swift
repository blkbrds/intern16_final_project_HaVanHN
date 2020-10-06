//
//  DetailViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/27/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

enum DetailSection {
    case information
    case map
    case photo
    case comment
}

final class DetailViewModel: ViewModel {

    private var photoList: [Photo] = []
    private var detail: Detail?
    private(set) var restaurant: Restaurant?
    private var isFavorite: Bool = false

    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }

    func sectionType(atSection section: Int) -> DetailSection {
        switch section {
        case 0:
            return .information
        case 1:
            return .map
        case 2:
            return .photo
        case 3:
            return .comment
        default:
            return .photo
        }
    }

    func getDataForCellPhoto(completion: @escaping APICompletion) {
        let params = Api.Photo.QueryParams(limit: 20)
        guard let restaurant = restaurant else { return }
        Api.Photo.getPhoto(params: params, restaurantId: restaurant.id) { [weak self] result in
            guard let this = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    this.photoList = data
                    completion(.success)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getInformation(completion: @escaping APICompletion) {
        guard let restaurant = restaurant else { return }
        Api.Detail.getDetail(restaurantId: restaurant.id) { [weak self] result in
            guard let this = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    this.detail = data
                    completion(.success)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func formatPrice() -> String {
        guard let restaurant = restaurant else { return "$" }
        switch restaurant.tier {
        case 1:
            return "$"
        case 2:
            return "$$"
        case 3:
            return "$$$"
        default:
            return "$$$"
        }
    }

    func formatAddress() -> String {
        guard let restaurant = restaurant, restaurant.address != "" else { return "Not update yet" }
        return restaurant.address
    }

    func getCellForRowAtInformationSection(atIndexPath indexPath: IndexPath) -> InformationCellViewModel? {
        if let restaurant = restaurant, let detail = detail {
            return InformationCellViewModel(imageURL: detail.bestPhoto,
                                            name: restaurant.name, price: formatPrice(),
                                            address: formatAddress(), rating: restaurant.rating,
                                            amountOfRating: detail.sumaryLikes, isFavorite: checkIsFavorite())
        } else {
            return nil
        }
    }

    func getCellForRowAtMapSection(atIndexPath indexPath: IndexPath) -> MapCellViewModel? {
        if let restaurant = restaurant, let detail = detail {
            var newContact: String = restaurant.contact
            if newContact == "" {
                newContact = "Not updated yet"
            }
            var newOpenState: String = detail.openState
            if newOpenState == "" {
                newOpenState = "Not updated yet"
            }
            var newOpenHours: String = detail.openDate + " " + detail.openTime
            if newOpenHours == " " {
                newOpenHours = "Not updated yet"
            }
            return MapCellViewModel(openToday: newOpenState,
                                    openHours: newOpenHours,
                                    lat: restaurant.lat, lng: restaurant.lng,
                                    name: restaurant.name,
                                    address: formatAddress(),
                                    contact: newContact)
        } else {
            return nil
        }
    }

    func getCellForRowAtPhotoSection(atIndexPath indexPath: IndexPath) -> PhotoCollectionCellViewModel? {
        var imageURLList: [String] = []
        for photo in photoList {
            imageURLList.append(photo.imageURL)
        }
        return PhotoCollectionCellViewModel(imageURLList: imageURLList)
    }

    func getCellForRowAtCommentSection(atIndexPath indexPath: IndexPath) -> CommentCellViewModel? {
        guard let comments: [Comment] = detail?.comments else { return nil }
        guard 0 <= indexPath.row && indexPath.row < comments.count else { return nil }
        return CommentCellViewModel(comment: comments[indexPath.row])
    }

    func getheightForRowAt(atIndexPath indexPath: IndexPath) -> CGFloat {
        switch sectionType(atSection: indexPath.section) {
        case .information:
            return UITableView.automaticDimension
        case .map:
            return 280
        case .photo:
            return 200
        case .comment:
            return UITableView.automaticDimension
        }
    }

    func numberOfItems(inSection section: Int) -> Int {
        switch sectionType(atSection: section) {
        case .information:
            return 1
        case .map:
            return 1
        case .photo:
            return 1
        case .comment:
            guard let comments = detail?.comments else { return 5 }
            return comments.count
        }
    }

    func changeDataRealm(completion: @escaping APICompletion) {
        guard let restaurant = restaurant else { return }
        do {
            let realm = try Realm()
            let predicate = NSPredicate(format: "id = %@", restaurant.id)
            let filterPredicateDetail = realm.objects(Detail.self).filter(predicate)
            let filterPredicateRestaurant = realm.objects(Restaurant.self).filter(predicate)
            if let favoriteRestaurant = filterPredicateRestaurant.first, let favoriteDetail = filterPredicateDetail.first {
                try realm.write {
                    realm.delete(favoriteDetail)
                    realm.delete(favoriteRestaurant)
                    completion(.success)
                }
            } else {
                try realm.write {
                    if let detail = detail {
                        realm.create(Detail.self, value: detail, update: .all)
                        realm.create(Restaurant.self, value: restaurant, update: .all)
                        completion(.success)
                    }
                }
            }
        } catch {
            completion(.failure(error))
        }
    }

    func checkIsFavorite() -> Bool {
        guard let restaurant = restaurant else { return false }
        do {
            let realm = try Realm()
            let predicate = NSPredicate(format: "id = %@", restaurant.id)
            let filterPredicateRestaurant = realm.objects(Restaurant.self).filter(predicate)
            let filterPredicateDetail = realm.objects(Detail.self).filter(predicate)
            if filterPredicateRestaurant.first != nil, filterPredicateDetail.first != nil {
                return true
            }
            return false
        } catch {
            print("can't fetch data")
            return false
        }
    }
}
