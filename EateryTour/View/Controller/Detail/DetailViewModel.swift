//
//  DetailViewModel.swift
//  EateryTour
//
//  Created by NganHa on 9/27/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

enum DetailSection {
    case information
    case map
    case photo
}

final class DetailViewModel {
    
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
    
    func getCellForRowAtInformationSection(atIndexPath indexPath: IndexPath) -> InformationCellViewModel? {
        return nil
    }
    
    func getCellForRowAtMapSection(atIndexPath indexPath: IndexPath) -> MapCellViewModel? {
        return nil
    }
    
    func getCellForRowAtPhotoSection(atIndexPath indexPath: IndexPath) -> PhotoCollectionCellViewModel? {
        return nil
    }
}
