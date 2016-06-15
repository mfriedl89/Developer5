//
//  ViewFinishedTutorial.swift
//  TutorialCloud
//
//  Created on 27.04.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import XCTest

class ViewFinishedTutorial: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testRequestExistingTutorial() {
    let tutorialID = 57
    
    let readyExpectation = expectationWithDescription("ready")
    
    DatabaseManager.sharedManager.requestTutorial(tutorialID) { tutorial, message in
      XCTAssertNotNil(tutorial, "no tutorial found")
      XCTAssertNil(message, "message should be nil")
      
      readyExpectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(10, handler: { error in
      XCTAssertNil(error, "Error")
    })
  }
  
  
  func testRequestMissingTutorial() {
    let tutorialID = 2
    
    let readyExpectation = expectationWithDescription("ready")
    
    DatabaseManager.sharedManager.requestTutorial(tutorialID) { tutorial, message in

      XCTAssert(message == "Tutorial not found!")
      
      readyExpectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(5, handler: { error in
      XCTAssertNil(error, "Error")
    })
  }

  func testPerformanceExample() {
    self.measureBlock {
    }
  }
  
  func testValidVideoTutorial() {
    let videoID = "Iumsqz6LMnM"
    let input = YouTubeManager.sharedManager.identifier + videoID
    let videoIDParsed = YouTubeManager.sharedManager.parseIdentifier(input)
    XCTAssertEqual(videoIDParsed, "Iumsqz6LMnM", "Parsing the identifier failed")
  }
  
}
