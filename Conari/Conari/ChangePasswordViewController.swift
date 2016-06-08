//
//  ChangePasswordViewController.swift
//  Mr Tutor
//
//  Created on 11.05.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController, UITextFieldDelegate {
  
  // MARK: - Members
  
  let falsePassword = -1
  let checkPasswordFalse = -2
  let repeatedIsNotNew = -3
  
  var loginPassword = DatabaseManager.sharedManager.getUserPassword()
  var username = DatabaseManager.sharedManager.getUserName()
  
  var newUserFunc = NewUserViewController()
  
  // MARK: - Outlets
  
  @IBOutlet weak var OldPasswordTextField: UITextField!
  @IBOutlet weak var NewPasswordTextField: UITextField!
  @IBOutlet weak var RepeatedPasswordTextField: UITextField!
  @IBOutlet weak var DoneBtn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Constants.viewBackgroundColor
    
    OldPasswordTextField.delegate = self
    NewPasswordTextField.delegate = self
    RepeatedPasswordTextField.delegate = self
  }
  
  override func viewWillAppear(animated: Bool) {
    handleNetworkError()
    
    self.navigationController?.navigationBarHidden = false
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
    
    if(oldPwd != loginPassword) {
      error = falsePassword
    }
    else if(!newUserFunc.checkPassword(newPwd)) {
      error = checkPasswordFalse
    }
    else if(repeatedPwd != newPwd) {
      error = repeatedIsNotNew
    }
    
    newUserFunc.checkInput(oldPwd == loginPassword, textField: OldPasswordTextField)
    newUserFunc.checkInput(newUserFunc.checkPassword(newPwd), textField: NewPasswordTextField)
    newUserFunc.checkInput(repeatedPwd == newPwd, textField: RepeatedPasswordTextField)
    
    switch error {
    case falsePassword:
      let alert = UIAlertController(title: "Alert", message: "False Password", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      
      // Support display in iPad
      alert.popoverPresentationController?.sourceView = self.view
      alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
      
      self.presentViewController(alert, animated: true, completion: nil)
      
    case repeatedIsNotNew:
      let alert = UIAlertController(title: "Alert", message: "Repeated Password is not the same as New Password", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      
      // Support display in iPad
      alert.popoverPresentationController?.sourceView = self.view
      alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
      
      self.presentViewController(alert, animated: true, completion: nil)
      
    case checkPasswordFalse:
      let alert = UIAlertController(title: "Alert", message: "Please enter a valid Password", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      
      // Support display in iPad
      alert.popoverPresentationController?.sourceView = self.view
      alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
      
      self.presentViewController(alert, animated: true, completion: nil)
      
    case 0:
      DatabaseManager.sharedManager.changeUserPassword(username, newPassword: NewPasswordTextField.text!, oldPassword: loginPassword) {success, message in
        if success == true {
          dispatch_async(dispatch_get_main_queue(),{
            let alert = UIAlertController(title: "Changed Password", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            // Support display in iPad
            alert.popoverPresentationController?.sourceView = self.view
            alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
          });
        }
        else {
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
