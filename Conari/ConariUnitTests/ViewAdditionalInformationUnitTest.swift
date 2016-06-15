//
//  ViewAdditionalInformationUnitTest.swift
//  TutorialCloud
//
//  Created on 11.05.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import XCTest

class ViewAdditionalInformationUnitTest: XCTestCase {
  
  var myTutorial: Tutorial? = nil
  
  override func setUp() {
    super.setUp()
    let tutorialID = 57
    
    let readyExpectation = expectationWithDescription("ready")
    
    DatabaseManager.sharedManager.requestTutorial(tutorialID) { tutorial, message in
      XCTAssertNotNil(tutorial, "no tutorial found")
      XCTAssertNil(message, "message should be nil")
      
      readyExpectation.fulfill()
      self.myTutorial = tutorial
    }
    
    waitForExpectationsWithTimeout(5, handler: { error in
      XCTAssertNil(error, "Error")
    })
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testAdditionalInformation() {
    XCTAssertEqual(myTutorial?.title, "ccc")
    XCTAssertEqual(myTutorial?.duration, "5")
  }
  
  func testPerformanceExample() {
    self.measureBlock {
    }
  }
  
}
