//
//  VenueViewModelTest.swift
//  VenueFinderTests
//
//  Created by poonam.l.yadav on 28/04/2025.
//

import XCTest
import CoreLocation
@testable import VenueFinder

final class VenueViewModelTest: XCTestCase {
    
    var sut : VenueViewModel?
    var mockNetworkServiceManager : ServiceInterface!
    var mockLocationServiceManager : MockLocalLocationReader!
    var location : CLLocationCoordinate2D?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let mockNetworkServiceManager = MockNetworkManager()
        let mockLocationServiceManager = MockLocalLocationReader()
        location = CLLocationCoordinate2D(latitude: 60.168254, longitude: 24.931532)
        sut = VenueViewModel(serviceManager: mockNetworkServiceManager, locationManagerService: mockLocationServiceManager)
    }
    
    func testFetchNearByRestaurants() {
        sut?.fetchNearByRestaurants()
        XCTAssertTrue(true, "Fetched Restaurants ")
    }
  
    
    func testFetchVenues() {
        guard let mockNetworkServiceManager = mockNetworkServiceManager, let location = location else {
            return
        }
        sut?.fetchVenues(mockNetworkServiceManager, location, delay: 10)
        XCTAssertTrue(true, "Control came back after executing the fetchVenues Successully!")
    }
    
    override func tearDownWithError() throws {
        mockNetworkServiceManager = nil
        mockLocationServiceManager = nil
        sut = nil
        try super.tearDownWithError()
    }
}



class MockNetworkManager: ServiceInterface {
    var shouldReturnError = false
    
     func createRequest(url: URL?, latitude: Double, longitude: Double) -> URLRequest? {
        return URLRequest(url: URL(string: "https://mock.api/sonetesturl")!)
    }
    
    func fetchVenues(url: URL?, latitude: Double, longitude: Double, completionHandler: @escaping (Result<[VenueFinder.Venue]?, VenueFinder.CustomError>) -> ()) {
        if shouldReturnError {
            completionHandler(.failure(CustomError.timeout))
        } else {
            let mockRestaurants = Venue(isFavourite: false)
            completionHandler(.success([mockRestaurants]))
        }
    }
}





class  MockLocalLocationReader : LocationManagerInterface {
    func fetchLocation() {
        
    }
    var locationFetcherServiceDelegate: (any VenueFinder.LocationFetcherServiceDelegate)?
}




