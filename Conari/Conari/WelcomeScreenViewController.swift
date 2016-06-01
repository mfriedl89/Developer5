//
//  WelcomeScreenViewController.swift
//  Conari
//
//  Created by Markus Friedl on 13.04.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Constants.viewBackgroundColor
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBarHidden = true
  }
  
}
