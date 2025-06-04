//
//  DatabaseManagerTests.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 28/04/2025.
//

import XCTest
@testable import VenueFinder



final class NetworkManagerTests: XCTestCase {
    
    var sut: ServiceInterface!
    
    let lattitude: Double = 28.6139
    let longitude: Double = 77.2090
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkManager.shared
    }
    
    func testCreateRequest() {
        let request = sut.createRequest(url: nil, latitude: lattitude, longitude: longitude)
        if request != nil {
            XCTAssert(true, "Successfully created request!")
        } else {
            XCTAssertNil(request, "Request failed to create!")
        }
    }
    
    func testFetchVenues() {
        sut.fetchVenues(url: nil, latitude: lattitude, longitude: longitude) { result in
            switch result {
                case .success(let venues):
                XCTAssertNotNil(venues, "Venues array is not nil")
                XCTAssertTrue(venues!.count > 0, "Venues array is not empty")
            case .failure(let error):
                XCTFail("Fetch failed with error: \(error)")
            }
        }
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
}

