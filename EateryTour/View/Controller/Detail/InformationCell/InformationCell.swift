//
//  InformationCell.swift
//  EateryTour
//
//  Created by NganHa on 9/27/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

protocol InformationCellDelegate: class {

    func cell(_ cell: InformationCell, needsPerform action: InformationCell.Action)
}

final class InformationCell: TableCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var restaurantImage: ImageView!
    @IBOutlet private weak var nameLabel: Label!
    @IBOutlet private weak var addressLabel: Label!
    @IBOutlet private weak var currencyLabel: Label!
    @IBOutlet private weak var ratingLabel: Label!
    @IBOutlet private weak var amountOfRatingLabel: Label!
    @IBOutlet private weak var favoriteButton: Button!

    // MARK: - Propeties
    var viewModel: InformationCellViewModel? {
        didSet {
            updateUI()
            configFavoriteButton()
        }
    }
    weak var delegate: InformationCellDelegate?

    // MARK: - Private functions
    private func updateUI() {
        guard let viewModel = viewModel, let urlImage = URL(string: viewModel.imageURL) else {
            return
        }
        restaurantImage.sd_setImage(with: urlImage)
        nameLabel.text = viewModel.name
        addressLabel.text = viewModel.address
        currencyLabel.text = viewModel.price
        ratingLabel.text = String(viewModel.rating)
        amountOfRatingLabel.text = viewModel.amountOfRating
    }

    private func configFavoriteButton() {
        favoriteButton.tintColor = App.Color.appColor
        favoriteButton.layer.cornerRadius = 20
        favoriteButton.layer.shadowColor = UIColor.black.cgColor
        favoriteButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        favoriteButton.layer.shadowOpacity = 1.0
        favoriteButton.layer.shadowRadius = 10
        favoriteButton.layer.masksToBounds = false
        guard let viewModel = viewModel else { return }
        if viewModel.isFavorite {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }

    // MARK: - IBActions
    @IBAction private func favoriteButtonTouchUpInside(_ sender: Button) {
        guard let viewModel = viewModel else { return }
        if viewModel.isFavorite {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        delegate?.cell(self, needsPerform: .changeDataRealm)
    }
}

// MARK: - Extension
extension InformationCell {

    enum Action {
        case changeDataRealm
    }
}
