//
//  SearchCell.swift
//  EateryTour
//
//  Created by NganHa on 10/8/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit
import SDWebImage

protocol SearchCellDelegate: class {

    func cell(_ cell: SearchCell, needsPerform action: SearchCell.Action)
}

final class SearchCell: TableCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var restaurantImageView: ImageView!
    @IBOutlet private weak var restaurantNameLabel: Label!
    @IBOutlet private weak var addressLabel: Label!
    @IBOutlet private weak var ratingLabel: Label!
    @IBOutlet private weak var amountOfRatingLabel: Label!
    @IBOutlet private weak var favoriteButton: Button!

    // MARK: - Propeties
    var viewModel: SearchCellViewModel? {
        didSet {
            updateUI()
        }
    }
    weak var delegate: SearchCellDelegate?

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Override functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        restaurantImageView.image = nil
    }

    // MARK: - Private functions
    private func updateUI() {
        guard let viewModel = viewModel, let restaurant = viewModel.restaurant else { return }
        restaurantNameLabel.text = restaurant.name
        addressLabel.text = viewModel.formatAddress()
    }

    private func updateUIDetail() {
        guard let viewModel = viewModel, let restaurant = viewModel.restaurant else { return }
        guard let photo = URL(string: restaurant.bestPhotoURL) else { return }
        restaurantImageView.sd_setImage(with: photo)
    }

    // MARK: - Public functions
    func getMoreInformationForCell() {
        guard let viewModel = viewModel else { return }
        viewModel.getMoreInformationForCell { (result) in
            switch result {
            case .success:
                guard let restaurant = viewModel.restaurant else { return }
                self.delegate?.cell(self, needsPerform: .callApiSuccess(restaurant: restaurant))
                self.restaurantNameLabel.text = restaurant.name
                self.addressLabel.text = viewModel.formatAddress()
                self.amountOfRatingLabel.text = restaurant.summaryLikes
                guard let url = URL(string: restaurant.bestPhotoURL) else { return }
                self.restaurantImageView.sd_setImage(with: url, completed: nil)
            case .failure(let error):
                print(error.errorsString)
            }
        }
    }
    // MARK: - Objc functions

    // MARK: - IBActions
}

// MARK: - Extension
extension SearchCell {

    enum Action {
        case callApiSuccess(restaurant: RestaurantSearching)
    }
}
