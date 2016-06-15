//
//  LoginUnitTests.swift
//  TutorialCloud
//
//  Created on 20.04.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import XCTest

class LoginUnitTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testLoginSuccessful() {
    let username = "anton"
    let password = "Test1234@"
    let readyExpectation = expectationWithDescription("ready")
    
    DatabaseManager.sharedManager.login(username, password: password) { success, message in
      XCTAssertTrue(success)
      XCTAssertNil(message, "message is nil")
      
      readyExpectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(5, handler: { error in
      XCTAssertNil(error, "Error")
    })
  }
  
  func testLoginFailed() {
    let username = "asfsadf"
    let password = "eafw"
    
    let readyExpectation = expectationWithDescription("ready")
    
    DatabaseManager.sharedManager.login(username, password: password) { success, message in
      XCTAssertFalse(success)
      XCTAssertNotNil(message, "message not nil")
      
      readyExpectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(5, handler: { error in
      XCTAssertNil(error, "Error")
    })
    
  }
}
