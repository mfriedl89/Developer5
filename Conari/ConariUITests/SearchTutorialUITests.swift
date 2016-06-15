//
//  SearchTutorialUITests.swift
//  Tutorialcloud
//
//  Created on 11.05.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import XCTest

class SearchTutorialUITests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    XCUIApplication().launch()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testSimpleSearch() {
    sleep(1)
    
    let app = XCUIApplication()
    let answerButton = app.buttons["Continue without login"]
    answerButton.tap()
    
    sleep(1)
    let element = app.otherElements.containingType(.NavigationBar, identifier:"Tutorialcloud").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
    
    let textField = element.childrenMatchingType(.TextField).element
    textField.tap()
    textField.typeText("test")
    
    let searchButton = app.buttons["Search"]
    searchButton.tap()
    
    XCTAssert(app.staticTexts["test"].exists)
  }
  
}
