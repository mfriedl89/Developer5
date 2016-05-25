//
//  YoutubeManagerUnitTests.swift
//  Conari
//
//  Created by Stefan Mitterrutzner on 18/05/16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import XCTest

class YoutubeManagerUnitTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method isvarlled after the invocation of each test method in the class.
   super.tearDown()
  }
  
  func testsearchVideoByTitle() {
    let title = "test"
    
    // Declare our expectation
    let readyExpectation = expectationWithDescription("ready")
    
    YouTubeManager.sharedManager.searchVideoByTitle(title, completionHandler: {response,success,message in
      XCTAssertTrue(success)
      XCTAssertEqual(message, "")
      XCTAssertGreaterThan(response.count, 0)
      XCTAssertTrue(response.first?.title.lowercaseString.rangeOfString(title) != nil)
      readyExpectation.fulfill()
    })
    
    
    // Loop until the expectation is fulfilled
    waitForExpectationsWithTimeout(5, handler: { error in
      XCTAssertNil(error, "Error")
    })
    
  }
  
  func testsearchVideoByTitlewithSpecialCharacters() {
    let title = "test"
    let title2 = "ä"
    
    // Declare our expectation
    let readyExpectation = expectationWithDescription("ready")
    
    YouTubeManager.sharedManager.searchVideoByTitle(title+" "+title2, completionHandler: {response,success,message in
      XCTAssertTrue(success)
      XCTAssertEqual(message, "")
      XCTAssertGreaterThan(response.count, 0)
      XCTAssertTrue(response.first?.title.lowercaseString.rangeOfString(title) != nil)
      XCTAssertTrue(response.first?.title.lowercaseString.rangeOfString(title2) != nil)
      readyExpectation.fulfill()
    })
    
    
    // Loop until the expectation is fulfilled
    waitForExpectationsWithTimeout(5, handler: { error in
      XCTAssertNil(error, "Error")
    })
    
  }
  
  func testYoutubeSearchwithwrongurl() {
    let title = "test"
    
    // Declare our expectation
    let readyExpectation = expectationWithDescription("ready")
    YouTubeManager.sharedManager.searchApiUrl = "https://www.googleapis.com/youtube/v99/search"
    
    YouTubeManager.sharedManager.searchVideoByTitle(title, completionHandler: {response,success,message in
      XCTAssertFalse(success);
      XCTAssertNotEqual(message, "");
      readyExpectation.fulfill()
    })
    
    
    // Loop until the expectation is fulfilled
    waitForExpectationsWithTimeout(15, handler: { error in
      XCTAssertNil(error, "Error")
    })
    
  }
  
  func testYoutubeSearchwithwronghost() {
    let title = "test"
    
    // Declare our expectation
    let readyExpectation = expectationWithDescription("ready")
    YouTubeManager.sharedManager.searchApiUrl = "https://www.google.de"
    
    YouTubeManager.sharedManager.searchVideoByTitle(title, completionHandler: {response,success,message in
      XCTAssertFalse(success);
      XCTAssertNotEqual(message, "");
      readyExpectation.fulfill()
    })
    
    
    // Loop until the expectation is fulfilled
    waitForExpectationsWithTimeout(15, handler: { error in
      XCTAssertNil(error, "Error")
    })
    
  }
  
  
  
  func testYoutubeSearchwithwrongapikey() {
    let title = "test"
    
    // Declare our expectation
    let readyExpectation = expectationWithDescription("ready")
    YouTubeManager.sharedManager.apiKey = "123"
    
    YouTubeManager.sharedManager.searchVideoByTitle(title, completionHandler: {response,success,message in
      XCTAssertFalse(success);
      XCTAssertNotEqual(message, "");
      readyExpectation.fulfill()
    })
    
    
    // Loop until the expectation is fulfilled
    waitForExpectationsWithTimeout(15, handler: { error in
      XCTAssertNil(error, "Error")
    })
    
  }
  
  func testYoutubeSearchwithInvalidurl() {
    let title = "test"
    
    // Declare our expectation
    let readyExpectation = expectationWithDescription("ready")
    YouTubeManager.sharedManager.searchApiUrl = "1"
    
    YouTubeManager.sharedManager.searchVideoByTitle(title, completionHandler: {response,success,message in
      XCTAssertFalse(success);
      XCTAssertNotEqual(message, "");
      readyExpectation.fulfill()
    })
    
    
    // Loop until the expectation is fulfilled
    waitForExpectationsWithTimeout(15, handler: { error in
      XCTAssertNil(error, "Error")
    })
    
  }
  
  
  
}
