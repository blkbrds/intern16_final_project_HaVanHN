//
//  TrendingTableViewCell.swift
//  EateryTour
//
//  Created by NganHa on 9/10/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit
import SDWebImage

protocol TrendingCellDelegate: class {
    func cell(_ cell: TrendingCell, needsPerform action: TrendingCell.Action)
}

final class TrendingCell: CollectionCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var ratingLabel: Label!
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var restaurantImageView: ImageView!
    @IBOutlet private weak var distanceButton: Button!
    @IBOutlet private weak var restaurantNameLabel: Label!
    @IBOutlet private weak var addressAndCurrencyLabel: Label!
    @IBOutlet private weak var amountOfRatingLabel: Label!

    // MARK: - Propeties
    var viewModel: RestaurantCellViewModel? {
        didSet {
            updateUI()
        }
    }
    weak var delegate: TrendingCellDelegate?

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
    private func configUI() {
        restaurantImageView.layer.cornerRadius = 7
        restaurantImageView.clipsToBounds = true
        distanceButton.layer.cornerRadius = 15
        distanceButton.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }

    private func updateUI() {
        guard let viewModel = viewModel else { return }
        guard let restaurant = viewModel.restaurant else { return }
        restaurantNameLabel.text = restaurant.name
        addressAndCurrencyLabel.text = viewModel.getAddressAndCurrencyLabel()
        distanceButton.setTitle(String(restaurant.distance), for: .normal)
        ratingLabel.text = String(restaurant.rating)
//        guard let detail = viewModel.detail, let urlImage = URL(string: detail.bestPhoto) else { return }
//        restaurantImageView.sd_setImage(with: urlImage)
//        amountOfRatingLabel.text = detail.sumaryLikes
    }

    // MARK: - Public functions
    func getInformation(completion: @escaping APICompletion) {
        guard let viewModel = viewModel else { return }
        viewModel.loadMoreInformation(completion: { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                guard let newViewModel = this.viewModel, let detail = newViewModel.detail, let urlImage = URL(string: detail.bestPhoto) else { return }
                if let restaurant = newViewModel.restaurant {
                    this.delegate?.cell(this, needsPerform: .callApiSuccess(restaurant: restaurant))
                }
                this.restaurantImageView.sd_setImage(with: urlImage)
                this.amountOfRatingLabel.text = detail.sumaryLikes
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}

// MARK: - Extension
extension TrendingCell {

    enum Action {
        case callApiSuccess(restaurant: Restaurant)
    }
}
