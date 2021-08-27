//
//  LocationManager.swift
//  RestEat
//
//  Created by snoopy on 04/08/2021.
//

import UIKit
import CoreLocation

extension Coordinate {
    init(location: CLLocation) {
        latitude  = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
}

final class LocationManager: NSObject, CLLocationManagerDelegate {
    fileprivate var manager = CLLocationManager()
    var onLocationUpdate: ((Coordinate) -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestLocation()
    }
    
    func getPermission() {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        let coordinate = Coordinate(location: location)
        if let onLocationUpdate = onLocationUpdate {
            onLocationUpdate(coordinate)
        }
        
    }
    
}
