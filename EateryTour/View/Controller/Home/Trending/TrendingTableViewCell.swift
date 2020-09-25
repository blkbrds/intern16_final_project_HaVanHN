//
//  TrendingTableViewCell.swift
//  EateryTour
//
//  Created by NganHa on 9/10/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

final class TrendingTableViewCell: TableCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var ratingLabel: Label!
    @IBOutlet private weak var currencyLabel: Label!
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var restaurantImageView: ImageView!
    @IBOutlet private weak var distanceButton: Button!
    @IBOutlet private weak var restaurantNameLabel: Label!
    @IBOutlet private weak var addressLabel: Label!

    // MARK: - Propeties

    // MARK: - Initialize

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    // MARK: - Override functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Private functions
    private func configUI() {
        distanceButton.layer.cornerRadius = 13
        distanceButton.clipsToBounds = true
        restaurantImageView.layer.cornerRadius = 10
        restaurantImageView.clipsToBounds = true
    }
    // MARK: - Public functions
    // MARK: - Objc functions
    // MARK: - IBActions
}
