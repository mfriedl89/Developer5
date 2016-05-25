//
//  ChangePasswordViewController.swift
//  Conari
//
//  Created by Paul Krassnig on 11.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var OldPasswordTextField: UITextField!
  @IBOutlet weak var NewPasswordTextField: UITextField!
  @IBOutlet weak var RepeatedPasswordTextField: UITextField!
  @IBOutlet weak var DoneBtn: UIButton!
  
  let falsePassword = -1
  let checkPasswordFalse = -2
  let repeatedIsNotNew = -3
  
  var login_password_ = DatabaseManager.sharedManager.getUserPassword()
  var username = DatabaseManager.sharedManager.getUserName()
  
  var newUserFunc = NewUserViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    OldPasswordTextField.delegate = self
    NewPasswordTextField.delegate = self
    RepeatedPasswordTextField.delegate = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if(textField == OldPasswordTextField) {
      NewPasswordTextField.becomeFirstResponder()
    }
    else if(textField == NewPasswordTextField) {
      RepeatedPasswordTextField.becomeFirstResponder()
    }
    else {
      RepeatedPasswordTextField.resignFirstResponder()
      DoneBtnClicked(DoneBtn)
    }
    return true
  }
  
  
  func changePassword(oldPwd: String, newPwd: String, repeatedPwd: String) -> NSInteger {
    var error = 0
    
    if(oldPwd != login_password_) {
      error = falsePassword
    }
    else if(!newUserFunc.checkPassword(newPwd)) {
      error = checkPasswordFalse
    }
    else if(repeatedPwd != newPwd) {
      error = repeatedIsNotNew
    }
    
    newUserFunc.checkInput(oldPwd == login_password_, textField: OldPasswordTextField)
    newUserFunc.checkInput(newUserFunc.checkPassword(newPwd), textField: NewPasswordTextField)
    newUserFunc.checkInput(repeatedPwd == newPwd, textField: RepeatedPasswordTextField)
    
    switch error {
    case falsePassword:
      let alert = UIAlertController(title: "Alert", message: "False Password", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      
    case repeatedIsNotNew:
      let alert = UIAlertController(title: "Alert", message: "Repeated Password is not the same as New Password", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)

    case checkPasswordFalse:
      let alert = UIAlertController(title: "Alert", message: "Please enter a valid Password", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      
    case 0:
      DatabaseManager.sharedManager.changeUserPassword(username, new_password: NewPasswordTextField.text!, old_password: login_password_) {success, message in
        if success == true {
          dispatch_async(dispatch_get_main_queue(),{
            let alert = UIAlertController(title: "Changed Password", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
          });
        }
        else {
          dispatch_async(dispatch_get_main_queue(),{
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
          });
        }
      }
      break
    default:
      break
    }
    
    return error
  }
  
  @IBAction func DoneBtnClicked(sender: AnyObject) {
    changePassword(OldPasswordTextField.text!, newPwd: NewPasswordTextField.text!, repeatedPwd: RepeatedPasswordTextField.text!)
  }
}
