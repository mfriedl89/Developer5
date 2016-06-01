//
//  ChangeUserNameViewController.swift
//  Conari
//
//  Created by Paul Krassnig on 11.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class ChangeUserNameViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var FirstNameTextField: UITextField!
  @IBOutlet weak var SurNameTextField: UITextField!
  @IBOutlet weak var DoneBtn: UIButton!
  
  var username = ""
  let password = DatabaseManager.sharedManager.getUserPassword()
  
  var newUserFunc = NewUserViewController()
  
  let falseFirstname = 1
  let falseSurname = 2
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Constants.viewBackgroundColor
    
    FirstNameTextField.delegate = self
    SurNameTextField.delegate = self
    
    username = DatabaseManager.sharedManager.getUserName()
    
    DatabaseManager.sharedManager.requestUser(username) {user, message in
      if (user == nil) {
        if message != nil {
          self.showErrorMessage(message!)
          
          dispatch_async(dispatch_get_main_queue(), {
            self.title = "Error"
          })
          
        }
      }
      else {
        dispatch_async(dispatch_get_main_queue(), {
          self.FirstNameTextField.text = user!.firstname
          self.SurNameTextField.text! = user!.surname
        })
      }
      
    };
    
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(animated: Bool) {
    handleNetworkError()
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if(textField == FirstNameTextField) {
      SurNameTextField.becomeFirstResponder()
    }
    else {
      SurNameTextField.resignFirstResponder()
      doneBtnClicked(DoneBtn)
    }
    return true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func test (new_firstname:String, new_surname:String) -> Bool {
    var error = 0
    
    if(!newUserFunc.checkingNameAndSurname(new_firstname)) {
      error = falseFirstname
    }
    else if(!newUserFunc.checkingNameAndSurname(new_surname)) {
      error = falseSurname
    }
    
    
    newUserFunc.checkInput(newUserFunc.checkingNameAndSurname(new_firstname), textField: FirstNameTextField)
    newUserFunc.checkInput(newUserFunc.checkingNameAndSurname(new_surname), textField: SurNameTextField)
    
    switch error {
    case falseFirstname:
      let alert = UIAlertController(title: "Alert", message: "Please enter a valid Firstname", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      
      // Support display in iPad
      alert.popoverPresentationController?.sourceView = self.view
      alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)

      self.presentViewController(alert, animated: true, completion: nil)
      
    case falseSurname:
      let alert = UIAlertController(title: "Alert", message: "Please enter a valid Surname", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      
      // Support display in iPad
      alert.popoverPresentationController?.sourceView = self.view
      alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)

      self.presentViewController(alert, animated: true, completion: nil)
      
    case 0:
      DatabaseManager.sharedManager.changeUserFirstAndSurname(username, password: password, new_firstname: new_firstname, new_surname: new_surname) {success, message in
        if success == true {
          dispatch_async(dispatch_get_main_queue(),{
            let alert = UIAlertController(title: "Changed Firstname/Surname to: \(new_firstname) \(new_surname)", message: message, preferredStyle: UIAlertControllerStyle.Alert)
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
    default:
      break
    }
    
    return true
  }
  
  @IBAction func doneBtnClicked(sender: AnyObject) {
    test(FirstNameTextField.text!, new_surname: SurNameTextField.text!)
  }
  
}
