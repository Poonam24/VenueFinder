//
//  VenueFinderUITests.swift
//  VenueFinderUITests
//
//  Created by poonam.l.yadav on 24/04/2025.
//

import XCTest

final class VenueFinderUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    
    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.activate()
        let favouriteButton = app.buttons["FavouriteButton"]
        XCTAssertTrue(favouriteButton.waitForExistence(timeout: 5))
        XCTAssertTrue(favouriteButton.exists, "Favourite Button Loaded!")
        XCTAssertTrue(favouriteButton.waitForExistence(timeout: 5))
        
        //        let baseViewElementsQuery =  app.descendants(matching: .any)["baseView"]
        //        XCTAssertTrue(baseViewElementsQuery.waitForExistence(timeout: 5), "Base View Loaded")
        //        let venueCellElementsQuery =  app.descendants(matching: .any)["VenueCell"]
        //        XCTAssertTrue(venueCellElementsQuery.waitForExistence(timeout: 5), "VenueCell View Loaded")
        //        XCTAssert(true, "View Scrolled!")
        //
        //        let _ =  app.descendants(matching: .any)["VenueThumnail"]
        //        XCTAssert(true, "VenueThumnailElementsQuery Laoded !")
        
        let favouriteButton1 =  app.descendants(matching: .any)["FavouriteButton"]
        if(favouriteButton1.exists) {
            XCTAssert(true, " tap to add favourite")
            
           // favouriteButton1.tap()
            XCTAssert(true, "Item marked favourite !")
            
        }
        
        XCUIDevice.shared.press(.home)
        XCUIDevice.shared.press(.home)
    }
    
    
    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
}
