//
//  LoginViewController.swift
//  Tutorialcloud
//
//  Created on 13.04.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var CloseBtn: UIButton!
  @IBOutlet weak var UsernameLabel: UILabel!
  @IBOutlet weak var PasswordLabel: UILabel!
  @IBOutlet weak var userNameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var LoginBtn: UIButton!
  @IBOutlet weak var CreateNewUserBtn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = Constants.viewBackgroundColor
    
    self.UsernameLabel.textColor = UIColor.whiteColor()
    self.PasswordLabel.textColor = UIColor.whiteColor()
    
    Constants.setGradientColor(self.view)
    
    Constants.setTextFieldForLogin(self.userNameTextField)

    Constants.setTextFieldForLogin(self.passwordTextField)
    
    
    self.CloseBtn.tintColor = UIColor.whiteColor()
    Constants.setRadiusWithColor(UIColor.whiteColor(), forButton: self.CloseBtn)
    
    self.LoginBtn.backgroundColor = UIColor.whiteColor()
    self.LoginBtn.tintColor = UIColor.blackColor()
    Constants.setRadiusWithColor(UIColor.whiteColor(), forButton: self.LoginBtn)
    
    self.CreateNewUserBtn.tintColor = UIColor.whiteColor()
    Constants.setRadiusWithColor(UIColor.whiteColor(), forButton: self.CreateNewUserBtn)
    
    // Do any additional setup after loading the view.
    
    userNameTextField.delegate = self
    passwordTextField.delegate = self
  }
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBarHidden = true
    
    userNameTextField.text = ""
    passwordTextField.text = ""
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    if (segue.identifier ==  "show_main_view"){
      let backItem = UIBarButtonItem()
      navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
  }
  
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    if (textField == userNameTextField) {
      passwordTextField.becomeFirstResponder()
      
    } else {
      passwordTextField.resignFirstResponder()
      
      loginCheck()
    }
    return true
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  @IBAction func loginPressed(sender: UIButton) {
    loginCheck()
  }
  
  func loginCheck() {
    if (checkInput() == true) {
      DatabaseManager.sharedManager.login(userNameTextField.text!, password: passwordTextField.text!) { success, message in
        if (success == false) {
          self.showErrorMessage(message!)
        }
        else
        {
          dispatch_async(dispatch_get_main_queue(),
                         {
                          self.performSegueWithIdentifier("show_main_view", sender: nil)
          })
        }
      }
    }
  }
  
  func checkInput() -> Bool {
    var inputValid: Bool = true
    
    if (checkTextField(userNameTextField) == false) { inputValid = false }
    if (checkTextField(passwordTextField) == false) { inputValid = false }
    
    return inputValid
  }
  
  func checkTextField(textField: UITextField) -> Bool {
    if textField.text == "" {
      textField.backgroundColor = UIColor(red: 1, green: 0.498, blue: 0.498, alpha: 1.0)
      return false
    }
    
    textField.backgroundColor = UIColor.clearColor()
    return true
  }
  
  @IBAction func ClosePressed(sender: AnyObject) {
    self.navigationController?.popViewControllerAnimated(true)
  }
}
