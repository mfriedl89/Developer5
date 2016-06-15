//
//  ChangePasswordViewController.swift
//  Mr Tutor
//
//  Created on 15.06.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import XCTest

class MetaDataUnitTests: XCTestCase {
  
  var vc: MetaDataViewController!
  
  override func setUp() {
    super.setUp()
    let storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
    vc = storyboard.instantiateViewControllerWithIdentifier("metaDataStoryboard") as! MetaDataViewController
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  
  
  func testTextOrVideo0()
  {
    vc.TextOrVideo = 0;
    vc.viewDidLoad();
    XCTAssert(vc.VideoThumbnail.hidden == true)
    XCTAssert(vc.SelectVideoButton.hidden == true)
    XCTAssert(vc.TutorialTitle.title == "Text Tutorial")
  }
  
  func testTextOrVideo1()
  {
    vc.TextOrVideo = 1;
    vc.viewDidLoad();
    XCTAssert(vc.VideoThumbnail.hidden == false)
    XCTAssert(vc.SelectVideoButton.hidden == false)
    XCTAssert(vc.TutorialTitle.title == "Video Tutorial")
    XCTAssert(vc.NextButton.title == "Upload")
  }
  
  func testNumberOfComponentsInPickerView()
  {
    var counter: Int
    vc.viewDidLoad();
    counter = vc.numberOfComponentsInPickerView(vc.categoryPickerView)
    XCTAssert(counter == 1)
  }
  
  func testCategoryPickerView()
  {
    var counter: Int
    vc.viewDidLoad();
    counter = vc.pickerView(vc.categoryPickerView, numberOfRowsInComponent: 1)
    XCTAssert(counter >= 19)
  }
  
  func testTimePickerView()
  {
    var counter: Int
    vc.viewDidLoad();
    vc.times.removeAll()
    counter = vc.pickerView(vc.timePickerView, numberOfRowsInComponent: 1)
    print(counter)
    XCTAssert(counter%132 == 0)
  }
  
  func testUpdateCurrentStruct()
  {
    vc.viewDidLoad();
    vc.titleTextField_.text = "Test Tutorial"
    vc.DifficultyStepper_.value = 4
    vc.updateCurrentStruct()
    XCTAssert(vc.current.Title == "Test Tutorial")
    XCTAssert(vc.current.difficulty == 4)
  }
  
  func testStringCategoryPickerView()
  {
    var category: String
    vc.viewDidLoad();
    category = vc.pickerView(vc.categoryPickerView, titleForRow: 0, forComponent: 1)!
    XCTAssert(category == "Arts and Entertainment")
  }
  
  func testStringTimePickerView()
  {
    var category: String
    vc.viewDidLoad();
    category = vc.pickerView(vc.timePickerView, titleForRow: 0, forComponent: 1)!
    XCTAssert(category == "00:00")
  }
  
  func testDifficultyValueChanged()
  {
    vc.viewDidLoad();
    vc.DifficultyStepper_.value = 3
    vc.DifficultyValueChanged_(0)
    
    XCTAssert(vc.difficultyLabel_.text == "medium")
  }
  
  func testVariousCategoryPickerView()
  {
    vc.viewDidLoad();
    vc.pickerView(vc.categoryPickerView, didSelectRow: 0, inComponent: 1)
    
    XCTAssert(vc.categoryTextField_.text == "Arts and Entertainment")
    XCTAssert(vc.current.category == 0)
    XCTAssert(vc.categoryTextField_.selectedTextRange == nil)
  }
  
  func testVariousTimePickerView()
  {
    vc.viewDidLoad();
    vc.pickerView(vc.categoryPickerView, didSelectRow: 1, inComponent: 1)
    
    XCTAssert(vc.DurationTextField_.text == "00:05 hh:mm")
    XCTAssert(vc.current.duration == 5)
    XCTAssert(vc.categoryTextField_.selectedTextRange == nil)
  }
  
  


}
  