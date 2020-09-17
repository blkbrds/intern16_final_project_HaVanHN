//
//  HomeViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/10/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import UIKit

final class HomeViewModel: ViewModel {

    // MARK: - Properties
    var imageList: [UIImage] = [#imageLiteral(resourceName: "slideFood3"), #imageLiteral(resourceName: "slideFood1"), #imageLiteral(resourceName: "slideFood4"), #imageLiteral(resourceName: "slideFood5"), #imageLiteral(resourceName: "slideFood2")]

    // MARK: - Public functions
    func getImageForSlide(atIndexPath indexPath: IndexPath) -> SlideCellViewModel? {
        return SlideCellViewModel(image: imageList[indexPath.row])
    }
}
