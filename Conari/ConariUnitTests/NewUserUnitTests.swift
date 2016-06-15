//
//  NewUserUnitTests.swift
//  TutorialCloud
//
//  Created on 13.04.14.
//  Copyright © 2016 Developer5. All rights reserved.
//

import XCTest

class NewUserUnitTests: XCTestCase {
  var vc: NewUserViewController!
  
  override func setUp() {
    super.setUp()
    
    let storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
    vc = storyboard.instantiateViewControllerWithIdentifier("newUserStoryboard") as! NewUserViewController
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testUsernamePass() {
    let test_result = vc.checkingUsername("hans")
    XCTAssert(test_result == true)
  }
  
  func testUsernameFail() {
    let test_result = vc.checkingUsername("")
    XCTAssert(test_result == false)
  }
  
  func testNameAndSurenamePass() {
    let test_result = vc.checkingNameAndSurname("fefe")
    XCTAssert(test_result == true)
  }
  
  func testNameAndSurenameFail() {
    let test_result = vc.checkingNameAndSurname("")
    XCTAssert(test_result == false)
  }
  
  func testEmailPass() {
    let test_result = vc.checkEmailAddress("hans@gmail.com")
    XCTAssert(test_result == true)
  }
  
  func testEmailFail() {
    let test_result = vc.checkEmailAddress("hans.com")
    XCTAssert(test_result == false)
  }
  
  func testPasswordPass() {
    let test_result = vc.checkPassword("jrsA1&Ettww%")
    XCTAssert(test_result == true)
  }
  
  func testPasswordFail() {
    let test_result = vc.checkPassword("eegaaasrE")
    XCTAssert(test_result == false)
  }
  
  func testRepeatedPasswordPass() {
    let test_result = vc.checkRepeatedPassword("jrsA1&Ettww%", repeated: "jrsA1&Ettww%")
    XCTAssert(test_result == true)
  }
  
  func testRepeatedPasswordFail() {
    let test_result = vc.checkRepeatedPassword("jrsA1&Ettww%", repeated: "jrsA1&Rttww%")
    XCTAssert(test_result == false)
  }
}
