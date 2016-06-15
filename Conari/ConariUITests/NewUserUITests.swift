//
//  NewUserUITests.swift
//  Tutorialcloud
//
//  Created on 13.04.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import XCTest

class NewUserUITests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    XCUIApplication().launch()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testAllUIElements() {
    sleep(1);
    
    let app = XCUIApplication()
    app.buttons["Login"].tap()
    let exists = NSPredicate(format: "exists == true")
    
    let newUserButton = app.buttons["Create new user"]
    expectationForPredicate(exists, evaluatedWithObject: newUserButton, handler: nil)
    waitForExpectationsWithTimeout(5, handler: nil)
    
    app.buttons["Create new user"].tap()
    
    sleep(1);
    
    XCTAssert(app.staticTexts["Desired username:"].exists)
    XCTAssert(app.staticTexts["First name:"].exists)
    XCTAssert(app.staticTexts["Surname:"].exists)
    XCTAssert(app.staticTexts["Email address:"].exists)
    XCTAssert(app.staticTexts["Password:"].exists)
    XCTAssert(app.staticTexts["Repeat password:"].exists)
    
    
    let textFieldUsername = app.textFields["desiredUsername"]
    textFieldUsername.tap()
    textFieldUsername.typeText("anton")
    XCTAssertEqual(textFieldUsername.value as? String, "anton")
    
    let textFieldFirstName = app.textFields["firstName"]
    textFieldFirstName.tap()
    textFieldFirstName.typeText("Anton")
    XCTAssertEqual(textFieldFirstName.value as? String, "Anton")
    
    let textFieldSurname = app.textFields["surName"]
    textFieldSurname.tap()
    textFieldSurname.typeText("Müller")
    XCTAssertEqual(textFieldSurname.value as? String, "Müller")
    
    
    app.textFields["emailAddress"].tap()
    
    let textFieldEmail = app.textFields["emailAddress"]
    textFieldEmail.tap()
    textFieldEmail.typeText("hallo@aon.at")
    XCTAssertEqual(textFieldEmail.value as? String, "hallo@aon.at")
    
    let textFieldPassword = app.secureTextFields["password"]
    textFieldPassword.tap()
    textFieldPassword.typeText("P@sswort1234")
    
    
    let textFieldRepeatPassword = app.secureTextFields["repeatPassword"]
    textFieldRepeatPassword.tap()
    textFieldRepeatPassword.typeText("P@sswort1234")
//    app.buttons["Done"].tap()
    
  }
  
  func testFalseName() {
    
    sleep(1);
    
    let app = XCUIApplication()
    app.buttons["Login"].tap()
    let exists = NSPredicate(format: "exists == true")
    
    let newUserButton = app.buttons["Create new user"]
    expectationForPredicate(exists, evaluatedWithObject: newUserButton, handler: nil)
    waitForExpectationsWithTimeout(5, handler: nil)
    
    app.buttons["Create new user"].tap()
    
    sleep(1);
    
    XCTAssert(app.staticTexts["Desired username:"].exists)
    XCTAssert(app.staticTexts["First name:"].exists)
    XCTAssert(app.staticTexts["Surname:"].exists)
    XCTAssert(app.staticTexts["Email address:"].exists)
    XCTAssert(app.staticTexts["Password:"].exists)
    XCTAssert(app.staticTexts["Repeat password:"].exists)
    
    let textField = app.scrollViews.otherElements.textFields["desiredUsername"]
    textField.tap()
    textField.typeText(" ")
    
    let elementsQuery = app.scrollViews.otherElements
    let nextButton = app.buttons["Next:"]
    nextButton.tap()
    elementsQuery.textFields["firstName"].typeText("Anton")
    nextButton.tap()
    elementsQuery.textFields["surName"].typeText("Müller")
    nextButton.tap()
    elementsQuery.textFields["emailAddress"].typeText("hallo@aon.at")
    nextButton.tap()
    elementsQuery.secureTextFields["password"].typeText("Test1234@")
    nextButton.tap()
    elementsQuery.secureTextFields["repeatPassword"].typeText("Test1234@")
    
    sleep(1)
    app.buttons["Done"].tap()
    sleep(1)
    
    XCTAssert(app.staticTexts["Enter a valid username."].exists)
  }
  
  
  func testFalseFirstname() {

    sleep(1);
    
    let app = XCUIApplication()
    app.buttons["Login"].tap()
    let exists = NSPredicate(format: "exists == true")
    
    let newUserButton = app.buttons["Create new user"]
    expectationForPredicate(exists, evaluatedWithObject: newUserButton, handler: nil)
    waitForExpectationsWithTimeout(5, handler: nil)
    
    app.buttons["Create new user"].tap()
    
    sleep(1);
    
    XCTAssert(app.staticTexts["Desired username:"].exists)
    XCTAssert(app.staticTexts["First name:"].exists)
    XCTAssert(app.staticTexts["Surname:"].exists)
    XCTAssert(app.staticTexts["Email address:"].exists)
    XCTAssert(app.staticTexts["Password:"].exists)
    XCTAssert(app.staticTexts["Repeat password:"].exists)
    
    let textField = app.scrollViews.otherElements.textFields["desiredUsername"]
    textField.tap()
    textField.typeText("anton")
    
    let elementsQuery = app.scrollViews.otherElements
    let nextButton = app.buttons["Next:"]
    nextButton.tap()
    elementsQuery.textFields["firstName"].typeText("Anton$$$")
    nextButton.tap()
    elementsQuery.textFields["surName"].typeText("Müller")
    nextButton.tap()
    elementsQuery.textFields["emailAddress"].typeText("hallo@aon.at")
    nextButton.tap()
    elementsQuery.secureTextFields["password"].typeText("Test1234@")
    nextButton.tap()
    elementsQuery.secureTextFields["repeatPassword"].typeText("Test1234@")
    
    sleep(1)
    app.buttons["Done"].tap()
    sleep(1)
    
    XCTAssert(app.staticTexts["Enter a valid first name."].exists)
  }
  
  
  func testFalseSurName() {

    
    sleep(1);
    
    let app = XCUIApplication()
    app.buttons["Login"].tap()
    let exists = NSPredicate(format: "exists == true")
    
    let newUserButton = app.buttons["Create new user"]
    expectationForPredicate(exists, evaluatedWithObject: newUserButton, handler: nil)
    waitForExpectationsWithTimeout(5, handler: nil)
    
    app.buttons["Create new user"].tap()
    
    sleep(1);
    
    XCTAssert(app.staticTexts["Desired username:"].exists)
    XCTAssert(app.staticTexts["First name:"].exists)
    XCTAssert(app.staticTexts["Surname:"].exists)
    XCTAssert(app.staticTexts["Email address:"].exists)
    XCTAssert(app.staticTexts["Password:"].exists)
    XCTAssert(app.staticTexts["Repeat password:"].exists)
    
    let textField = app.scrollViews.otherElements.textFields["desiredUsername"]
    textField.tap()
    textField.typeText("anton")
    
    let elementsQuery = app.scrollViews.otherElements
    let nextButton = app.buttons["Next:"]
    nextButton.tap()
    elementsQuery.textFields["firstName"].typeText("Anton")
    nextButton.tap()
    elementsQuery.textFields["surName"].typeText("Müller$$$")
    nextButton.tap()
    elementsQuery.textFields["emailAddress"].typeText("hallo@aon.at")
    nextButton.tap()
    elementsQuery.secureTextFields["password"].typeText("Test1234@")
    nextButton.tap()
    elementsQuery.secureTextFields["repeatPassword"].typeText("Test1234@")
    
    sleep(1)
    app.buttons["Done"].tap()
    sleep(1)
    
    XCTAssert(app.staticTexts["Enter a valid surname."].exists)
  }
  
  
  func testFalseEmail() {

    
    sleep(1);
    
    let app = XCUIApplication()
    app.buttons["Login"].tap()
    let exists = NSPredicate(format: "exists == true")
    
    let newUserButton = app.buttons["Create new user"]
    expectationForPredicate(exists, evaluatedWithObject: newUserButton, handler: nil)
    waitForExpectationsWithTimeout(5, handler: nil)
    
    app.buttons["Create new user"].tap()
    
    sleep(1);
    
    XCTAssert(app.staticTexts["Desired username:"].exists)
    XCTAssert(app.staticTexts["First name:"].exists)
    XCTAssert(app.staticTexts["Surname:"].exists)
    XCTAssert(app.staticTexts["Email address:"].exists)
    XCTAssert(app.staticTexts["Password:"].exists)
    XCTAssert(app.staticTexts["Repeat password:"].exists)
    
    let textField = app.scrollViews.otherElements.textFields["desiredUsername"]
    textField.tap()
    textField.typeText("anton")
    
    let elementsQuery = app.scrollViews.otherElements
    let nextButton = app.buttons["Next:"]
    nextButton.tap()
    elementsQuery.textFields["firstName"].typeText("Anton")
    nextButton.tap()
    elementsQuery.textFields["surName"].typeText("Müller")
    nextButton.tap()
    elementsQuery.textFields["emailAddress"].typeText("hallo.at")
    nextButton.tap()
    elementsQuery.secureTextFields["password"].typeText("Test1234@")
    nextButton.tap()
    elementsQuery.secureTextFields["repeatPassword"].typeText("Test1234@")
    
    sleep(1)
    app.buttons["Done"].tap()
    sleep(1)
    
    XCTAssert(app.staticTexts["Enter a valid E-Mail address."].exists)
  }
  
  
  func testFalsePassword() {

    
    sleep(1);
    
    let app = XCUIApplication()
    app.buttons["Login"].tap()
    let exists = NSPredicate(format: "exists == true")
    
    let newUserButton = app.buttons["Create new user"]
    expectationForPredicate(exists, evaluatedWithObject: newUserButton, handler: nil)
    waitForExpectationsWithTimeout(5, handler: nil)
    
    app.buttons["Create new user"].tap()
    
    sleep(1);
    
    XCTAssert(app.staticTexts["Desired username:"].exists)
    XCTAssert(app.staticTexts["First name:"].exists)
    XCTAssert(app.staticTexts["Surname:"].exists)
    XCTAssert(app.staticTexts["Email address:"].exists)
    XCTAssert(app.staticTexts["Password:"].exists)
    XCTAssert(app.staticTexts["Repeat password:"].exists)
    
    let textField = app.scrollViews.otherElements.textFields["desiredUsername"]
    textField.tap()
    textField.typeText("anton")
    
    let elementsQuery = app.scrollViews.otherElements
    let nextButton = app.buttons["Next:"]
    nextButton.tap()
    elementsQuery.textFields["firstName"].typeText("Anton")
    nextButton.tap()
    elementsQuery.textFields["surName"].typeText("Müller")
    nextButton.tap()
    elementsQuery.textFields["emailAddress"].typeText("hallo@aon.at")
    nextButton.tap()
    elementsQuery.secureTextFields["password"].typeText("Test1234")
    nextButton.tap()
    elementsQuery.secureTextFields["repeatPassword"].typeText("Test1234@")
    
    sleep(1)
    app.buttons["Done"].tap()
    sleep(1)
    
    XCTAssert(app.staticTexts["A password must contain one uppercase letter, one lowercase letter, one digit, one special character and is between 9 and 31 characters long."].exists)
  }

  
  func testFalseRepeatedPassword() {

    
    sleep(1);
    
    let app = XCUIApplication()
    app.buttons["Login"].tap()
    let exists = NSPredicate(format: "exists == true")
    
    let newUserButton = app.buttons["Create new user"]
    expectationForPredicate(exists, evaluatedWithObject: newUserButton, handler: nil)
    waitForExpectationsWithTimeout(5, handler: nil)
    
    app.buttons["Create new user"].tap()
    
    sleep(1);
    
    XCTAssert(app.staticTexts["Desired username:"].exists)
    XCTAssert(app.staticTexts["First name:"].exists)
    XCTAssert(app.staticTexts["Surname:"].exists)
    XCTAssert(app.staticTexts["Email address:"].exists)
    XCTAssert(app.staticTexts["Password:"].exists)
    XCTAssert(app.staticTexts["Repeat password:"].exists)
    
    let textField = app.scrollViews.otherElements.textFields["desiredUsername"]
    textField.tap()
    textField.typeText("anton")
    
    let elementsQuery = app.scrollViews.otherElements
    let nextButton = app.buttons["Next:"]
    nextButton.tap()
    elementsQuery.textFields["firstName"].typeText("Anton")
    nextButton.tap()
    elementsQuery.textFields["surName"].typeText("Müller")
    nextButton.tap()
    elementsQuery.textFields["emailAddress"].typeText("hallo@aon.at")
    nextButton.tap()
    elementsQuery.secureTextFields["password"].typeText("Test1234@")
    nextButton.tap()
    elementsQuery.secureTextFields["repeatPassword"].typeText("Test1234")
    
    sleep(1)
    app.buttons["Done"].tap()
    sleep(1)
    
    XCTAssert(app.staticTexts["Passwords are not the same."].exists)
  }

}
