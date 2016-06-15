//
//  YoutubeManagerUnitTests.swift
//  TutorialCloud
//
//  Created on 18.05.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import XCTest

class YoutubeManagerUnitTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
   super.tearDown()
  }
  
  func testsearchVideoByTitle() {
    let title = "test"
    
    let readyExpectation = expectationWithDescription("ready")
    
    YouTubeManager.sharedManager.searchVideoByTitle(title, completionHandler: {response,success,message in
      XCTAssertTrue(success)
      XCTAssertEqual(message, "")
      XCTAssertGreaterThan(response.count, 0)
      XCTAssertTrue(response.first?.title.lowercaseString.rangeOfString(title) != nil)
      readyExpectation.fulfill()
    })
    
    waitForExpectationsWithTimeout(5, handler: { error in
      XCTAssertNil(error, "Error")
    })
    
  }
  
  func testsearchVideoByTitlewithSpecialCharacters() {
    let title = "test"
    let title2 = "ä"
    
    let readyExpectation = expectationWithDescription("ready")
    
    YouTubeManager.sharedManager.searchVideoByTitle(title+" "+title2, completionHandler: {response,success,message in
      XCTAssertTrue(success)
      XCTAssertEqual(message, "")
      XCTAssertGreaterThan(response.count, 0)
      XCTAssertTrue(response.first?.title.lowercaseString.rangeOfString(title) != nil)
      XCTAssertTrue(response.first?.title.lowercaseString.rangeOfString(title2) != nil)
      readyExpectation.fulfill()
    })
    
    waitForExpectationsWithTimeout(5, handler: { error in
      XCTAssertNil(error, "Error")
    })
    
  }
  
  func testYoutubeSearchwithwrongurl() {
    let title = "test"
    
    let readyExpectation = expectationWithDescription("ready")
    YouTubeManager.sharedManager.searchApiUrl = "https://www.googleapis.com/youtube/v99/search"
    
    YouTubeManager.sharedManager.searchVideoByTitle(title, completionHandler: {response,success,message in
      XCTAssertFalse(success);
      XCTAssertNotEqual(message, "");
      readyExpectation.fulfill()
    })
    
    waitForExpectationsWithTimeout(15, handler: { error in
      XCTAssertNil(error, "Error")
    })
    
  }
  
  func testYoutubeSearchwithwronghost() {
    let title = "test"
    
    let readyExpectation = expectationWithDescription("ready")
    YouTubeManager.sharedManager.searchApiUrl = "https://www.google.de"
    
    YouTubeManager.sharedManager.searchVideoByTitle(title, completionHandler: {response,success,message in
      XCTAssertFalse(success);
      XCTAssertNotEqual(message, "");
      readyExpectation.fulfill()
    })
    
    waitForExpectationsWithTimeout(15, handler: { error in
      XCTAssertNil(error, "Error")
    })
    
  }
  
  
  
  func testYoutubeSearchwithwrongapikey() {
    let title = "test"
    
    let readyExpectation = expectationWithDescription("ready")
    YouTubeManager.sharedManager.apiKey = "123"
    
    YouTubeManager.sharedManager.searchVideoByTitle(title, completionHandler: {response,success,message in
      XCTAssertFalse(success);
      XCTAssertNotEqual(message, "");
      readyExpectation.fulfill()
    })
    
    waitForExpectationsWithTimeout(15, handler: { error in
      XCTAssertNil(error, "Error")
    })
    
  }
  
  func testYoutubeSearchwithInvalidurl() {
    let title = "test"
    
    let readyExpectation = expectationWithDescription("ready")
    YouTubeManager.sharedManager.searchApiUrl = "1"
    
    YouTubeManager.sharedManager.searchVideoByTitle(title, completionHandler: {response,success,message in
      XCTAssertFalse(success);
      XCTAssertNotEqual(message, "");
      readyExpectation.fulfill()
    })
    
    waitForExpectationsWithTimeout(15, handler: { error in
      XCTAssertNil(error, "Error")
    })
    
  }
  
  
  
}
