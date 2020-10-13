//
//  MapViewController.swift
//  EateryTour
//
//  Created by NganHa on 9/9/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage

final class MapViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var mapView: MKMapView!

    // MARK: - Propeties
    private var pins = [MyPin]()
    private var pinchGesture = UIPinchGestureRecognizer()
    private var recognizerScale: CGFloat = 1.0
    private var viewModel = MapViewModel()
    private var limit: Int = 10

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getRestaurant()
        configMapView()
        addAnnotations()
        configPinchGuesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarStyle = .lightContent
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - Private functions
    private func getRestaurant() {
        HUD.show()
        viewModel.exploringRestaurant(limit: limit) { [weak self] (result) in
            HUD.popActivity()
            guard let this = self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    this.getDataPin()
                    this.getDetailRestaurant()
                }
            case .failure(let error):
                this.alert(msg: error.localizedDescription, handler: nil)
            }
        }
    }

    private func getDetailRestaurant() {
        guard let restaurants = viewModel.restaurants else { return }
        if !restaurants.isEmpty {
            for i in 0...restaurants.count - 1 {
                viewModel.loadMoreInformation(index: i) { (result) in
                    switch result {
                    case .success:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        } else {
            self.alert(msg: "Can't find restaurant in the radius you want", handler: nil)
        }
    }

    private func center(location: CLLocation) {
        mapView.setCenter(location.coordinate, animated: true)
        let span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        //show current location
        mapView.showsUserLocation = true
        //addAnnotation()
        mapView.addAnnotations(pins)
    }

    private func configMapView() {
        mapView.delegate = self
        guard let currentLocation = LocationManager.shared.currentLocation else { return }
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        mapView.region = region
    }

    private func getDataPin() {
        guard let restaurants = viewModel.restaurants else { return }
        for i in 0 ..< restaurants.count {
            let pin = MyPin(title: restaurants[i].name,
                            locationName: restaurants[i].address,
                            coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(restaurants[i].lat), longitude: CLLocationDegrees(restaurants[i].lng)))
            pins.append(pin)
        }
    }

    private func addAnnotations() {
        mapView.addAnnotations(pins)
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
        recognizerScale *= pinch.scale
    }

    // MARK: - IBActions
    @IBAction private func getLocationCurrent(_ sender: UIButton) {
        guard let location = LocationManager.shared.currentLocation else { return }
        self.center(location: location)
    }
}

// MARK: Extension: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MyPin else { return nil }
        let identifier = "mypin"
        var view: MyPinView
        var isLoaded = false
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MyPinView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            guard let restaurants = viewModel.restaurants else { return nil }
            view = MyPinView(annotation: annotation, reuseIdentifier: identifier)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            for restaurant in restaurants where restaurant.name == annotation.title {
                if let photo = URL(string: restaurant.bestPhotoURL) {
                    let uiImageView = UIImageView()
                    uiImageView.sd_setImage(with: photo)
                    uiImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                    view.leftCalloutAccessoryView = uiImageView
                    view.canShowCallout = true
                    isLoaded = true
                }
            }
            if !isLoaded {
                let uiimage = #imageLiteral(resourceName: "ic-location")
                let uiImageView = UIImageView(image: uiimage)
                uiImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                view.leftCalloutAccessoryView = uiImageView
                view.canShowCallout = true
            }
        }
        return view
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation else { return }
        let detailVC = DetailViewController()
        guard let title = annotation.title, let restaurants = viewModel.restaurants else { return }
        for restaurant in restaurants where restaurant.name == title {
            detailVC.viewModel = DetailViewModel(restaurant: restaurant)
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
