//
//  SliderCell.swift
//  EateryTour
//
//  Created by NganHa on 9/11/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

final class SliderCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var image: UIImageView!
    // MARK: - Propeties
    var viewModel: SlideCellViewModel? {
        didSet {
            updateUI()
        }
    }

    // MARK: - Private functions
    private func updateUI() {
        image.image = viewModel?.image
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
    }
}
