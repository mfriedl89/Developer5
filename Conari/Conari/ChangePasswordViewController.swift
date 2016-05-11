//
//  ChangePasswordViewController.swift
//  Conari
//
//  Created by Paul Krassnig on 11.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var OldPasswordTextField: UITextField!
    @IBOutlet weak var NewPasswordTextField: UITextField!
    @IBOutlet weak var RepeatedPasswordTextField: UITextField!
    
    let falsePassword = -1
    let repeatedIsNotNew = -2
    let checkPasswordFalse = -3
    
    var login_password_ = DatabaseManager.sharedManager.getUserPassword()
    
    var newUserFunc = NewUserViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        newUserFunc.checkInput(repeatedPwd == newPwd, textField: RepeatedPasswordTextField)
        newUserFunc.checkInput(newUserFunc.checkPassword(newPwd), textField: NewPasswordTextField)
        
        switch error {
        case falsePassword:
            let alert = UIAlertController(title: "Alert", message: "False Password", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            break
        case repeatedIsNotNew:
            let alert = UIAlertController(title: "Alert", message: "Repeated Password is not the same as New Password", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            break
        case checkPasswordFalse:
            let alert = UIAlertController(title: "Alert", message: "Please enter a valid Password", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            break
        default: break
        }

        
        return error
    }
    

    @IBAction func DoneBtnClicked(sender: AnyObject) {
        changePassword(OldPasswordTextField.text!, newPwd: NewPasswordTextField.text!, repeatedPwd: RepeatedPasswordTextField.text!)
    }

}
