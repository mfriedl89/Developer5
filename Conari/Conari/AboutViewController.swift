//
//  AboutViewController.swift
//  Tutorialcloud
//
//  Created on 25.05.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Constants.viewBackgroundColor
  }
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBarHidden = false
  }
}
