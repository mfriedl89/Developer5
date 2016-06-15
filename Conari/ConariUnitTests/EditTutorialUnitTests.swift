//
//  EditTutorialUnitTests.swift
//  TutorialCloud
//
//  Created on 25.05.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import XCTest

class EditTutorialUnitTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testEditTutorial_fail_no_login() {
    let tutorial = TutorialMetaData(id: 0, OldTitle: "", Title: "", category: 1, duration: 1, difficulty: 1)
    
    DatabaseManager.sharedManager.editTutorial(tutorial, content: "TEST", callback: { success, message in
      XCTAssertFalse(success)
    })
  }
  
}
