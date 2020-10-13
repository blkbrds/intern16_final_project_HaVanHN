//
//  PhotoCellViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/27/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

final class PhotoCollectionCellViewModel: ViewModel {

    private(set) var imageURLList: [String]

    init(imageURLList: [String]) {
        self.imageURLList = imageURLList
    }

    func getCellForRowAt(atIndexPath indexPath: IndexPath) -> PhotoCellViewModel? {
        return PhotoCellViewModel(imageURL: imageURLList[indexPath.row])
    }

    func numberOfItemInSection() -> Int {
        return imageURLList.count
    }
}
