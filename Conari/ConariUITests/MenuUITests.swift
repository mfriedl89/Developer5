//
//  MenuUITests.swift
//  Conari
//
//  Created by Paul Krassnig on 04.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import XCTest

class MenuUITests: XCTestCase {
        
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
    
    
    func testMenu() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app = XCUIApplication()
        let answerButton = app.buttons["Login"]
        answerButton.tap()
        
        sleep(1);

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
        textFieldPassword.typeText("test1234@")
        
        app.buttons["Login"].tap()

        app.buttons["Search Tutorials"].tap()
        app.navigationBars["Conari"].buttons["Menu"].tap()
        app.buttons["Create Tutorial"].tap()
        app.navigationBars["Tutorial"].buttons["Menu"].tap()
        app.buttons["Manage Tutorials"].tap()
        app.buttons["Change First Name and Surname"].tap()
        app.navigationBars["Change Name"].buttons["Menu"].tap()
        app.buttons["Change Email"].tap()
        app.navigationBars["Change Email"].buttons["Menu"].tap()
        app.buttons["Change password"].tap()
        app.navigationBars["Change password"].buttons["Menu"].tap()
        app.buttons["Logout"].tap()




        
    }

    
    
}