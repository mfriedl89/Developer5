//
//  NewUserViewController.swift
//  Conari
//
//  Created by Paul Krassnig on 13.04.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit


class NewUserViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatedPassword: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewInScrollView: UIView!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    let invalidUser = "Username is not valid"
    var activeField: UITextField?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        userName.delegate = self
        name.delegate = self
        surname.delegate = self
        email.delegate = self
        password.delegate = self
        repeatedPassword.delegate = self
        
        scrollView.scrollsToTop = true

        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        deregisterFromKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func registerForKeyboardNotifications()
    {
        //Adding notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWasShown), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications()
    {
        //Removing notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification)
    {
        //Need to calculate keyboard exact size due to Apple suggestions
        
        self.scrollView.scrollEnabled = true
        let info : NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height + UIApplication.sharedApplication().statusBarFrame.size.height * 2 + 32, 0.0)
        // * 2 because bevor it was under top layout and + 8 because there are 8ptx constraints from the top
        self.viewInScrollView.frame.size.height = view.frame.height
        self.scrollView.contentSize.height = view.frame.height + UIApplication.sharedApplication().statusBarFrame.size.height * 2 + 32
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if (activeField) != nil
        {
            if (!CGRectContainsPoint(aRect, activeField!.frame.origin))
            {
                self.scrollView.scrollRectToVisible(activeField!.frame, animated: true)
            }
        }
        
    }
    
    
    func keyboardWillBeHidden(notification: NSNotification)
    {
        //Once keyboard disappears, restore original positions
        let info : NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.scrollEnabled = false
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        activeField = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        activeField = nil
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField == userName) {
            name.becomeFirstResponder()
        }
        else if(textField == name) {
            surname.becomeFirstResponder()
        }
        else if(textField == surname) {
            email.becomeFirstResponder()
        }
        else if(textField == email) {
            password.becomeFirstResponder()
        }
        else if(textField == password){
            repeatedPassword.becomeFirstResponder()
        }
        else {
            repeatedPassword.resignFirstResponder()
            test(doneBtn)
        }
        return true
    }
    
    func invalidInput(textField: String, errors: Int, is_error: Bool) -> Int {
        var number_of_errors = errors;
        if (is_error == true){
            number_of_errors = number_of_errors + 1
        }
        
        if (number_of_errors == 1)
        {
            
            if ((textField == "Username") && (is_error == true))
            {
                let alert = UIAlertController(title: "Alert", message: "Enter a valid username.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else if ((textField == "Firstname") && (is_error == true)){
                let alert = UIAlertController(title: "Alert", message: "Enter a valid first name.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else if ((textField == "Surname") && (is_error == true)){
                let alert = UIAlertController(title: "Alert", message: "Enter a valid surname.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else if ((textField == "Email") && (is_error == true)){
                let alert = UIAlertController(title: "Alert", message: "Enter a valid Email address.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else if ((textField == "PasswordWrong") && (is_error == true)){
                let alert = UIAlertController(title: "Alert", message: "A password must contain one uppercase letter, one lowercase letter, one digit, one special character and is between 9 and 31 characters long.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else if ((textField == "PasswordRepeat") && (is_error == true)){
                let alert = UIAlertController(title: "Alert", message: "Passwords are not the same.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        
        return number_of_errors
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func checkInput(bool: Bool, textField: UITextField) {
        if(bool == false) {
            textField.backgroundColor = UIColor(red: 1, green: 0.498, blue: 0.498, alpha: 1.0)
            
        }
        else {
            textField.backgroundColor = UIColor.whiteColor()
        }
    }
    
    
    func checkingUsername(userName: String) -> Bool {
        let trimmedStr = userName.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )
        
        if(trimmedStr.isEmpty) {
            return false
        }
        
        for Character in trimmedStr.characters {
            if(Character == " ") {
                return false
            }
        }
        
        return true
    }
    
    func checkingNameAndSurname(name: String) -> Bool {
        let trimmedStr = name.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )
        
        if(trimmedStr.isEmpty) {
            return false
        }
        
        for Character in trimmedStr.characters {
            if (!(Character >= "a" && Character <= "z") &&
                !(Character >= "A" && Character <= "Z") &&
                (Character != " ")) {
                return false
            }
        }
        
        return true
    }
    
    
    //TODO: check if username isn`t used yet
    
    func checkEmailAddress(mail:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let trimmedStr = mail.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluateWithObject(trimmedStr) ? true : false
    }
    
    func checkPassword(password:String) -> Bool {
        
        var lowLetterExists = false
        var upperLetterExists = false
        var specialLetterExists = false
        var countExists = false
        
        let upperCaseLetterSet:NSCharacterSet = NSCharacterSet.uppercaseLetterCharacterSet()
        let lowerCaseLetterSet:NSCharacterSet = NSCharacterSet.lowercaseLetterCharacterSet()
        let specialCharacterSet:NSCharacterSet = NSCharacterSet.init(charactersInString: "!\"§$%&/()=?´`+*#'-_.:,;<>@")
        let countCaseLetterSet:NSCharacterSet = NSCharacterSet.decimalDigitCharacterSet()
        
        if(password.characters.count < 8 || password.characters.count > 32) {
            return false
        }
        
        
        for Character in password.utf16 {
            if(lowerCaseLetterSet.characterIsMember(Character)) {
                lowLetterExists = true
            }
            else if(upperCaseLetterSet.characterIsMember(Character)) {
                upperLetterExists = true
            }
            else if(countCaseLetterSet.characterIsMember(Character)) {
                countExists = true
            }
            else if(specialCharacterSet.characterIsMember(Character)) {
                specialLetterExists = true
            }
        }
        
        if(lowLetterExists &&
           upperLetterExists &&
           specialLetterExists &&
           countExists) {
            return true
        }
        else {
            return false
        }
        
    }
    
    func checkRepeatedPassword(password:String, repeated:String) -> Bool {
        
        return (password == repeated) ? true : false
    }

    @IBAction func screenClicked(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func test(sender: UIButton) {
        var error_counter = 0;
        
        var bool = checkingUsername(userName.text!)
        checkInput(bool, textField: userName)
        error_counter = invalidInput("Username", errors: error_counter, is_error: !bool)
        
        bool = checkingNameAndSurname(name.text!)
        checkInput(bool, textField: name)
        error_counter = invalidInput("Firstname", errors: error_counter, is_error: !bool)

        bool = checkingNameAndSurname(surname.text!)
        checkInput(bool, textField: surname)
        error_counter = invalidInput("Surname", errors: error_counter, is_error: !bool)
        
        bool = checkEmailAddress(email.text!)
        checkInput(bool, textField: email)
        error_counter = invalidInput("Email", errors: error_counter, is_error: !bool)
        
        bool = checkPassword(password.text!)
        checkInput(bool, textField: password)
        error_counter = invalidInput("PasswordWrong", errors: error_counter, is_error: !bool)
        
        bool = checkRepeatedPassword(password.text!, repeated: repeatedPassword.text!)
        checkInput(bool, textField: repeatedPassword)
        error_counter = invalidInput("PasswordRepeat", errors: error_counter, is_error: !bool)
        
        if (error_counter == 0) {
            DatabaseManager.sharedManager.CreateUser(userName.text!, password: password.text!, firstName: name.text!, surName: surname.text!, email: email.text!) { success, message in
                if (success == false) {
                    self.showErrorMessage(message!)
                }
            }
        }
        
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
