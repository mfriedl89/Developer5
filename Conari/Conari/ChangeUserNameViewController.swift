//
//  ChangeUserNameViewController.swift
//  Conari
//
//  Created by Paul Krassnig on 11.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class ChangeUserNameViewController: UIViewController {

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
    
    username = DatabaseManager.sharedManager.getUserName()
  
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
          self.FirstNameTextField.text = User!.firstname
          self.SurNameTextField.text! = User!.surname
        })
      }
      
    };

    // Do any additional setup after loading the view.
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
      self.presentViewController(alert, animated: true, completion: nil)
      break
    case falseSurname:
      let alert = UIAlertController(title: "Alert", message: "Please enter a valid Surname", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      break
    case 0:
      DatabaseManager.sharedManager.changeUserFirstAndSurname(username, password: password, new_firstname: new_firstname, new_surname: new_surname) {success, message in
        if success == true
        {
          dispatch_async(dispatch_get_main_queue(),{
            let alert = UIAlertController(title: "Changed Firstname/Surname to: \(new_firstname) \(new_surname)", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
          });
        }
        else
        {
          dispatch_async(dispatch_get_main_queue(),{
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
          });
        }
      }
      break
    default: break
    }
    
    
    return true
  }

  @IBAction func doneBtnClicked(sender: AnyObject) {
    test(FirstNameTextField.text!, new_surname: SurNameTextField.text!)
  }
  
  func showErrorMessage(message: String) {
    dispatch_async(dispatch_get_main_queue(), {
      //create alert
      let errorAlert = UIAlertController(title: "Error",
        message: message,
        preferredStyle: UIAlertControllerStyle.Alert)
      
      //make button
      let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
      
      //add buttons
      errorAlert.addAction(okAction)
      
      //display
      self.presentViewController(errorAlert, animated: true, completion: nil)
    })
  }


}
