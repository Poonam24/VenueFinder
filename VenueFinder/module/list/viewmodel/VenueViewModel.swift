//
//  VenueViewModel.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 24/04/2025.
//


import Foundation
import CoreLocation

protocol VenueViewModelInterface {
    func fetchNearByRestaurants()
    func updateUserLocation()
    func fetchVenues(_ service: ServiceInterface , _ location: CLLocationCoordinate2D, delay : Int)
}

final class VenueViewModel: VenueViewModelInterface {
    
    private var locationsArray : [CLLocation] = []
    private var currentLocationIndex = 1

    weak var delegate: ViewModelDelegate?

    var locationFetcherService: LocationManagerInterface?
    var serviceManager: ServiceInterface?
    var venues: [Venue]?
    
    // for location reader - location is created locally in locallocation reader but the interface provides provision to tweak with CLLocation manager also.
    init(serviceManager: ServiceInterface?, locationManagerService: LocationManagerInterface?) {
        self.locationFetcherService = locationManagerService
        self.locationFetcherService?.locationFetcherServiceDelegate = self
        self.serviceManager = serviceManager
    }
    
    // fetching next set of data based on user location
     func updateUserLocation() {
        guard let serviceManager = serviceManager else { return }
        fetchVenues(serviceManager, locationsArray[currentLocationIndex].coordinate, delay: 10)
        currentLocationIndex = ((currentLocationIndex) + 1) % locationsArray.count
    }
    
    // invokes network level fetch data method
    func fetchVenues(_ service: ServiceInterface , _ location: CLLocationCoordinate2D, delay : Int) {
        delegate?.showLoader()
        
        DispatchQueue.global().async( group: nil, qos: .userInitiated, flags: [], execute: {
                service.fetchVenues(url: nil, latitude: location.latitude, longitude: location.longitude) { [weak self] result in
                    switch result {
                    case .success(let venueList) :
                        //updating of data with barrier flag to be be thread safe and avoid updating data from two threads
                        DispatchQueue.global().async( group: nil, qos: .userInitiated, flags: .barrier, execute: {                guard let venueList = venueList else {return}
                            self?.venues = venueList.map { $0 }
                        })
                        self?.delegate?.didUpdateData()
                    case .failure(let error):
                        self?.delegate?.didFailedToUpdateData(error)
                    }
                    self?.delegate?.hideLoader()
                }
            }
        )
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(delay), execute: {
            self.updateUserLocation()
        })
    }
    
    // entry point for view to get data
    func fetchNearByRestaurants() {
        self.locationFetcherService?.fetchLocation()
    }
    
}

// handles success and failure case
extension VenueViewModel : LocationFetcherServiceDelegate {
    func didFetchLocations(locationData: [CLLocation]) {
        locationsArray = locationData
        fetchVenues(NetworkManager.shared, locationsArray[0].coordinate, delay: 0)
    }
    
    func didFailedToFetchLocation(error: any Error) {
        self.delegate?.didFailedToUpdateData(error as! CustomError)
    }
}
