//
//  TrendingTableViewCell.swift
//  EateryTour
//
//  Created by NganHa on 9/10/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit
import SDWebImage

typealias CompletionCellResult = (Bool, String) -> Void

final class TrendingTableViewCell: TableCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var ratingLabel: Label!
    @IBOutlet private weak var currencyLabel: Label!
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var restaurantImageView: ImageView!
    @IBOutlet private weak var distanceLabel: Label!
    @IBOutlet private weak var restaurantNameLabel: Label!
    @IBOutlet private weak var addressLabel: Label!

    // MARK: - Propeties
    var viewModel: TrendingCellViewModel? {
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

    // MARK: - Override functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Private functions
    private func configUI() {
        cellView.layer.cornerRadius = 20
        cellView.clipsToBounds = true
    }

    private func updateUI() {
        restaurantNameLabel.text = viewModel?.name
        if let address = viewModel?.address, let city = viewModel?.city {
            addressLabel.text = address + city + " - "
        }
    }

    func getInformation(completion: @escaping CompletionCellResult) {
        viewModel?.loadMoreInformation(completion: { (result) in
            switch result {
            case .success:
                guard let urlImage = URL(string: self.viewModel?.image ?? "") else { return }
                self.restaurantImageView.sd_setImage(with: urlImage)
                self.currencyLabel.text = self.viewModel?.currency
                if let rating = self.viewModel?.rating {
                    self.ratingLabel.text = String(rating)
                }
                completion(true," ")
            case .failure:
                completion(false, "abc" )
            }
        })
    }
    // MARK: - Public functions
    // MARK: - Objc functions
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10))
    }
    // MARK: - IBActions
}
