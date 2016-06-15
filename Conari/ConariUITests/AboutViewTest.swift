//
//  AboutViewTest.swift
//  Conari
//
//  Created by Paul Krassnig on 15.06.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import XCTest

class AboutViewTest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTheView() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
      sleep(1)
      let app = XCUIApplication()
      sleep(1)
      app.buttons["About"].tap()
      sleep(1)
      
      XCTAssert(app.staticTexts["Martin Steiner"].exists)
      XCTAssert(app.staticTexts["Felix Resch"].exists)
      XCTAssert(app.staticTexts["Anika Jaindl"].exists)
      XCTAssert(app.staticTexts["Benjamin Wullschleger"].exists)
      XCTAssert(app.staticTexts["Christina Seiringer"].exists)
      XCTAssert(app.staticTexts["Markus Friedl"].exists)
      XCTAssert(app.staticTexts["Markus Schofnegger"].exists)
      XCTAssert(app.staticTexts["Paul Krassnig"].exists)
      XCTAssert(app.staticTexts["Philipp Preiner"].exists)
      XCTAssert(app.staticTexts["Stefan Mitterrutzner"].exists)
      
    }
    
}
