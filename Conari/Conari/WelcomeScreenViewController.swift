//
//  WelcomeScreenViewController.swift
//  Conari
//
//  Created by Markus Friedl on 13.04.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
  
  @IBOutlet weak var WelcomeLabel: UILabel!
  @IBOutlet weak var MrTutorLabel: UILabel!
  @IBOutlet weak var LoginBtn: UIButton!
  @IBOutlet weak var ContinueBtn: UIButton!
  @IBOutlet weak var AboutBtn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor(red: 0.25, green: 0.04, blue: 0.40, alpha: 1.00)
    
    self.WelcomeLabel.textColor = UIColor.whiteColor()
    self.MrTutorLabel.textColor = UIColor.whiteColor()
    
    self.LoginBtn.backgroundColor = UIColor.whiteColor()
    self.ContinueBtn.backgroundColor = UIColor.whiteColor()
    
    self.LoginBtn.tintColor = UIColor.blackColor()
    self.ContinueBtn.tintColor = UIColor.blackColor()
    self.AboutBtn.tintColor = UIColor.whiteColor()
    
    let cornerRadius : CGFloat = 15
    let borderWith : CGFloat = 1
    let borderColor = UIColor.whiteColor().CGColor

    self.LoginBtn.layer.cornerRadius = cornerRadius
    self.LoginBtn.layer.borderWidth = borderWith
    self.LoginBtn.layer.borderColor = borderColor
    
    self.ContinueBtn.layer.cornerRadius = cornerRadius
    self.ContinueBtn.layer.borderWidth = borderWith
    self.ContinueBtn.layer.borderColor = borderColor

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBarHidden = true
  }
  
}
