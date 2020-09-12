//
//  CustomHeaderView.swift
//  EateryTour
//
//  Created by NganHa on 9/10/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

final class CustomHeaderView: UITableViewHeaderFooterView {

    // MARK: - IBOutlets
    @IBOutlet private weak var nameLabel: Label!
    @IBOutlet private weak var viewAllButton: UIButton!

    // MARK: - Propeties
    var viewModel: CustomHeaderViewModel? {
        didSet {
            updateUI()
        }
    }

    // MARK: - Private functions
    private func updateUI() {
        guard let name = viewModel?.name else { return }
        nameLabel.text = name
    }

    // MARK: - IBActions
    @IBAction private func viewAllButtonTouchUpInside(_ sender: UIButton) {
        print("test")
    }
}
