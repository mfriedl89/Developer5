//
//  ViewAdditionalInformationUITest.swift
//  Conari
//
//  Created by Christina Seiringer on 11.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import XCTest

class ViewAdditionalInformationUITest: XCTestCase {
  
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
  
  func testInformationFields() {
    // navigate to view
    
    
    sleep(1);
    
    let app = XCUIApplication()
    app.buttons["Continue without login"].tap()
    
    sleep(1);
    
    let tablesQuery = app.tables
    tablesQuery.staticTexts["Arts and Entertainment"].tap()
    
    sleep(1);
    
    tablesQuery.childrenMatchingType(.Cell).elementBoundByIndex(0).staticTexts["ccc"].tap()
    app.navigationBars.buttons["info"].tap()
    
    /*
    sleep(1);
    // check if elements exist
    for cell in 0...4 {
      XCTAssertTrue(app.tables.element.cells.elementBoundByIndex(UInt(cell)).exists)
    }
    
    // check information fields
    XCUIApplication().tables.staticTexts["Title"].tap()
    XCUIApplication().tables.staticTexts["Author"].tap()
    XCUIApplication().tables.staticTexts["Category"].tap()
    XCUIApplication().tables.staticTexts["Difficulty"].tap()
    XCUIApplication().tables.staticTexts["Duration"].tap()
    */
  }
  
}
