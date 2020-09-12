//
//  CategoryCell.swift
//  EateryTour
//
//  Created by NganHa on 9/11/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

final class CategoryCell: CollectionCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var numberRestaurantLabel: Label!
    @IBOutlet private weak var categoryNameLabel: Label!
    @IBOutlet private weak var categoryImage: ImageView!

    // MARK: - Propeties

    // MARK: - Initialize

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configCell()
    }
    // MARK: - Override functions

    // MARK: - Private functions
    private func configCell() {
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
    // MARK: - Public functions

    // MARK: - Objc functions

    // MARK: - IBActions

}
