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

final class TrendingCell: TableCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var ratingLabel: Label!
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var restaurantImageView: ImageView!
    @IBOutlet private weak var distanceButton: Button!
    @IBOutlet private weak var restaurantNameLabel: Label!
    @IBOutlet private weak var addressAndCurrencyLabel: Label!

    // MARK: - Propeties
    var viewModel = TrendingCellViewModel() {
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
        restaurantImageView.layer.cornerRadius = 10
        restaurantImageView.clipsToBounds = true
        distanceButton.layer.cornerRadius = 15
        distanceButton.clipsToBounds = true
    }

    private func updateUI() {
        guard let restaurant = viewModel.restaurant else { return }
        restaurantNameLabel.text = restaurant.name
        if restaurant.address != "" || restaurant.city != "" {
            addressAndCurrencyLabel.text = restaurant.address + restaurant.city + " - "
        }
        guard let urlImage = URL(string: viewModel.image) else { return }
        restaurantImageView.sd_setImage(with: urlImage)
    }

    // MARK: - Public functions
    func getInformation(completion: @escaping APICompletion) {
        viewModel.loadMoreInformation(completion: { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                guard let urlImage = URL(string: this.viewModel.image) else { return }
                if let restaurant = this.viewModel.restaurant {
                    this.delegate?.cell(this, needsPerform: .callApiSuccess(restaurant: restaurant))
                }
                this.restaurantImageView.sd_setImage(with: urlImage)
                this.addressAndCurrencyLabel.text = this.viewModel.currency
                this.ratingLabel.text = String(this.viewModel.rating)
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
