//
//  MapCell.swift
//  EateryTour
//
//  Created by NganHa on 9/27/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit
import MapKit

protocol MapCellDelegate: class {
    func view(_ view: MapCell, needsPerform action: MapCell.Action)
}

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
            configRestaurantLocation()
            addAnnotation()
            configButton()
        }
    }
    weak var delegate: MapCellDelegate?

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

    private func configButton() {
        locationButton.layer.cornerRadius = 20
        locationButton.clipsToBounds = true
        locationButton.tintColor = #colorLiteral(red: 0.10909646, green: 0.2660153806, blue: 0.2814711332, alpha: 1)
        locationButton.layer.borderWidth = 0.5
        locationButton.layer.borderColor = #colorLiteral(red: 0.10909646, green: 0.2660153806, blue: 0.2814711332, alpha: 1)
    }

    private func configRestaurantLocation() {
        guard let viewModel = viewModel else {
            return
        }
        let restaurantLocation = CLLocation(latitude: CLLocationDegrees(viewModel.lat), longitude: CLLocationDegrees(viewModel.lng))
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: restaurantLocation.coordinate, span: span)
        mapView.region = region
        mapView.delegate = self
    }

    func addAnnotation() {
        guard let viewModel = viewModel else {
            return
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(viewModel.lat), longitude: CLLocationDegrees(viewModel.lng))
        annotation.title = viewModel.name
        annotation.subtitle = viewModel.address
        mapView.addAnnotation(annotation)
    }

    // MARK: - IBActions
    @IBAction private func locationButtonTouchUpInside(_ sender: Button) {
        guard let viewModel = viewModel else {
            return
        }
        delegate?.view(self, needsPerform: .pushToMapDetail(lat: viewModel.lng, lng: viewModel.lng))
    }
}

// MARK: - Extension
extension MapCell {

    enum Action {
        case pushToMapDetail(lat: Float, lng: Float)
    }
}

// MARK: - MKMapViewDelegate
extension MapCell: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        annotationView?.image = #imageLiteral(resourceName: "ic-location-map").sd_resizedImage(with: CGSize(width: 40, height: 40), scaleMode: .aspectFill)
        annotationView?.canShowCallout = true
        return annotationView
        }
}
