//
//  TrendingTableViewCell.swift
//  EateryTour
//
//  Created by NganHa on 9/10/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

final class TrendingTableViewCell: TableCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    // MARK: - IBOutlets
    // MARK: - Propeties
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
    // MARK: - Public functions
    // MARK: - Objc functions
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10))
    }
    // MARK: - IBActions
}
