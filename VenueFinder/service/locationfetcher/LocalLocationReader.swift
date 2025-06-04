//
//  LocalLocationReader.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 27/04/2025.
//

import CoreLocation


final class LocalLocationReader: LocationManagerInterface {
    weak var locationFetcherServiceDelegate: (any LocationFetcherServiceDelegate)?
    var callCompletionHandler: (([CLLocation]) -> Void)?

    func fetchLocation() {
        let locations =  CustomLocation().locations
        locationFetcherServiceDelegate?.didFetchLocations(locationData: locations)
    }
}


// returns location array 
struct CustomLocation {
    var locations: [CLLocation]
    init() {
        let defaultCoordinates = [
                   CLLocationCoordinate2D(latitude: 60.169418, longitude: 24.931618),
                   CLLocationCoordinate2D(latitude: 60.169818, longitude: 24.932906),
                   CLLocationCoordinate2D(latitude: 60.170005, longitude: 24.935105),
                   CLLocationCoordinate2D(latitude: 60.169108, longitude: 24.936210),
                   CLLocationCoordinate2D(latitude: 60.168355, longitude: 24.934869),
                   CLLocationCoordinate2D(latitude: 60.167560, longitude: 24.932562),
                   CLLocationCoordinate2D(latitude: 60.168254, longitude: 24.931532),
                   CLLocationCoordinate2D(latitude: 60.169012, longitude: 24.930341),
                   CLLocationCoordinate2D(latitude: 60.170085, longitude: 24.929569)
               ]
        self.locations = defaultCoordinates.map { CLLocation(latitude: $0.latitude, longitude: $0.longitude) }
    }
}

