//
//  AboutViewController.swift
//  Conari
//
//  Created by Markus Friedl on 25.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
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
