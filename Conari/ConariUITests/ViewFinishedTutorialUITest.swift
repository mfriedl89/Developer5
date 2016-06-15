//
//  ViewFinishedTutorialUITest.swift
//  Tutorialcloud
//
//  Created on 27.04.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import XCTest

class ViewFinishedTutorialUITest: XCTestCase {
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    XCUIApplication().launch()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testIfElementsExist() {
    
    sleep(1)
    
    let app = XCUIApplication()
    
    app.buttons["Continue without login"].tap()
    
    sleep(1)
    
    let titleTextField = app.textFields["searchForTextfield"]
    titleTextField.tap()
    titleTextField.clearAndEnterText("ccc")
    
    app.buttons["Done"].tap()
    
    app.tables.childrenMatchingType(.Cell).elementBoundByIndex(0).childrenMatchingType(.StaticText).elementBoundByIndex(0).tap()
    
    
    sleep(1)
    
    app.images["picture"].tap()
    
    sleep(1)
    
    let cccNavigationBar = app.navigationBars.elementBoundByIndex(0)
    cccNavigationBar.childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
  }
  
}
