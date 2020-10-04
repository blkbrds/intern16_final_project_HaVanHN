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
    @IBOutlet private weak var restaurantImage: ImageView!
    @IBOutlet private weak var nameLabel: Label!
    @IBOutlet private weak var addressAndPriceLabel: Label!
    @IBOutlet private weak var amountOfRatingLabel: Label!
    @IBOutlet private weak var ratingLabel: Label!

    // MARK: - Propeties
    var viewModel: RestaurantCellViewModel? {
        didSet {
            updateUI()
        }
    }
    weak var delegate: RecommendCellDelegate?
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
        guard let viewModel = viewModel, let restaurant = viewModel.restaurant else { return }
        addressAndPriceLabel.text = viewModel.formatAddresAndPrice()
        nameLabel.text = restaurant.name
        ratingLabel.text = String(restaurant.rating)
        guard let detail = viewModel.detail else { return }
        amountOfRatingLabel.text = detail.sumaryLikes
    }

    private func configUI() {
        restaurantImage.layer.cornerRadius = 5
        restaurantImage.clipsToBounds = true
    }
    // MARK: - Public functions
    func loadMoreInformation(completion: @escaping APICompletion) {
        guard let viewModel = viewModel else { return }
        viewModel.loadMoreInformation { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                guard let detail = viewModel.detail, let urlImage = URL(string: detail.bestPhoto) else { return }
                if let restaurant = viewModel.restaurant {
                    this.delegate?.cell(this, needsPerform: .callApiSuccess(restaurant: restaurant))
                }
                this.restaurantImage.sd_setImage(with: urlImage)
                this.amountOfRatingLabel.text = "(\(detail.sumaryLikes))"
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Objc functions

    // MARK: - IBActions
}

extension RecommendCell {

    enum Action {
        case callApiSuccess(restaurant: Restaurant)
    }
}
