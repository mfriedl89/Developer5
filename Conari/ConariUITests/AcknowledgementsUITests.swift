//
//  AcknowledgementsUITests.swift
//  Tutorialcloud
//
//  Created on 15.06.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import XCTest

class AcknowledgementsUITests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    XCUIApplication().launch()
    
  }
  
  override func tearDown() {
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
