//
//  DatabaseManagerUnitTests.swift
//  Conari
//
//  Created by Stefan Mitterrutzner on 11/05/16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import XCTest

class DatabaseManagerUnitTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
    
  
  func testTutorial_item_class()
  {
    let id = 1234567
    let title = "title"
    let category = 1
    let difficulty = "easy"
    let duration = "00:00"
    let author = "homer"
    let item = TutorialItem(tutID: id, tutTitle: title, tutCategory: category, tutDifficulty: difficulty, tutDuration: duration, tutAuthor: author);
    XCTAssertEqual(item.id, id);
    XCTAssertEqual(item.title, title);
    XCTAssertEqual(item.category, category);
    XCTAssertEqual(item.difficulty, difficulty);
    XCTAssertEqual(item.duration, duration);
    XCTAssertEqual(item.author, author);
    
  }
  
  
  func testloginWithPHPScript_suc() {
    let username = "anton"
    let password = "Test1234@"
    
    // Declare our expectation
    let readyExpectation = expectationWithDescription("ready")
    
    DatabaseManager.sharedManager.login(username, password: password) { success, message in
      XCTAssertTrue(success)
      XCTAssertNil(message, "message is nil")
      
      readyExpectation.fulfill()
    }
    
    // Loop until the expectation is fulfilled
    waitForExpectationsWithTimeout(5, handler: { error in
      XCTAssertNil(error, "Error")
    })
  }
  
  func testloginWithPHPScript_fail() {
    let username = "test"
    let password = "1."
    
    // Declare our expectation
    let readyExpectation = expectationWithDescription("ready")
    
    DatabaseManager.sharedManager.login(username, password: password) { success, message in
      
      XCTAssertFalse(success)
      
      readyExpectation.fulfill()
    }
    
    // Loop until the expectation is fulfilled
    waitForExpectationsWithTimeout(5, handler: { error in
      XCTAssertNil(error, "Error")
    })
  }
  
  
  
  
  
  func testloginWithPHPScript_invalidurl() {
    let username = "anton"
    let password = "Test1234@"
    
    // Declare our expectation
    let readyExpectation = expectationWithDescription("ready")
    let original = DatabaseManager.sharedManager.baseUrl
    DatabaseManager.sharedManager.baseUrl = "http://www.google.de"
    DatabaseManager.sharedManager.login(username, password: password) { success, message in
      
      XCTAssertFalse(success)
      
      readyExpectation.fulfill()
    }
    DatabaseManager.sharedManager.baseUrl = original
    // Loop until the expectation is fulfilled
    waitForExpectationsWithTimeout(5, handler: { error in
      XCTAssertNil(error, "Error")
    })
    
  }
  
  func testloginWithPHPScript_invalidurl1() {
    let username = "anton"
    let password = "Test1234@"
    
    // Declare our expectation
    let readyExpectation = expectationWithDescription("ready")
    let original = DatabaseManager.sharedManager.baseUrl
    
    DatabaseManager.sharedManager.baseUrl = DatabaseManager.sharedManager.baseUrl+"/folder/"
    DatabaseManager.sharedManager.login(username, password: password) { success, message in
      
      XCTAssertFalse(success)
      
      readyExpectation.fulfill()
    }
    DatabaseManager.sharedManager.baseUrl = original
    // Loop until the expectation is fulfilled
    waitForExpectationsWithTimeout(5, handler: { error in
      XCTAssertNil(error, "Error")
    })
    
  }
  
  
    
  
  
  func testCreateUser() {

  }
  
  func testrequestTutorial(){
    
  }
  
  func testfindTutorialByCategory() {
    
  }
  
}
