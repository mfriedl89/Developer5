//
//  LoginUnitTests.swift
//  LoginUnitTests
//
//  Created by Markus Friedl on 20.04.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import XCTest
@testable import Conari

class LoginUnitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
      func testLoginSuccessful() {
        let username = "anton"
        let password = "Test1234@"
        
        // Declare our expectation
        let readyExpectation = expectationWithDescription("ready")
        
        DatabaseManager.sharedManager.loginWithPHPScript(username, password: password) { success, message in
            XCTAssertTrue(success)
            XCTAssertNil(message, "message is nil")
            
            readyExpectation.fulfill()
        }

        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testLoginFailed() {
        let username = "asfsadf"
        let password = "eafw"
        
        // Declare our expectation
        let readyExpectation = expectationWithDescription("ready")
        
        DatabaseManager.sharedManager.loginWithPHPScript(username, password: password) { success, message in
            XCTAssertFalse(success)
            XCTAssertNotNil(message, "message not nil")
            
            readyExpectation.fulfill()
        }
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
        
    }
}
