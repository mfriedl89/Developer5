//
//  MenuUITests.swift
//  Tutorialcloud
//
//  Created on 04.05.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import XCTest

extension XCUIElement {
  
  func clearAndEnterText(text: String) -> Void {
    guard let stringValue = self.value as? String else {
      XCTFail("Tried to clear and enter text into a non string value")
      return
    }
    
    self.tap()
    
    var deleteString: String = ""
    for _ in stringValue.characters {
      deleteString += "\u{8}"
    }
    self.typeText(deleteString)
    
    self.typeText(text)
  }
}

class MenuUITests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    XCUIApplication().launch()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testMenu() {
    
    sleep(1)
    
    let app = XCUIApplication()
    let answerButton = app.buttons["Login"]
    answerButton.tap()
    
    sleep(1)
    
    let textFieldUsername = app.textFields["username"]
    let textFieldPassword = app.secureTextFields["password"]
    
    textFieldUsername.tap()
    XCTAssertTrue(textFieldUsername.exists, "Text field username doesn't exist")
    textFieldUsername.typeText("anton")
    XCTAssertEqual(textFieldUsername.value as? String, "anton")
    
    sleep(1)
    
    textFieldPassword.tap()
    XCTAssertTrue(textFieldPassword.exists, "Text field password doesn't exist")
    textFieldPassword.typeText("Test1234@")
    
    app.buttons["Login"].tap()
    
    sleep(1)
    
    app.buttons["Search Tutorials"].tap()
    sleep(1)
    app.navigationBars["Tutorialcloud"].buttons["Menu"].tap()
    sleep(1)
    app.buttons["Create Text Tutorial"].tap()
    sleep(1)
    app.navigationBars["Text Tutorial"].buttons["Menu"].tap()
    sleep(1)
    app.buttons["Create Video Tutorial"].tap()
    sleep(1)
    app.navigationBars["Video Tutorial"].buttons["Menu"].tap()
    sleep(1)
    app.buttons["Manage Tutorials"].tap()
    sleep(1)
    app.navigationBars["My Tutorials"].buttons["Menu"].tap()
    sleep(1)
    app.buttons["Change Name"].tap()
    sleep(1)
    app.navigationBars["Change Name"].buttons["Menu"].tap()
    sleep(1)
    app.buttons["Change Email"].tap()
    sleep(1)
    app.navigationBars["Change Email"].buttons["Menu"].tap()
    sleep(1)
    app.buttons["Change password"].tap()
    sleep(1)
    app.navigationBars["Change password"].buttons["Menu"].tap()
    sleep(1)
    
    app.buttons["Logout"].tap()
  }
  
  func testChangeName() {
    sleep(1)
    
    let app = XCUIApplication()
    let answerButton = app.buttons["Login"]
    answerButton.tap()
    
    sleep(1)
    
    let textFieldUsername = app.textFields["username"]
    let textFieldPassword = app.secureTextFields["password"]
    
    textFieldUsername.tap()
    XCTAssertTrue(textFieldUsername.exists, "Text field username doesn't exist")
    textFieldUsername.typeText("anton")
    XCTAssertEqual(textFieldUsername.value as? String, "anton")
    
    textFieldPassword.tap()
    XCTAssertTrue(textFieldPassword.exists, "Text field password doesn't exist")
    textFieldPassword.typeText("Test1234@")
    
    app.buttons["Login"].tap()
    
    app.buttons["Change Name"].tap()
    
    app.textFields["Firstname"].tap()
    app.textFields["Firstname"].clearAndEnterText("Paul")
    
    app.textFields["Surname"].tap()
    app.textFields["Surname"].clearAndEnterText("Tester")
    
    app.buttons["Done"].tap()
    
    sleep(1)
    
    app.navigationBars["Change Name"].buttons["Menu"].tap()
    
    sleep(1)
    
    app.buttons["Change Name"].tap()
    
    sleep(1)
    
    XCTAssertEqual(app.textFields["Firstname"].value as? String, "Paul")
    XCTAssertEqual(app.textFields["Surname"].value as? String, "Tester")
    
    app.navigationBars["Change Name"].buttons["Menu"].tap()
    
    sleep(1)
    
    app.buttons["Logout"].tap()
  }
  
  func testChangeMail() {
    
    sleep(1);
    
    let app = XCUIApplication()
    let answerButton = app.buttons["Login"]
    answerButton.tap()
    
    sleep(1);
    
    let textFieldUsername = app.textFields["username"]
    let textFieldPassword = app.secureTextFields["password"]
    
    textFieldUsername.tap()
    XCTAssertTrue(textFieldUsername.exists, "Text field username doesn't exist")
    textFieldUsername.typeText("anton")
    XCTAssertEqual(textFieldUsername.value as? String, "anton")
    
    textFieldPassword.tap()
    XCTAssertTrue(textFieldPassword.exists, "Text field password doesn't exist")
    textFieldPassword.typeText("Test1234@")
    
    app.buttons["Login"].tap()
    
    app.buttons["Change Email"].tap()
    
    app.textFields["newEmail"].tap()
    app.textFields["newEmail"].clearAndEnterText("test@anton.at")
    
    app.textFields["repeatedEmail"].tap()
    app.textFields["repeatedEmail"].clearAndEnterText("test@anton.at")
    
    app.buttons["DoneButton"].tap()
    app.navigationBars["Change Email"].buttons["Menu"].tap()
    
    app.buttons["Change Email"].tap()
    
    app.textFields["newEmail"].tap()
    app.textFields["newEmail"].clearAndEnterText("anton@test.at")
    
    app.textFields["repeatedEmail"].tap()
    app.textFields["repeatedEmail"].clearAndEnterText("anton@test.at")
    
    app.buttons["DoneButton"].tap()
    
    app.navigationBars["Change Email"].buttons["Menu"].tap()
    
    
    app.buttons["Logout"].tap()
  }
  
  func testChangePassword() {
    
    sleep(1);
    
    let app = XCUIApplication()
    let answerButton = app.buttons["Login"]
    answerButton.tap()
    
    sleep(1);
    
    let textFieldUsername = app.textFields["username"]
    let textFieldPassword = app.secureTextFields["password"]
    
    textFieldUsername.tap()
    XCTAssertTrue(textFieldUsername.exists, "Text field username doesn't exist")
    textFieldUsername.typeText("anton")
    XCTAssertEqual(textFieldUsername.value as? String, "anton")
    
    textFieldPassword.tap()
    XCTAssertTrue(textFieldPassword.exists, "Text field password doesn't exist")
    textFieldPassword.typeText("Test1234@")
    
    app.buttons["Login"].tap()
    
    sleep(1);
    
    app.buttons["Change password"].tap()
    
    sleep(1);
    
    app.secureTextFields["oldPassword"].tap()
    app.secureTextFields["oldPassword"].clearAndEnterText("Test1234@")
    
    app.secureTextFields["newPassword"].tap()
    app.secureTextFields["newPassword"].clearAndEnterText("Test1235@")
    
    app.secureTextFields["repeatedPassword"].tap()
    app.secureTextFields["repeatedPassword"].clearAndEnterText("Test1235@")
    
    app.buttons["DoneButton"].tap()
    
    sleep(1);
    
    app.navigationBars["Change password"].buttons["Menu"].tap()
    
    sleep(1);
    
    app.buttons["Change password"].tap()
    
    app.secureTextFields["oldPassword"].tap()
    app.secureTextFields["oldPassword"].clearAndEnterText("Test1235@")
    
    app.secureTextFields["newPassword"].tap()
    app.secureTextFields["newPassword"].clearAndEnterText("Test1234@")
    
    app.secureTextFields["repeatedPassword"].tap()
    app.secureTextFields["repeatedPassword"].clearAndEnterText("Test1234@")
    
    app.buttons["DoneButton"].tap()
    sleep(1);
    app.navigationBars["Change password"].buttons["Menu"].tap()
    sleep(1);
    
    app.buttons["Logout"].tap()
  }
  
}