//
//  GoogleMapsController.swift
//  MapKit
//
//  Created by Sabir Myrzaev on 2/3/22.
//

import UIKit
import GoogleMaps

class GoogleMapsController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Properties
    
    let locationManager = CLLocationManager()
    
    private let googlemapView: GMSMapView = {
        let map = GMSMapView()
        return map
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(googlemapView)
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidLayoutSubviews() {
        googlemapView.frame = view.bounds
    }
    
    // MARK: - Helpers
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        googlemapView.camera = GMSCameraPosition(
            latitude: locationManager.location?.coordinate.latitude ?? 0.0,
            longitude: locationManager.location?.coordinate.longitude ?? 0.0,
            zoom: 8,
            bearing: 0,
            viewingAngle: 0)
        
        // user
        addPin(title: "My pos",
               comments: "It's me",
               latitude: locationManager.location?.coordinate.latitude ?? 0.0,
               longitude: locationManager.location?.coordinate.longitude ?? 0.0,
               icon: "UserArrow")
        

        // shop center
        addPin(title: "Dordoi plaza", comments: "Shop center", latitude: 42.8749913, longitude: 74.619477, icon: "shop")
        addPin(title: "Beta Stores2", comments: "Shop center", latitude: 42.8314114, longitude: 74.6226643, icon: "shop")
        
        // univercity
        addPin(title: "KRSU", comments: "Univercity", latitude: 42.8744254, longitude: 74.6383077, icon: "univer")
        addPin(title: "AUCA", comments: "Univercity", latitude: 42.8104206, longitude: 74.6272079, icon: "univer")
    }
    
    func addPin(title: String, comments: String, latitude: Double, longitude: Double, icon: String) {
        let pin = GMSMarker()
        pin.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        pin.title = title
        pin.snippet = comments
        pin.icon = UIImage(named: icon)
        pin.map = googlemapView
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
