//
//  MapDetailViewController.swift
//  EateryTour
//
//  Created by NganHa on 9/30/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit
import MapKit

final class MapDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var backButton: Button!
    @IBOutlet private weak var mapView: MKMapView!

    // MARK: - Propeties
    var viewModel: MapDetailViewModel? {
        didSet {
            updateUI()
        }
    }

    // MARK: - Initialize

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    // MARK: - Override functions
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        view.layoutIfNeeded()
    }
    // MARK: - Private functions
    private func configUI() {
        backButton?.tintColor = .white
    }

    private func updateUI() {

    }

    // MARK: - Public functions

    // MARK: - Objc functions

    // MARK: - IBActions
    @IBAction private func backButtonTouchUpInside(_ sender: Button) {
        navigationController?.popViewController(animated: true)
    }
}
