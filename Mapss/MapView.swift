//
//  MapManager.swift
//  Mapss
//
//  Created by Daniel Hjärtström on 2020-03-05.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView {
    
    private var mapService: MapService!
    
    private(set) lazy var mapView: MKMapView = {
        let temp = MKMapView()
        temp.showsUserLocation = true
        temp.userTrackingMode = .follow
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        return temp
    }()
    
    convenience init(_ parent: UIViewController) {
        self.init(frame: .zero)
        mapService = MapService(parent, mapView: mapView)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        mapView.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func getDirections() {
        mapService.getDirections()
    }
    
    func getAddress(_ address: String) {
        mapService.getAddress(address)
    }
    
}
