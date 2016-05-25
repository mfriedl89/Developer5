//
//  NewUserUITests.swift
//  Conari
//
//  Created by Paul Krassnig on 13.04.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import XCTest

class NewUserUITests: XCTestCase {
  
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
  
  func testAllUIElements() {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    

    
    
    /*let app = XCUIApplication()
    app.buttons["Login"].tap()
    //sleep(1)
    //let exists = NSPredicate(format: "exists == true")
    
    // wait until next page appears before clicking the "Create new user" button.
    let newUserButton = app.buttons["Create new user"]
    //expectationForPredicate(exists, evaluatedWithObject: newUserButton, handler: nil)
    //waitForExpectationsWithTimeout(5, handler: nil)
    sleep(1)*/
    
    let app = XCUIApplication()
    app.buttons["Login"].tap()
    usleep(500)
    app.buttons["Create new user"].tap()
    
    
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
}
