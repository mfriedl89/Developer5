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
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // get tutorial data for tutorial id
    let tutorialID = 57
    
    // Declare our expectation
    let readyExpectation = expectationWithDescription("ready")
    
    DatabaseManager.sharedManager.requestTutorial(tutorialID) { tutorial, message in
      XCTAssertNotNil(tutorial, "no tutorial found")
      XCTAssertNil(message, "message should be nil")
      
      readyExpectation.fulfill()
      self.myTutorial = tutorial
    }
    
    // Loop until the expectation is fulfilled
    waitForExpectationsWithTimeout(5, handler: { error in
      XCTAssertNil(error, "Error")
    })
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testAdditionalInformation() {
    XCTAssertEqual(myTutorial?.title, "ccc")
//    XCTAssertEqual(myTutorial?.author, "anton")
//    XCTAssertEqual(categories[(myTutorial?.category)!], "Cars & Other Vehicles")
//    XCTAssertEqual(difficulty[(myTutorial?.difficulty)!], "easy")
    XCTAssertEqual(myTutorial?.duration, "5")
  }
  
  /*
   func testSegueForAdditionalInformation() {
   // set up view controllers
   let viewControllerFinishedTutorial: ViewFinishedTutorialViewController!
   let viewControllerAdditionalInformation: ViewAdditionalInformationTableViewController!
   
   
   viewControllerAdditionalInformation = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType)).instantiateViewControllerWithIdentifier("ViewAdditionalInformationTableViewController") as! ViewAdditionalInformationTableViewController
   
   viewControllerFinishedTutorial = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType)).instantiateViewControllerWithIdentifier("ViewFinishedTutorialViewController") as! ViewFinishedTutorialViewController
   
   
   
   // set up tutorial data
   //viewControllerFinishedTutorial.requestTutorial(viewControllerFinishedTutorial.TutorialID)
   viewControllerFinishedTutorial.myTutorial = myTutorial
   
   // perform segue
   //viewControllerFinishedTutorial.requestTutorial(57)
   viewControllerFinishedTutorial.myTutorial = myTutorial
   viewControllerFinishedTutorial.performSegueWithIdentifier("viewAdditionalInformationSegue", sender: self)
   
   // check tutorial data after segue
   let tutorialAfterSegue = viewControllerAdditionalInformation.tutorial
   
   XCTAssertEqual(tutorialAfterSegue?.title, myTutorial?.title)
   XCTAssertEqual(tutorialAfterSegue?.category, myTutorial?.category)
   XCTAssertEqual(tutorialAfterSegue?.difficulty, myTutorial?.difficulty)
   XCTAssertEqual(tutorialAfterSegue?.duration, myTutorial?.duration)
   XCTAssertEqual(tutorialAfterSegue?.author, myTutorial?.author)
   }*/
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measureBlock {
      // Put the code you want to measure the time of here.
    }
  }
  
}
