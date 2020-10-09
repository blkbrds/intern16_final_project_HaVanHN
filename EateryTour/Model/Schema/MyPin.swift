//
//  MyPin.swift
//  EateryTour
//
//  Created by NganHa on 10/9/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import MapKit

class MyPin: NSObject, MKAnnotation {

  let title: String?
  let locationName: String
  let coordinate: CLLocationCoordinate2D
  init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.locationName = locationName
    self.coordinate = coordinate
    super.init()
  }
  var subtitle: String? {
    return locationName
  }
}
