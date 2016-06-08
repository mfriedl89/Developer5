//
//  WelcomeScreenViewController.swift
//  Mr Tutor
//
//  Created on 13.04.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import UIKit

class WelcomeScreenViewController: UIViewController
{
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
  }
  
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }
  
  
  override func viewWillAppear(animated: Bool)
  {
    self.navigationController?.navigationBarHidden = true
  }
  
}
