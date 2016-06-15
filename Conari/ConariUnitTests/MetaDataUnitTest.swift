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

}
  