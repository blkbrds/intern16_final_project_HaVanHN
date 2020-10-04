//
//  CustomHeader.swift
//  EateryTour
//
//  Created by NganHa on 10/1/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

final class CustomHeader: UITableViewHeaderFooterView {

    // MARK: - IBOutlets
    @IBOutlet private weak var nameLabel: Label!

    // MARK: - Propeties
    var viewModel: CustomHeaderViewModel? {
        didSet {
            updateUI()
        }
    }

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 0
        self.clipsToBounds = true
    }

    // MARK: - Override functions

    // MARK: - Private functions
    private func updateUI() {
        nameLabel.text = viewModel?.name
    }
    // MARK: - Public functions

    // MARK: - Objc functions

    // MARK: - IBActions

}
