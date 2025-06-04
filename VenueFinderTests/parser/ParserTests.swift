//
//  ParserTests.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 30/04/2025.
//

import XCTest
import CoreLocation
@testable import VenueFinder

final class ParserTests: XCTestCase {
    
    var sut: ParserInterface!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Parser()
    }
    
    
    func testParseResult() {
        guard let url = Bundle.main.url(forResource: "MockResponse", withExtension: "json") else {
            XCTFail("Failed to find file MockResponse in bundle.")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let venueList = sut.parseResult(from: data)
            XCTAssert(venueList.count > 0 , "Successfully parsed the file")
        } catch {
            XCTFail("Error parsing JSON file: \(error.localizedDescription)")
        }
    }
    
    // Test Failed case by Parsing for invalid response
    func testParseResultFailed() {
        guard let url = Bundle.main.url(forResource: "MockFailedResponse", withExtension: "json") else {
            XCTFail("Failed to find file MockFailedResponse in bundle.")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let _ = sut.parseResult(from: data)
            XCTAssert(true, "Failed to parse file in bundle due to wrong structure")
        } catch {
            XCTAssert(true, "Error parsing JSON file: \(error.localizedDescription)")
        }
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
}
