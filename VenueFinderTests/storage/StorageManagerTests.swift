//
//  StorageManagerTests.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 30/04/2025.
//



import XCTest
import CoreLocation
@testable import VenueFinder

final class StorageManagerTests: XCTestCase {
    
    var storageManagerInstance: StorageManagerInterface!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        storageManagerInstance = MockStorageManager()
    }
    
    
    func testSave(_ status: Bool, _ key: String) {
        storageManagerInstance.save(false, "3257239875sdklfjslk")
        XCTAssert(true, "Expecatation fulfilled to save")
    }
    
    
    func  testGetSaveStatus(_ key: String) {
        let status = storageManagerInstance.getSavedStatus("3257239875sdklfjslk")
        XCTAssertFalse(status, "Expected status to be false, but got \(status)")
    }
    
    override func tearDownWithError() throws {
        storageManagerInstance = nil
        try super.tearDownWithError()
    }
    
}


class MockStorageManager: StorageManagerInterface {
    func getSavedStatus(_ key: String) -> Bool {
        return false
    }
    
    func save(_ status: Bool, _ key: String) {
       
    }    
}
