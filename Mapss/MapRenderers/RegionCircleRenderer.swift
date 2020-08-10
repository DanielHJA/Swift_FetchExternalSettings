//
//  RegionCircleRenderer.swift
//  Mapss_DEBUG
//
//  Created by Daniel Hjärtström on 2020-03-05.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit
import MapKit

class RegionCircleRenderer: MKCircleRenderer {

    override init(overlay: MKOverlay) {
        super.init(overlay: overlay)
        strokeColor = UIColor.black
        lineWidth = 2.0
        fillColor = UIColor.red.withAlphaComponent(0.6)
    }
    
}
