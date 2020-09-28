//
//  PhotoCellViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/27/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

final class PhotoCollectionCellViewModel {

    private(set) var imageList: [String] = []

    private func getImageURL() {
        
    }

    func getCellForRowAt(atIndexPath indexPath: IndexPath) -> PhotoCellViewModel? {
        return PhotoCellViewModel(imageURL: imageList[indexPath.row])
    }

    func numberOfRowInSection() -> Int {
        return imageList.count
    }
}
