//
//  AppleMapsController.swift
//  MapKit
//
//  Created by Sabir Myrzaev on 2/3/22.
//

import UIKit
import MapKit

class AppleMapsController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Property
    let locationManager = CLLocationManager()
    
    private let applemapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(applemapView)
        
        applemapView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if(CLLocationManager.locationServicesEnabled()) {
            locationManager.requestLocation()
            locationManager.startUpdatingHeading()
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        applemapView.frame = view.bounds
    }
    
    // MARK: - Helpers
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinates = CLLocationCoordinate2D(
            latitude: locationManager.location?.coordinate.latitude ?? 0.0,
            longitude: locationManager.location?.coordinate.longitude ?? 0.0
        )
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let region = MKCoordinateRegion(center: coordinates, span: span)
        
        applemapView.setRegion(region, animated: true)
        
        // user
        let myPin = MKPointAnnotation()
        myPin.coordinate = coordinates
        
        myPin.title = "My pos"
        myPin.subtitle = "It's me"
        
        applemapView.addAnnotation(myPin)
        
        // shop center
        addPin(title: "Dordoi plaza", comments: "Shop center", latitude: 42.8749913, longitude: 74.619477)
        addPin(title: "Beta Stores2", comments: "Shop center", latitude: 42.8314114, longitude: 74.6226643)
        
        // univercity
        addPin(title: "KRSU", comments: "Univercity", latitude: 42.8744254, longitude: 74.6383077)
        addPin(title: "AUCA", comments: "Univercity", latitude: 42.8104206, longitude: 74.6272079)
    }
    
    func addPin(title: String, comments: String, latitude: Double, longitude: Double) {
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        pin.title = title
        pin.subtitle = comments
        applemapView.addAnnotation(pin)
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            return
        case .authorizedWhenInUse:
            return
        case .denied:
            return
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension AppleMapsController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Check for type here, not for the Title!!!
        if annotation is MKUserLocation {
            // we do not want to return a custom View for the User Location
            return nil
        }
        let identifier = "custom"
        var annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        
        if annotationView == nil {
            // create view
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
        } else {
            // assign annotation
            annotationView.annotation = annotation
            annotationView.canShowCallout = true

        }
        // set custom annotaion
        switch annotation.subtitle {
        case "Shop center":
            annotationView.image = UIImage(named: "shop")
        case "Univercity":
            annotationView.image = UIImage(named: "univer")

        default:
            annotationView.image = UIImage(named: "UserLocation")

        }
        return annotationView
    }
}
