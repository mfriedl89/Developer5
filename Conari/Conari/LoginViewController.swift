//
//  LoginViewController.swift
//  Conari
//
//  Created by Markus Friedl on 13.04.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
  
  // MARK: - Outlets
  
  @IBOutlet weak var userNameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    userNameTextField.delegate = self
    passwordTextField.delegate = self
  }
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBarHidden = false
    
    userNameTextField.text = ""
    passwordTextField.text = ""
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
}
