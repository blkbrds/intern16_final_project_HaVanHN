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
    func getConfigSection(sectionType: SectionType) -> CustomHeaderViewModel? {
        switch sectionType {
        case .trending:
            return CustomHeaderViewModel(name: "Trending")
        case .category:
            return CustomHeaderViewModel(name: "Categories")
        }
    }

    func getSectionType(section: Int) -> SectionType {
        switch section {
        case 0:
            return .trending
        case 1:
            return .category
        default:
            return .category
        }
    }

    func getImageForSlide(atIndexPath indexPath: IndexPath) -> SlideCellViewModel? {
        return SlideCellViewModel(image: imageList[indexPath.row])
    }
}
