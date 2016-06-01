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
    
    self.navigationItem.hidesBackButton = true
    
    userNameLabel.text = DatabaseManager.sharedManager.getUserName()
    
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(animated: Bool) {
    handleNetworkError()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func LogoutKlicked(sender: UIButton) {
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
