//
//  EditTutorial.swift
//  Tutorialcloud
//
//  Created on 25.05.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import XCTest

class EditTutorial: XCTestCase {
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    XCUIApplication().launch()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testExample() {
    
    let app = XCUIApplication()
    sleep(1)
    let answerButton = app.buttons["Login"]
    answerButton.tap()
    
    sleep(1)
    
    let textFieldUsername = app.textFields["username"]
    let textFieldPassword = app.secureTextFields["password"]
    XCTAssert(app.staticTexts["Username:"].exists)
    XCTAssert(app.staticTexts["Password:"].exists)
    
    textFieldUsername.tap()
    XCTAssertTrue(textFieldUsername.exists, "Text field username doesn't exist")
    textFieldUsername.typeText("anton")
    XCTAssertEqual(textFieldUsername.value as? String, "anton")
    
    textFieldPassword.tap()
    XCTAssertTrue(textFieldPassword.exists, "Text field password doesn't exist")
    textFieldPassword.typeText("Test1234@")
    
    app.buttons["Login"].tap()
    
    app.buttons["Manage Tutorials"].tap()
    
    let tablesQuery = app.tables
    tablesQuery.cells.containingType(.StaticText, identifier:"ccc").staticTexts["Arts and Entertainment"].tap()
    
    let titleTextField = app.textFields["title"]
    titleTextField.tap()
    titleTextField.clearAndEnterText("ccc")
    app.steppers.buttons["Increment"].tap()
    app.navigationBars["Edit Tutorial"].buttons["Next"].tap()
    app.otherElements["texteditor"].childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.TextField).element.tap()
    app.typeText("\r")
    app.typeText("Test")
    app.typeText("\r")
    app.navigationBars["ccc"].buttons["Save"].tap()
  }
  
}
