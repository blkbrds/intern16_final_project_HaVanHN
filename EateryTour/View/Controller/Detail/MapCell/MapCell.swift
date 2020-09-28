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

    // MARK: - Public functions

    // MARK: - Objc functions

    // MARK: - IBActions
}
