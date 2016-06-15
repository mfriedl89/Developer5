//
//  ViewFinishedTutorial.swift
//  Conari
//
//  Created by Philipp Preiner on 27.04.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import XCTest

class ViewFinishedTutorial: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testRequestExistingTutorial() {
    let tutorialID = 57
    
    // Declare our expectation
    let readyExpectation = expectationWithDescription("ready")
    
    DatabaseManager.sharedManager.requestTutorial(tutorialID) { tutorial, message in
      XCTAssertNotNil(tutorial, "no tutorial found")
      XCTAssertNil(message, "message should be nil")
      
      readyExpectation.fulfill()
    }
    
    // Loop until the expectation is fulfilled
    waitForExpectationsWithTimeout(10, handler: { error in
      XCTAssertNil(error, "Error")
    })
  }
  
  
  func testRequestMissingTutorial() {
    let tutorialID = 2
    
    // Declare our expectation
    let readyExpectation = expectationWithDescription("ready")
    
    DatabaseManager.sharedManager.requestTutorial(tutorialID) { tutorial, message in

      XCTAssert(message == "Tutorial not found!")
      
      readyExpectation.fulfill()
    }
    
    // Loop until the expectation is fulfilled
    waitForExpectationsWithTimeout(5, handler: { error in
      XCTAssertNil(error, "Error")
    })
  }

  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measureBlock {
      // Put the code you want to measure the time of here.
    }
  }
  
  func testValidVideoTutorial() {
    let videoID = "Iumsqz6LMnM"
    let input = YouTubeManager.sharedManager.identifier + videoID
    let videoIDParsed = YouTubeManager.sharedManager.parseIdentifier(input)
    XCTAssertEqual(videoIDParsed, "Iumsqz6LMnM", "Parsing the identifier failed")
  }
  
}
