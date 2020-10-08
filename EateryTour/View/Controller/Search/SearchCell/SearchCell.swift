//
//  SearchCell.swift
//  EateryTour
//
//  Created by NganHa on 10/8/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit
import SDWebImage

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
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Override functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: - Private functions
    private func updateUI() {
        guard let viewModel = viewModel, let restaurant = viewModel.restaurant else { return }
        restaurantNameLabel.text = restaurant.name
        addressLabel.text = viewModel.formatAddress()
    }

    private func updateUIDetail() {
        guard let viewModel = viewModel, let detail = viewModel.detail else { return }
        guard let photo = URL(string: detail.bestPhoto) else { return }
        restaurantImageView.sd_setImage(with: photo)
    }
    // MARK: - Public functions
    func getMoreInformationForCell() {
        guard let viewModel = viewModel else { return }
        viewModel.getMoreInformationForCell { (result) in
            switch result {
            case .success:
                self.updateUIDetail()
            case .failure(let error):
                print(error.errorsString)
            }
        }
    }
    // MARK: - Objc functions

    // MARK: - IBActions
}
