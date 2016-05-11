//
//  ViewAdditionalInformationUnitTest.swift
//  Conari
//
//  Created by Philipp Preiner on 11.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import XCTest
@testable import Conari

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
        XCTAssertEqual(categories[(myTutorial?.category)!], "Cars & Other Vehicles")
        XCTAssertEqual(difficulty[(myTutorial?.difficulty)!], "easy")
        XCTAssertEqual(myTutorial?.duration, "5")
        
        //add author
    }
    
    func testSegueForAdditionalInformation() {
        // set up view controllers
        let viewControllerFinishedTutorial: ViewFinishedTutorialViewController!
        let viewControllerAdditionalInformation: ViewAdditionalInformationTableViewController!
        
        viewControllerFinishedTutorial = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ViewFinishedTutorialViewController") as! ViewFinishedTutorialViewController
        
        viewControllerAdditionalInformation = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ViewAdditionalInformationTableViewController") as! ViewAdditionalInformationTableViewController
        
        // set up tutorial data
        //viewControllerFinishedTutorial.requestTutorial(viewControllerFinishedTutorial.TutorialID)
        viewControllerFinishedTutorial.myTutorial = myTutorial
        
        // perform segue
        viewControllerFinishedTutorial.performSegueWithIdentifier("viewAdditionalInformationSegue", sender: self)
        
        // check tutorial data after segue
        let tutorialAfterSegue = viewControllerAdditionalInformation.tutorial
        
        XCTAssertEqual(tutorialAfterSegue?.title, myTutorial?.title)
        XCTAssertEqual(tutorialAfterSegue?.category, myTutorial?.category)
        XCTAssertEqual(tutorialAfterSegue?.difficulty, myTutorial?.difficulty)
        XCTAssertEqual(tutorialAfterSegue?.duration, myTutorial?.duration)
        
        //add author
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
