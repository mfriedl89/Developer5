//
//  EditTutorial.swift
//  Conari
//
//  Created by Markus Friedl on 25.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
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
