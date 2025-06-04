//
//  LocationManagerService.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 26/04/2025.
//

import Foundation
import CoreLocation


class LocationManagerService: NSObject, LocationManagerInterface {

    private var locationManager : CLLocationManager?
    weak var locationFetcherServiceDelegate: LocationFetcherServiceDelegate?
    var callCompletionHandler: (([CLLocation]) -> Void)?
    var callErrorHandler: ((Error) -> Void)?

    func fetchLocation() {
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyReduced
        locationManager?.activityType = .fitness
        locationManager?.delegate = self
    }

}


extension LocationManagerService: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted:
            print("its restricated")
        case .denied:
            print("Location Service is disabled at device level")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let _ = locations.last else { return }
        locationFetcherServiceDelegate?.didFetchLocations(locationData: locations)
        locationManager?.stopUpdatingLocation()
    }    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationFetcherServiceDelegate?.didFailedToFetchLocation(error: error)
        locationManager?.stopUpdatingLocation()
    }
}

