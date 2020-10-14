//
//  RecommendCell.swift
//  EateryTour
//
//  Created by NganHa on 9/28/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

protocol RecommendCellDelegate: class {

    func cell(_ cell: RecommendCell, needsPerform action: RecommendCell.Action)
}

final class RecommendCell: TableCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var restaurantImageView: ImageView!
    @IBOutlet private weak var nameLabel: Label!
    @IBOutlet private weak var addressAndPriceLabel: Label!
    @IBOutlet private weak var amountOfRatingLabel: Label!
    @IBOutlet private weak var ratingLabel: Label!
    @IBOutlet private weak var favoriteButton: Button!

    // MARK: - Propeties
    var viewModel: RestaurantCellViewModel? {
        didSet {
            updateUI()
        }
    }
    weak var delegate: RecommendCellDelegate?

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    // MARK: - Override functions
    override func prepareForReuse() {
        super.prepareForReuse()
        restaurantImageView.image = nil
    }

    // MARK: - Private functions
    private func updateUI() {
        guard let viewModel = viewModel, let restaurant = viewModel.restaurant else { return }
        addressAndPriceLabel.text = viewModel.formatAddresAndPrice()
        nameLabel.text = restaurant.name
        ratingLabel.text = String(restaurant.rating)
        if viewModel.checkIsFavorite() {
            favoriteButton.setImage(#imageLiteral(resourceName: "ic-heart-fill"), for: .normal)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "ic-heart"), for: .normal)
        }
        if let urlImage = URL(string: restaurant.bestPhotoURL) {
            restaurantImageView.sd_setImage(with: urlImage)
        }
        amountOfRatingLabel.text = restaurant.summaryLikes
    }

    private func configUI() {
        restaurantImageView.layer.cornerRadius = 5
        restaurantImageView.clipsToBounds = true
    }

    // MARK: - Public functions
    func loadMoreInformation(completion: @escaping APICompletion) {
        guard let viewModel = viewModel else { return }
        viewModel.loadMoreInformation { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                guard let restaurant = viewModel.restaurant, let urlImage = URL(string: restaurant.bestPhotoURL) else { return }
                if let restaurant = viewModel.restaurant {
                    this.delegate?.cell(this, needsPerform: .callApiSuccess(restaurant: restaurant))
                }
                this.restaurantImageView.sd_setImage(with: urlImage)
                this.amountOfRatingLabel.text = "(\(restaurant.summaryLikes))"
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - IBActions
    @IBAction private func favoriteButtonTouchUpInside(_ sender: Button) {
        guard let viewModel = viewModel, let restaurant = viewModel.restaurant else { return }
        viewModel.favorite = false
        if favoriteButton.currentImage == #imageLiteral(resourceName: "ic-heart-fill") {
            favoriteButton.setImage(#imageLiteral(resourceName: "ic-heart"), for: .normal)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "ic-heart-fill"), for: .normal)
        }
        delegate?.cell(self, needsPerform: Action.changeFavoriteState(id: restaurant.id))
    }
}

extension RecommendCell {

    enum Action {
        case callApiSuccess(restaurant: Restaurant)
        case changeFavoriteState(id: String)
    }
}
