//
//  MyPin.swift
//  EateryTour
//
//  Created by NganHa on 10/9/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import MapKit

class MyPinView: MKPinAnnotationView {

    private var imageView: UIImageView!

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        self.imageView.image = #imageLiteral(resourceName: "ic-location-map")
        self.addSubview(self.imageView)
        self.imageView.layer.cornerRadius = 5.0
        self.imageView.layer.masksToBounds = true
    }

    override var image: UIImage? {
        get {
            return self.imageView.image
        }
        set {
            if let _ = imageView {
                self.imageView.image = newValue
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
