//
//  RecommendCell.swift
//  EateryTour
//
//  Created by NganHa on 9/28/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

final class RecommendCell: TableCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var restaurantImage: ImageView!
    @IBOutlet private weak var nameLabel: Label!
    @IBOutlet private weak var addressAndCurrencyLabel: Label!
    @IBOutlet private weak var amountOfRatingLabel: Label!
    @IBOutlet private weak var ratingLabel: Label!

    // MARK: - Propeties
    var viewModel: CellViewModel? {
        didSet {
            updateUI()
        }
    }
    // MARK: - Initialize

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: - Override functions

    // MARK: - Private functions
    private func updateUI() {
    }

    private func configUI() {
        restaurantImage.layer.cornerRadius = 5
        restaurantImage.clipsToBounds = true
    }
    // MARK: - Public functions

    // MARK: - Objc functions

    // MARK: - IBActions
}
