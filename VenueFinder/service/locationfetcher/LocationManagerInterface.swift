//
//  LocationReaderInterface.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 27/04/2025.
//

import CoreLocation

protocol LocationFetcherServiceDelegate: AnyObject {
    func didFetchLocations(locationData: [CLLocation])
    func didFailedToFetchLocation(error: Error)
}


protocol LocationManagerInterface: AnyObject {
    func fetchLocation()
    var locationFetcherServiceDelegate: LocationFetcherServiceDelegate? {get set}
}
