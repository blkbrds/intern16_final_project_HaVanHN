//
//  DetailViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/27/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import UIKit

enum DetailSection {
    case information
    case map
    case photo
}

final class DetailViewModel {

    var id: String = ""
    var photoList: [Photo] = []
    var detail: Detail?

    func sectionType(atSection section: Int) -> DetailSection {
        switch section {
        case 0:
            return .information
        case 1:
            return .map
        case 2:
            return .photo
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

    func getCellForRowAtInformationSection(atIndexPath indexPath: IndexPath) -> InformationCellViewModel? {
        if let detail = detail {
            return InformationCellViewModel(imageURL: detail.bestPhoto,
                                            name: detail.name, currency: detail.currency,
                                            address: detail.address, rating: detail.rating,
                                            amountOfRating: detail.sumaryLikes)
        } else {
            return nil
        }
    }

    func getCellForRowAtMapSection(atIndexPath indexPath: IndexPath) -> MapCellViewModel? {
        guard let detail = detail else { return nil }
            if detail.openDate == "" && detail.openTime == "" {
                if detail.openStatus == "" {
                    return MapCellViewModel(openToday: "Not updated yet", openHours: "Not updated yet", lat: detail.lat, lng: detail.lng, name: detail.name, address: detail.address)
                }
            } else {
                return MapCellViewModel(openToday: detail.openStatus, openHours: detail.openDate + " " + detail.openTime, lat: detail.lat, lng: detail.lng, name: detail.name, address: detail.address)
            }
        return nil
    }

    func getCellForRowAtPhotoSection(atIndexPath indexPath: IndexPath) -> PhotoCollectionCellViewModel? {
        var imageURLList: [String] = []
        for photo in photoList {
            imageURLList.append(photo.imageURL)
        }
        return PhotoCollectionCellViewModel(imageURLList: imageURLList)
    }

    func getheightForRowAt(atIndexPath indexPath: IndexPath) -> CGFloat {
        switch sectionType(atSection: indexPath.section) {
        case .information:
            return UITableView.automaticDimension
        case .map:
            return 250
        case .photo:
            return 200
        }
    }
}
