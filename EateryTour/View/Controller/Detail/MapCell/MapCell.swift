//
//  MapCell.swift
//  EateryTour
//
//  Created by NganHa on 9/27/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit
import MapKit

final class MapCell: TableCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var openTodayLabel: Label!
    @IBOutlet private weak var openHoursLabel: Label!
    @IBOutlet private weak var locationButton: Button!

    // MARK: - Propeties
    var viewModel: MapCellViewModel? {
        didSet {
            updateUI()
        }
    }
    // MARK: - Initialize

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configButton()
    }

    // MARK: - Override functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Private functions
    private func updateUI() {
        guard let viewModel = viewModel else {
            return
        }
        openTodayLabel.text = viewModel.openToday
        openHoursLabel.text = viewModel.openHours
    }

    private func configButton() {
        locationButton.layer.cornerRadius = 20
        locationButton.clipsToBounds = true
        locationButton.tintColor = #colorLiteral(red: 0.10909646, green: 0.2660153806, blue: 0.2814711332, alpha: 1)
        locationButton.layer.borderWidth = 0.5
        locationButton.layer.borderColor = #colorLiteral(red: 0.10909646, green: 0.2660153806, blue: 0.2814711332, alpha: 1)
    }

    // MARK: - Public functions

    // MARK: - Objc functions

    // MARK: - IBActions
}
