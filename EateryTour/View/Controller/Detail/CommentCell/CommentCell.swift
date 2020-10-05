//
//  CommentCell.swift
//  EateryTour
//
//  Created by NganHa on 10/4/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit
import SDWebImage

final class CommentCell: UITableViewCell {

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

    // MARK: - Override functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Private functions
    private func configUI() {
        imageView?.layer.cornerRadius = 15
        imageView?.clipsToBounds = true
    }

    private func updateUI() {
        guard let viewModel = viewModel else { return }
        userNameLabel.text = viewModel.name
        createdAtLabel.text = viewModel.createdAt
        contentLabel.text = viewModel.text
        let url = URL(fileURLWithPath: viewModel.imageURL)
        imageView?.sd_setImage(with: url, completed: .none)
    }
    // MARK: - Public functions

    // MARK: - Objc functions

    // MARK: - IBActions
}
