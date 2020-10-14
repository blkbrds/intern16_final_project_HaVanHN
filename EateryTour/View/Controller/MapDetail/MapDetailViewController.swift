//
//  MapDetailViewController.swift
//  EateryTour
//
//  Created by NganHa on 9/30/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit
import MapKit

final class MapDetailViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var backButton: Button!
    @IBOutlet private weak var mapView: MKMapView!

    // MARK: - Propeties
    var viewModel: MapDetailViewModel?
    private var pinchGesture = UIPinchGestureRecognizer()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configMapView()
        addAnnotationRestaurant()
        addAnnotationUserLocation()
        configRouting()
        configPinchGuesture()
    }

    // MARK: - Private functions
    private func configUI() {
        backButton?.tintColor = .white
    }

    private func configMapView() {
        guard let viewModel = viewModel else { return }
        guard let latitude = LocationManager.shared.currentLatitude, let longtitude = LocationManager.shared.currentLongitude else { return }
        let location = CLLocation(latitude: (CLLocationDegrees(viewModel.lat) + latitude) / 2, longitude: (CLLocationDegrees(viewModel.lng) + longtitude) / 2)
        let span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        mapView.delegate = self
    }

    private func addAnnotationRestaurant() {
        guard let viewModel = viewModel else {
            return
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(viewModel.lat), longitude: CLLocationDegrees(viewModel.lng))
        annotation.title = viewModel.name
        annotation.subtitle = viewModel.address
        mapView.addAnnotation(annotation)
    }

    private func addAnnotationUserLocation() {
        let annotation = MKPointAnnotation()
        guard let latitude = LocationManager.shared.currentLatitude, let longtitude = LocationManager.shared.currentLongitude else { return }
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        annotation.title = "user's location"
        mapView.addAnnotation(annotation)
    }

    private func drawRoute(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination, addressDictionary: nil))
        request.requestsAlternateRoutes = false
        let directions = MKDirections(request: request)
        directions.calculate { [unowned self] (response, _) in
            guard let response = response else { return }
            guard let route: MKRoute = response.routes.first else { return }
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
    }

    private func configRouting() {
        guard let viewModel = viewModel else {
            return
        }
        let source = CLLocationCoordinate2D(latitude: CLLocationDegrees(viewModel.lat), longitude: CLLocationDegrees(viewModel.lng))
        guard let latitude = LocationManager.shared.currentLatitude, let longtitude = LocationManager.shared.currentLongitude else { return }
        let destination = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        drawRoute(source: source, destination: destination)
        drawRoute(source: source, destination: destination)
    }

    private func configPinchGuesture() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch(pinch:)))
        mapView.addGestureRecognizer(pinchGesture)
    }

    // MARK: - Objc functions
    @objc private func pinch(pinch: UIPinchGestureRecognizer) {
        guard let transformScale = pinch.view?.transform.scaledBy(x: pinch.scale, y: pinch.scale) else {
            return
        }
        pinch.view?.transform = transformScale
    }

    // MARK: - IBActions
    @IBAction private func backButtonTouchUpInside(_ sender: Button) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - MKMapViewDelegate
extension MapDetailViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .green
        renderer.lineWidth = 3.0
        return renderer
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        if annotation.title == viewModel?.name {
            annotationView?.image = #imageLiteral(resourceName: "ic-location-map").sd_resizedImage(with: CGSize(width: 40, height: 40), scaleMode: .aspectFill)
        } else {
            annotationView?.image = #imageLiteral(resourceName: "ic-location").sd_resizedImage(with: CGSize(width: 40, height: 40), scaleMode: .aspectFill)
        }
        annotationView?.canShowCallout = true
        return annotationView
    }
}
