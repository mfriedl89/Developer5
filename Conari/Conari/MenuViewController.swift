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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Constants.viewBackgroundColor
    
    self.navigationItem.hidesBackButton = true
    
    userNameLabel.text = DatabaseManager.sharedManager.getUserName()
    
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(animated: Bool) {
    handleNetworkError()
    
    self.navigationController?.navigationBarHidden = false
  }
  
  override func viewWillDisappear(animated: Bool) {
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
