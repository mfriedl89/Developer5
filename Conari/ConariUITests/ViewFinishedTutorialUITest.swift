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
        let app = XCUIApplication()
        
        //go to view controller
        app.buttons["ViewTutorial"].tap()
        
        //check Label
        XCTAssertTrue(app.staticTexts["tutorialNameLabel"].exists, "Label for tutorial name doesn't exist")
        
        //check WebView
        XCTAssertTrue(app.otherElements.containingType(.NavigationBar, identifier:"Tutorial View").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.exists, "WebView doesn't exist")
        
        //check button
        let additionalInformationButton = app.buttons["additionalInformationButton"]
        XCTAssertTrue(additionalInformationButton.exists, "additionalInformationButton doesn't exist")
    }
    
}
