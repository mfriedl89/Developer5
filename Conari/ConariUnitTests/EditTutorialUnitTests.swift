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
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testEditTutorial_fail_no_login() {
    let tutorial = TutorialMetaData(id: 0, OldTitle: "", Title: "", category: 1, duration: 1, difficulty: 1)
    
    DatabaseManager.sharedManager.editTutorial(tutorial, content: "TEST", callback: { success, message in
      XCTAssertFalse(success)
    })
  }
  
}
