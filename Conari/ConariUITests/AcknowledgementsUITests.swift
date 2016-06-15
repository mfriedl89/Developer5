//
//  AcknowledgementsUITests.swift
//  Conari
//
//  Created by Stefan Mitterrutzner on 15/06/16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import XCTest

class AcknowledgementsUITests: XCTestCase {
    
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

    func testExample() {
      
      sleep(1)
      let app = XCUIApplication()
      sleep(1)
      app.buttons["About"].tap()
      sleep(1)
      app.buttons["Acknowledgements"].tap()
      
      let _ = app.otherElements["Open Source Licenses"].childrenMatchingType(.Other).elementBoundByIndex(6).staticTexts["Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:"]
      
  }

}
