//
//  YandexMapsController.swift
//  MapKit
//
//  Created by Sabir Myrzaev on 2/3/22.
//

import UIKit
import YandexMapsMobile

class YandexMapsController: UIViewController, YMKUserLocationObjectListener {
    
    // MARK: - Properties
    
    private let yandexmapView: YMKMapView = {
        let map = YMKMapView()
        return map
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userLocation()
        view.addSubview(yandexmapView)
        
        addPin(with: YMKPoint(latitude: 42.8749913, longitude: 74.6194771), image: "shop")
        addPin(with: YMKPoint(latitude: 42.8314114, longitude: 74.6226643), image: "shop")
        addPin(with: YMKPoint(latitude: 42.8744254, longitude: 74.6383077), image: "univer")
        addPin(with: YMKPoint(latitude: 42.81064, longitude: 74.627359), image: "univer")
        
    }
    
    override func viewDidLayoutSubviews() {
        yandexmapView.frame = view.bounds
    }
    
    // MARK: - Helpers
    
    func addPin(with point: YMKPoint, image: String) {
        let mapObjects = yandexmapView.mapWindow.map.mapObjects
        let placemark = mapObjects.addPlacemark(with: point)
        guard let pin = UIImage(named: image) else { return }
        placemark.setIconWith(pin)
    }
    
    func userLocation() {
        yandexmapView.mapWindow.map.isRotateGesturesEnabled = false
        yandexmapView.mapWindow.map.move(with:
                                    YMKCameraPosition(target: YMKPoint(latitude: 42, longitude: 74), zoom: 14, azimuth: 0, tilt: 0))
        
        let scale = UIScreen.main.scale
        let mapKit = YMKMapKit.sharedInstance()
        let userLocationLayer = mapKit.createUserLocationLayer(with: yandexmapView.mapWindow)
        
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
        userLocationLayer.setAnchorWithAnchorNormal(
            CGPoint(x: 0.5 * yandexmapView.frame.size.width * scale, y: 0.5 * yandexmapView.frame.size.height * scale),
            anchorCourse: CGPoint(x: 0.5 * yandexmapView.frame.size.width * scale, y: 0.83 * yandexmapView.frame.size.height * scale))
        userLocationLayer.setObjectListenerWith(self)
    }
    
    func onObjectAdded(with view: YMKUserLocationView) {
        guard let userArrow = UIImage(named:"UserArrow") else { return }
        guard let searchResult = UIImage(named:"SearchResult") else { return }
        view.arrow.setIconWith(userArrow)
        
        let pinPlacemark = view.pin.useCompositeIcon()
        
        pinPlacemark.setIconWithName("icon",
                                     image: userArrow,
                                     style:YMKIconStyle(
                                        anchor: CGPoint(x: 0, y: 0) as NSValue,
                                        rotationType:YMKRotationType.rotate.rawValue as NSNumber,
                                        zIndex: 0,
                                        flat: true,
                                        visible: true,
                                        scale: 1.5,
                                        tappableArea: nil))
        
        pinPlacemark.setIconWithName(
            "pin",
            image: searchResult,
            style:YMKIconStyle(
                anchor: CGPoint(x: 0.5, y: 0.5) as NSValue,
                rotationType:YMKRotationType.rotate.rawValue as NSNumber,
                zIndex: 1,
                flat: true,
                visible: true,
                scale: 1,
                tappableArea: nil))
        
        view.accuracyCircle.fillColor = UIColor.blue
    }
    
    func onObjectRemoved(with view: YMKUserLocationView) {}
    
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {}
}

