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
        }
    }

    weak var delegate: MapCellDelegate?

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

    // MARK: - Public functions

    // MARK: - Objc functions

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
            guard let annotation = annotation as? MyPin else { return nil }
            let identifier = "mypin"
            var view: MKAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.image = #imageLiteral(resourceName: "img-location-detail")
                // view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
               view.leftCalloutAccessoryView = UIImageView(image: #imageLiteral(resourceName: "img-open-detail"))
                view.canShowCallout = true
                view.annotation = annotation
            }
            return view
        }
}
