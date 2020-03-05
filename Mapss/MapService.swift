//
//  MapService.swift
//  Mapss_DEBUG
//
//  Created by Daniel Hjärtström on 2020-03-03.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapService: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
    
    private var parent: UIViewController!
    private var mapView: MKMapView!
    private var currentAnnotation: MKPointAnnotation?
    
    private lazy var locationManager: CLLocationManager = {
        let temp: CLLocationManager = CLLocationManager()
        temp.desiredAccuracy = kCLLocationAccuracyBest
        temp.delegate = self
        return temp
    }()
    
    init(_ parent: UIViewController, mapView: MKMapView) {
        super.init()
        self.parent = parent
        self.mapView = mapView
        mapView.delegate = self
        checkIfLocationServicesAreEnabled()
    }
    
    func checkIfLocationServicesAreEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorizationStatus()
        } else {
            AlertService.settingsAlert(controller: parent, title: "Location Services Not Activated", message: "Please turn on location services", actionTitle: "Settings")
        }
    }
    
    private func checkLocationAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
            setInitialRegion()
        @unknown default:
            break
        }
    }
    
    private func setInitialRegion(){
        guard let coordinates = locationManager.location?.coordinate else { return }
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func getAddress(_ address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] (placemarks, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            if let placemark = placemarks?.first {
                self?.mapView.clearOverlays()
                self?.AddPinAtPlacemark(placemark)
            }
        }
    }
    
    func AddPinAtPlacemark(_ placemark: CLPlacemark) {
        guard let coordinates = placemark.location?.coordinate else { return }
        let annotation = MKPointAnnotation()
        annotation.title = placemark.name
        annotation.coordinate = coordinates
        mapView.addAnnotation(annotation)
        currentAnnotation = annotation
        resizeMapToEncloseAnnotations()
    }
    
    func resizeMapToEncloseAnnotations() {
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    func getDirections() {
        guard let annotation = currentAnnotation, let location = locationManager.location?.coordinate else { return }
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: location))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: annotation.coordinate))
        request.requestsAlternateRoutes = false
        request.transportType = .automobile
        let directions = MKDirections(request: request)
        mapView.addRouteOverLaysFromDirections(directions)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{ return nil }
        let identifier = "pinIdentifier"
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            view.annotation = annotation
            return view
        } else {
            return MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline { return DirectionsPolylineRenderer(overlay: overlay) }
        return MKOverlayRenderer()
    }
    
    // MARK : - MKMapViewDelegate
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("MapView finished loading")
    }
    
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        print(error)
    }
    
    // MARK : - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            AlertService.settingsAlert(controller: parent, title: "Location Required", message: "Please go to 'Settings' and give permission", actionTitle: "Settings")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        print(location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
