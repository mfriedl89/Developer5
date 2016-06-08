//
//  ChangeEmailViewController.swift
//  Conari
//
//  Created by Paul Krassnig on 11.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class ChangeEmailViewController: UIViewController, UITextFieldDelegate {
  
  // MARK: - Members
  
  let checkEmailFalse = -1
  let repeatedEmailIsNotNew = -2
  
  var login_email_ = ""
  var newUserFunc = NewUserViewController()
  
  let username = DatabaseManager.sharedManager.getUserName()
  let password = DatabaseManager.sharedManager.getUserPassword()
  
  // MARK: - Outlets
  
  @IBOutlet weak var old_email: UILabel!
  @IBOutlet weak var new_email_textField: UITextField!
  @IBOutlet weak var repeat_new_email_textField: UITextField!
  @IBOutlet weak var Done_btn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    new_email_textField.delegate = self
    repeat_new_email_textField.delegate = self
    
    DatabaseManager.sharedManager.requestUser(username) {User, message in
      
      if (User == nil) {
        if message != nil {
          self.showErrorMessage(message!)
          
          dispatch_async(dispatch_get_main_queue(), {
            self.title = "Error"
            //self.loadIndicator.stopAnimating()
            //self.loadingLabel.hidden = true
          })
          
        }
      }
      else {
        dispatch_async(dispatch_get_main_queue(), {
          self.login_email_ = User!.email
          self.old_email.text = self.login_email_
        })
      }
      
    };
    
    
  }
  
  override func viewWillAppear(animated: Bool) {
    handleNetworkError()
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
      
      // Support display in iPad
      alert.popoverPresentationController?.sourceView = self.view
      alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
      
      self.presentViewController(alert, animated: true, completion: nil)
      
    case repeatedEmailIsNotNew:
      let alert = UIAlertController(title: "Alert", message: "Repeated Email is not the same as New Email", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      
      // Support display in iPad
      alert.popoverPresentationController?.sourceView = self.view
      alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
      
      self.presentViewController(alert, animated: true, completion: nil)
      
    case 0:
      DatabaseManager.sharedManager.changeUserEmail(username, password: password, new_email: new_email) {success, message in
        if success == true
        {
          dispatch_async(dispatch_get_main_queue(),{
            let alert = UIAlertController(title: "Changed Email to: \(new_email)", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            // Support display in iPad
            alert.popoverPresentationController?.sourceView = self.view
            alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
          });
        }
        else
        {
          dispatch_async(dispatch_get_main_queue(),{
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            
            // Support display in iPad
            alert.popoverPresentationController?.sourceView = self.view
            alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
          });
        }
      }
      
    default:
      break
    }
    
    
    return true
  }
  
  @IBAction func Done_button_clicked(sender: AnyObject) {
    test(new_email_textField.text!, repeat_new_email: repeat_new_email_textField.text!)
  }
  
}
