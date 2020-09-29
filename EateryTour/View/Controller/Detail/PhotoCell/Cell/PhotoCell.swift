//
//  PhotoCell.swift
//  EateryTour
//
//  Created by NganHa on 9/27/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

final class PhotoCell: CollectionCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var photoImage: ImageView!

    // MARK: - Propeties
    var viewModel: PhotoCellViewModel? {
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

    // MARK: - Private functions
    private func updateUI() {
        guard let viewModel = viewModel, let urlImage = URL(string: viewModel.imageURL) else { return }
        photoImage.sd_setImage(with: urlImage)
    }

    private func configUI() {
        photoImage.layer.cornerRadius = 15
        photoImage.clipsToBounds = true
    }

    // MARK: - Public functions

    // MARK: - Objc functions

    // MARK: - IBActions
}
