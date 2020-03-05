//
//  Extensions.swift
//  Mapss_DEBUG
//
//  Created by Daniel Hjärtström on 2020-03-04.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit
import MapKit

extension UIAlertController {
    func addActions(_ actions: [UIAlertAction]) {
        actions.forEach {
            self.addAction($0)
        }
    }
}

extension MKMapView {
    
    func clearOverlays() {
        removeOverlays(self.overlays)
        removeAnnotations(self.annotations)
    }
    
    func addRouteOverLaysFromDirections(_ directions: MKDirections) {
        directions.calculate { [weak self] response, error in
            guard let response = response else { return }
            for route in response.routes {
                self?.addOverlay(route.polyline)
                self?.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: .init(top: 20, left: 20, bottom: 20, right: 20), animated: true)
            }
        }
    }
    
}
