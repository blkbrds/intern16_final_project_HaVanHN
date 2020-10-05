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

    private var id: String = ""
    private var photoList: [Photo] = []
    private var detail: Detail?
    private var restaurant: Restaurant?
    private var isFavorite: Bool = false

    init(id: String, detail: Detail, restaurant: Restaurant) {
        self.id = id
        self.detail = detail
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
        Api.Photo().getPhoto(params: params, restaurantId: id) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.photoList = data
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
        guard let restaurant = restaurant, let address: String = restaurant.formattedAddress.first else { return "Not update yet" }
        return address
    }

    func getCellForRowAtInformationSection(atIndexPath indexPath: IndexPath) -> InformationCellViewModel? {
        if let restaurant = restaurant, let detail = detail {
            return InformationCellViewModel(imageURL: detail.bestPhoto,
                                            name: restaurant.name, price: formatPrice(),
                                            address: formatAddress(), rating: restaurant.rating,
                                            amountOfRating: detail.sumaryLikes)
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

    func addDetailIntoRealm(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let predicate = NSPredicate(format: "id = %@", id)
            let filterPredicate = realm.objects(Detail.self).filter(predicate)
            if let favoriteDetail = filterPredicate.first {
                try realm.write {
                    favoriteDetail.isFavorite = !favoriteDetail.isFavorite
                    realm.create(Detail.self, value: favoriteDetail, update: .modified)
                    completion(.success)
                }
            } else {
                try realm.write {
                    if let detail = detail {
                        realm.create(Detail.self, value: detail, update: .all)
                        isFavorite = !isFavorite
                        completion(.success)
                    }
                }
            }
        } catch {
            completion(.failure(error))
        }
    }

    func checkIsFavorite() -> Bool? {
        do {
            let realm = try Realm()
            let predicate = NSPredicate(format: "id = %@", id)
            let filterPredicate = realm.objects(Detail.self).filter(predicate)
            if let favoriteDetail = filterPredicate.first {
                print("favorite: \(favoriteDetail.isFavorite)")
                return favoriteDetail.isFavorite
            }
        } catch {
            print("can't fetch data")
            return nil
        }
        return nil
}
}
