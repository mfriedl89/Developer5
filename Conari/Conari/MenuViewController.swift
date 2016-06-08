//
//  MenuViewController.swift
//  Conari
//
//  Created by Paul Krassnig on 04.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
  
  @IBOutlet weak var userNameLabel: UILabel!
  
  @IBOutlet weak var SearchTutBtn: UIButton!
  @IBOutlet weak var CreateTutBtn: UIButton!
  @IBOutlet weak var CreateVidTut: UIButton!
  @IBOutlet weak var ManageTut: UIButton!
  
  @IBOutlet weak var ChangeNameBtn: UIButton!
  @IBOutlet weak var ChangeEmailBtn: UIButton!
  @IBOutlet weak var ChangePasswordBtn: UIButton!
  @IBOutlet weak var LogoutBtn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Constants.viewBackgroundColor
    
    self.navigationItem.hidesBackButton = true
    
    userNameLabel.text = DatabaseManager.sharedManager.getUserName()
    
    // Do any additional setup after loading the view.
    
    Constants.setGradientColor(self.view)
    
    Constants.setRadiusWithColor(UIColor.whiteColor(), forButton: SearchTutBtn)
    Constants.setRadiusWithColor(UIColor.whiteColor(), forButton: CreateTutBtn)
    Constants.setRadiusWithColor(UIColor.whiteColor(), forButton: CreateVidTut)
    Constants.setRadiusWithColor(UIColor.whiteColor(), forButton: ManageTut)

    
    self.userNameLabel.tintColor = UIColor.whiteColor()
    self.SearchTutBtn.tintColor = UIColor.whiteColor()
    self.CreateTutBtn.tintColor = UIColor.whiteColor()
    self.CreateVidTut.tintColor = UIColor.whiteColor()
    self.ManageTut.tintColor = UIColor.whiteColor()
    self.ChangeNameBtn.tintColor = UIColor.whiteColor()
    self.ChangeEmailBtn.tintColor = UIColor.whiteColor()
    self.ChangePasswordBtn.tintColor = UIColor.whiteColor()
    self.LogoutBtn.tintColor = UIColor.whiteColor()

  }
  
  override func viewWillAppear(animated: Bool) {
    handleNetworkError()
    
    self.navigationController?.navigationBarHidden = true
  }
    
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func LogoutKlicked(sender: UIButton) {
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "text_tutorial") {
      let destinationVC = segue.destinationViewController as! MetaDataViewController
      destinationVC.TextOrVideo = 0
    }
    
    if (segue.identifier == "video_tutorial") {
      let destinationVC = segue.destinationViewController as! MetaDataViewController
      destinationVC.TextOrVideo = 1
    }
  }
}
