//
//  AboutUnitTests.swift
//  Conari
//
//  Created by Philipp Preiner on 08.06.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import XCTest
import UIKit

class AboutUnitTests: XCTestCase {
  
  var viewController: UIViewController!
  
  override func setUp() {
    super.setUp()
    
    let storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
    viewController = storyboard.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testExample() {
    viewController!.viewWillAppear(false)
    XCTAssertNil(viewController!.navigationController?.navigationBarHidden)
    //XCTAssertFalse(viewController!.navigationController!.navigationBarHidden)
  }
  
}