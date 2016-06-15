//
//  CategorySearchUITests.swift
//  Tutorialcloud
//
//  Created by Benjamin Wullschleger on 11.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import XCTest

class CategorySearchUITests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    
    continueAfterFailure = false
    XCUIApplication().launch()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  
  func testAllCategories() {
    sleep(1);
    XCUIApplication().buttons["Continue without login"].tap()
    sleep(1);
    let tablesQuery = XCUIApplication().tables
    XCTAssertTrue(tablesQuery.staticTexts["Arts and Entertainment"].exists, "Arts and Entertainment missing")
    XCTAssertTrue(tablesQuery.staticTexts["Cars & Other Vehicles"].exists, "Cars & Other Vehicles missing")
    XCTAssertTrue(tablesQuery.staticTexts["Computers and Electronics"].exists, "Computers and Electronics missing")
    XCTAssertTrue(tablesQuery.staticTexts["Education and Communications"].exists, "Education and Communications missing")
    
    XCTAssertTrue(tablesQuery.staticTexts["Conari"].exists, "Conari missing")
    XCTAssertTrue(tablesQuery.staticTexts["Finance and Business"].exists, "Finance and Business missing")
    XCTAssertTrue(tablesQuery.staticTexts["Food and Entertaining"].exists, "Food and Entertaining missing")
    XCTAssertTrue(tablesQuery.staticTexts["Health"].exists, "Health missing")
    XCTAssertTrue(tablesQuery.staticTexts["Hobbies and Crafts"].exists, "Hobbies and Crafts missing")
    XCTAssertTrue(tablesQuery.staticTexts["Holidays and Traditions"].exists, "Holidays and Traditions missing")
    XCTAssertTrue(tablesQuery.staticTexts["Home and Garden"].exists, "Home and Garden missing")
    XCTAssertTrue(tablesQuery.staticTexts["Personal Care and Style"].exists, "Personal Care and Style missing")
    XCTAssertTrue(tablesQuery.staticTexts["Pets and Animals"].exists, "Pets and Animals missing")
    XCTAssertTrue(tablesQuery.staticTexts["Philosophy and Religion"].exists, "Philosophy and Religion missing")
    XCTAssertTrue(tablesQuery.staticTexts["Relationships"].exists, "Relationships missing")
    XCTAssertTrue(tablesQuery.staticTexts["Sports and Fitness"].exists, "Sports and Fitness missing")
    XCTAssertTrue(tablesQuery.staticTexts["Travel"].exists, "Travel missing")
    XCTAssertTrue(tablesQuery.staticTexts["Work World"].exists, "Work World missing")
    XCTAssertTrue(tablesQuery.staticTexts["Youth"].exists, "Youth missing")
 
    
    
  }
  
func testTableCell() {
   
  sleep(1);
  XCUIApplication().buttons["Continue without login"].tap()
  sleep(1);
  
  let tablesQuery = XCUIApplication().tables
  tablesQuery.staticTexts["Arts and Entertainment"].tap()
    
  sleep(1);
    
    XCTAssertTrue(XCUIApplication().tables.childrenMatchingType(.Cell).elementBoundByIndex(0).childrenMatchingType(.StaticText).elementBoundByIndex(0).exists)
    XCTAssertTrue(XCUIApplication().tables.childrenMatchingType(.Cell).elementBoundByIndex(0).childrenMatchingType(.StaticText).elementBoundByIndex(1).exists)
    XCTAssertTrue(XCUIApplication().tables.childrenMatchingType(.Cell).elementBoundByIndex(0).childrenMatchingType(.StaticText).elementBoundByIndex(2).exists)
    XCTAssertTrue(XCUIApplication().tables.childrenMatchingType(.Cell).elementBoundByIndex(0).childrenMatchingType(.StaticText).elementBoundByIndex(3).exists)
    

    
    
    //let tableCell = CategorySearchTableViewCell()
    
    //tableCell.
    
    //XCTAssert(app.staticTexts["Test"].exists)
    //XCTAssert(app.staticTexts["Arts and Entertainment"].exists)
    //XCTAssert(app.staticTexts["easy"].exists)
    //XCTAssert(app.staticTexts["00:05"].exists)
  }
  
}
