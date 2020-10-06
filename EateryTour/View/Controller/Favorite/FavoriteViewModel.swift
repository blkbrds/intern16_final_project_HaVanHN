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
    private(set) var detail: [Detail]?

    func numberOfItems(inSection section: Int) -> Int {
        guard let detail = detail else { return 1 }
        return detail.count
    }

    func getCellForRowAt(atIndexPath indexPath: IndexPath) -> RestaurantCellViewModel? {
        guard let restautants = restaurants else { return nil }
        return RestaurantCellViewModel(restaurant: restautants[indexPath.row])
    }

    func getDataFromRealm() {
    }
}
