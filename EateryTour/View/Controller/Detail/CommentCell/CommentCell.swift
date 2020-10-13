//
//  CommentCell.swift
//  EateryTour
//
//  Created by NganHa on 10/4/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit
import SDWebImage

final class CommentCell: TableCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var contentLabel: Label!
    @IBOutlet private weak var createdAtLabel: Label!
    @IBOutlet private weak var userNameLabel: Label!
    @IBOutlet private weak var userImage: ImageView!

    // MARK: - Propeties
    var viewModel: CommentCellViewModel? {
        didSet {
            updateUI()
        }
    }

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    // MARK: - Private functions
    private func configUI() {
        userImage.layer.cornerRadius = userImage.bounds.height / 2
        userImage.clipsToBounds = true
        userImage.layer.borderWidth = 1
    }

    private func updateUI() {
        guard let viewModel = viewModel else { return }
        userNameLabel.text = viewModel.name
        createdAtLabel.text = viewModel.formatCreatedAtDate()
        contentLabel.text = "'\(viewModel.text)'"
        guard let url = URL(string: viewModel.imageURL) else { return }
        userImage.sd_setImage(with: url)
    }
}
