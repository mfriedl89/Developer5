//
//  AboutViewTest.swift
//  Tutorialcloud
//
//  Created on 15.06.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import XCTest

class AboutViewTest: XCTestCase {
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    XCUIApplication().launch()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testTheView() {
    
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
