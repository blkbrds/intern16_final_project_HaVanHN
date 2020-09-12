//
//  RestaurantCell.swift
//  EateryTour
//
//  Created by NganHa on 9/11/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

final class RestaurantCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var imageView: ImageView!
    @IBOutlet private weak var restaurantNameLabel: Label!
    @IBOutlet private weak var RestaurantKindLabel: Label!
    @IBOutlet private weak var costLabel: Label!
    @IBOutlet private weak var rateLabel: Label!

    // MARK: - Propeties

    // MARK: - Initialize

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configImage()
    }
    // MARK: - Override functions

    // MARK: - Private functions
    private func updateUI() {

    }

    private func configImage() {
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
    }
    // MARK: - Public functions

    // MARK: - Objc functions

    // MARK: - IBActions

}
