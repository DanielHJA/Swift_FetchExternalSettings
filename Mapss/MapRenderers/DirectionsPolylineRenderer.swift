//
//  DirectionsPolylineRenderer.swift
//  Mapss_DEBUG
//
//  Created by Daniel Hjärtström on 2020-03-04.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit
import MapKit

class DirectionsPolylineRenderer: MKPolylineRenderer {
    
    override init(overlay: MKOverlay) {
        super.init(overlay: overlay)
        strokeColor = UIColor.blue.withAlphaComponent(0.8)
        lineWidth = 3.0
        fillColor = UIColor.blue.withAlphaComponent(0.8)
    }
    
}
