//
//  ViewFinishedTutorialUITest.swift
//  Conari
//
//  Created by Philipp Preiner on 27.04.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import XCTest

class ViewFinishedTutorialUITest: XCTestCase {
  
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
  
  func testIfElementsExist() {
    
    sleep(1);
    
    let app = XCUIApplication()
    
    
    // Navigate to a tutorial
    app.buttons["Continue without login"].tap()
    
    sleep(1);
    
    let tablesQuery = app.tables
    tablesQuery.staticTexts["Arts and Entertainment"].tap()
    tablesQuery.cells.containingType(.StaticText, identifier:"ccc").staticTexts["Arts and Entertainment"].tap()
    
    //sleep(1);
    
    //Check if activity Indicator shows up
    //let inProgressActivityIndicator = app.activityIndicators["In progress"]
    //inProgressActivityIndicator.tap()
    
    sleep(1);
    
    // Check if Webview Exists by clicking on the image inside it.
    app.images["picture"].tap()
    
    sleep(1);
    
    
    // Check if Buttons in header exist
    let cccNavigationBar = app.navigationBars["ccc"]
    XCTAssertTrue(cccNavigationBar.buttons["info"].exists, "Info Button doesn't exist")
    cccNavigationBar.childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
  }
  
}
