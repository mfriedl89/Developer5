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
    
    Constants.setGradientColor(self.view)
    
    self.WelcomeLabel.textColor = UIColor.whiteColor()
    self.MrTutorLabel.textColor = UIColor.whiteColor()

    
    self.LoginBtn.backgroundColor = UIColor.whiteColor()
    self.ContinueBtn.backgroundColor = UIColor.whiteColor()

    self.LoginBtn.tintColor = UIColor.blackColor()
    self.ContinueBtn.tintColor = UIColor.blackColor()

    Constants.setRadiusWithColor(UIColor.whiteColor(), forButton: self.LoginBtn)
    
    Constants.setRadiusWithColor(UIColor.whiteColor(), forButton: self.ContinueBtn)
    
    self.AboutBtn.tintColor = UIColor.whiteColor()
    Constants.setRadiusWithColor(UIColor.whiteColor(), forButton: self.AboutBtn)
    
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "LaunchscreenBackground"), forBarMetrics: UIBarMetrics.Default)

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBarHidden = true
  }
  
}
