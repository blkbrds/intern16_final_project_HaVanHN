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
    case comment
}

final class DetailViewModel: ViewModel {

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

    func getCellForRowAtInformationSection(atIndexPath indexPath: IndexPath) -> InformationCellViewModel? {
        return nil
    }

    func getCellForRowAtMapSection(atIndexPath indexPath: IndexPath) -> MapCellViewModel? {
        return nil
    }

    func getCellForRowAtPhotoSection(atIndexPath indexPath: IndexPath) -> PhotoCollectionCellViewModel? {
        return nil
    }

    func getCellForRowAtCommentSection(atIndexPath indexPath: IndexPath) -> CommentCellViewModel? {
        return nil
    }

    func getHeightForRowAt(atIndexPath indexPath: IndexPath) -> CGFloat {
        switch sectionType(atSection: indexPath.section) {
        case .information:
            return UITableView.automaticDimension
        case .map:
            return 260
        case .photo:
            return 200
        case .comment:
            return 120
        }
    }

    func numberOfSections() -> Int {
        return 4
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
            return 5
        }
    }
}
