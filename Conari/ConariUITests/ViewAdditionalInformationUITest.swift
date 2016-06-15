//
//  ViewAdditionalInformationUITest.swift
//  Tutorialcloud
//
//  Created on 11.05.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import XCTest

class ViewAdditionalInformationUITest: XCTestCase {
  
  override func setUp() {
    super.setUp()

    continueAfterFailure = false

    XCUIApplication().launch()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testInformationFields() {

    sleep(1)
    
    let app = XCUIApplication()
    app.buttons["Continue without login"].tap()
    
    sleep(1)
    
    let tablesQuery = app.tables
    tablesQuery.staticTexts["Arts and Entertainment"].tap()
    
    sleep(1)
    
    app.tables.childrenMatchingType(.Cell).elementBoundByIndex(0).childrenMatchingType(.StaticText).elementBoundByIndex(0).tap()
    
    sleep(1)
    
    app.navigationBars.buttons["More Info"].tap()

  }
  
}
