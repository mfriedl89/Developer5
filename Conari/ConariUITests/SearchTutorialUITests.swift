//
//  SearchTutorialUITests.swift
//  Conari
//
//  Created by Stefan Mitterrutzner on 11/05/16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import XCTest

class SearchTutorialUITests: XCTestCase {
  
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
  
  func testSimpleSearch() {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
   
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
    
    //let conariButton = app.navigationBars["Test"].buttons["Conari"]
    
  }
  
}
