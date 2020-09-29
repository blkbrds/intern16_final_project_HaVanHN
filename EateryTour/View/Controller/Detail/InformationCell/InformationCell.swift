//
//  InformationCell.swift
//  EateryTour
//
//  Created by NganHa on 9/27/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

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
        }
    }

    // MARK: - Initialize

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configFavoriteButton()
    }

    // MARK: - Override functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Private functions
    private func updateUI() {
        guard let viewModel = viewModel, let urlImage = URL(string: viewModel.imageURL) else {
            return
        }
        restaurantImage.sd_setImage(with: urlImage)
        nameLabel.text = viewModel.name
        addressLabel.text = viewModel.address
        currencyLabel.text = viewModel.currency
        ratingLabel.text = String(viewModel.rating)
        amountOfRatingLabel.text = viewModel.amountOfRating
    }

    private func configFavoriteButton() {
        favoriteButton.tintColor = #colorLiteral(red: 0.10909646, green: 0.2660153806, blue: 0.2814711332, alpha: 1)
        favoriteButton.layer.cornerRadius = 20
        favoriteButton.layer.shadowColor = UIColor.black.cgColor
        favoriteButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        favoriteButton.layer.shadowOpacity = 1.0
        favoriteButton.layer.shadowRadius = 20
        favoriteButton.layer.masksToBounds = false
    }

    // MARK: - Public functions

    // MARK: - Objc functions

    // MARK: - IBActions

    @IBAction private func favoriteButtonTouchUpInside(_ sender: Button) {
    print("tap")
    }

    @IBAction private func backButtonTouchUpInside(_ sender: Button) {
    }
}
