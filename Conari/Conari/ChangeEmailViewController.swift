//
//  ChangeEmailViewController.swift
//  Conari
//
//  Created by Paul Krassnig on 11.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class ChangeEmailViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var old_email: UILabel!
  @IBOutlet weak var new_email_textField: UITextField!
  @IBOutlet weak var repeat_new_email_textField: UITextField!
  @IBOutlet weak var Done_btn: UIButton!


  let checkEmailFalse = -1
  let repeatedEmailIsNotNew = -2
  
//  var login_password_ = DatabaseManager.sharedManager.getUserPassword()
  var login_email_ = "irgendwos"
  var newUserFunc = NewUserViewController()
  

  
    override func viewDidLoad() {
        super.viewDidLoad()

        new_email_textField.delegate = self
        repeat_new_email_textField.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField == new_email_textField) {
            repeat_new_email_textField.becomeFirstResponder()
        }
        else {
            repeat_new_email_textField.resignFirstResponder()
            Done_button_clicked(Done_btn)
        }
        return true
    }
    
  
  func test (new_email:String, repeat_new_email:String) -> Bool {
 
    var error = 0
    
    if(!newUserFunc.checkEmailAddress(new_email)) {
      error = checkEmailFalse
    }
    else if(repeat_new_email != new_email) {
      error = repeatedEmailIsNotNew
    }
    
    
    newUserFunc.checkInput(newUserFunc.checkEmailAddress(new_email), textField: new_email_textField)
    newUserFunc.checkInput(repeat_new_email == new_email, textField: repeat_new_email_textField)
    
    switch error {
    case checkEmailFalse:
      let alert = UIAlertController(title: "Alert", message: "Please enter a valid Email address", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      break
    case repeatedEmailIsNotNew:
      let alert = UIAlertController(title: "Alert", message: "Repeated Email is not the same as New Email", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      break
    case 0:
      break
    default: break
    }
    
    
    return true
  }
  
  
  
  
  @IBAction func Done_button_clicked(sender: AnyObject) {
    test(new_email_textField.text!, repeat_new_email: repeat_new_email_textField.text!)

  }


}
