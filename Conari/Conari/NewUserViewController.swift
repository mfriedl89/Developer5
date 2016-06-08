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
  
  let invalidUser = "Enter a valid username."
  let invalidFirstName = "Enter a valid first name."
  let invalidSurName = "Enter a valid surname."
  let invalidEMail = "Enter a valid E-Mail address."
  let invalidPassword = "A password must contain one uppercase letter, one lowercase letter, one digit, one special character and is between 9 and 31 characters long."
  
  var activeField: UITextField?
  
  var scrollInset : CGFloat = 0
  
  var success:Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewInScrollView.backgroundColor = Constants.viewBackgroundColor
    
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
    self.navigationController?.navigationBarHidden = true
  }
  
  override func viewWillAppear(animated: Bool) {
    deregisterFromKeyboardNotifications()
    self.navigationController?.navigationBarHidden = false
  }
  

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func registerForKeyboardNotifications() {
    //Adding notifies on keyboard appearing
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWasShown), name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIKeyboardWillHideNotification, object: nil)
  }
  
  
  func deregisterFromKeyboardNotifications() {
    //Removing notifies on keyboard appearing
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
  }
  
  func keyboardWasShown(notification: NSNotification) {
    //Need to calculate keyboard exact size due to Apple suggestions
    
    self.scrollView.scrollEnabled = true
    let info : NSDictionary = notification.userInfo!
    let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
    
    let doneBtnPos = doneBtn.frame.origin.y + doneBtn.frame.height/2
    
    if(doneBtnPos > view.frame.height - keyboardSize!.height) {
      scrollInset =  keyboardSize!.height - (view.frame.height - doneBtnPos)
    }
    else {
      scrollInset = keyboardSize!.height
    }
    
    let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, scrollInset, 0.0)
    self.viewInScrollView.frame.size.height = view.frame.height
    self.scrollView.contentSize.height = view.frame.height + UIApplication.sharedApplication().statusBarFrame.size.height
    self.scrollView.contentInset = contentInsets
    self.scrollView.scrollIndicatorInsets = contentInsets
    
    
    var aRect : CGRect = self.view.frame
    aRect.size.height -= keyboardSize!.height
    if (activeField) != nil {
      if (!CGRectContainsPoint(aRect, activeField!.frame.origin)) {
        self.scrollView.scrollRectToVisible(activeField!.frame, animated: true)
      }
    }
    
  }
  
  
  func keyboardWillBeHidden(notification: NSNotification) {
    //Once keyboard disappears, restore original positions
    let info : NSDictionary = notification.userInfo!
    let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
    
    if(doneBtn.frame.origin.y + doneBtn.frame.height/2 > view.frame.height) {
      scrollInset = 0
    }
    else {
      scrollInset = keyboardSize!.height * -1
    }
    
    let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, scrollInset, 0.0)
    self.scrollView.contentInset = contentInsets
    self.scrollView.scrollIndicatorInsets = contentInsets
    self.view.endEditing(true)
    self.scrollView.scrollEnabled = true
    
  }
  
  func textFieldDidBeginEditing(textField: UITextField) {
    activeField = textField
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
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
    
    if (number_of_errors == 1) {
      
      if ((textField == "Username") && (is_error == true))
      {
        let alert = UIAlertController(title: "Alert", message: invalidUser, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)

        self.presentViewController(alert, animated: true, completion: nil)
      }
      else if ((textField == "Firstname") && (is_error == true)){
        let alert = UIAlertController(title: "Alert", message: invalidFirstName, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)

        self.presentViewController(alert, animated: true, completion: nil)
      }
      else if ((textField == "Surname") && (is_error == true)){
        let alert = UIAlertController(title: "Alert", message: invalidSurName, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)

        self.presentViewController(alert, animated: true, completion: nil)
      }
      else if ((textField == "Email") && (is_error == true)){
        let alert = UIAlertController(title: "Alert", message: invalidEMail, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))

        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)

        self.presentViewController(alert, animated: true, completion: nil)
      }
      else if ((textField == "PasswordWrong") && (is_error == true)){
        let alert = UIAlertController(title: "Alert", message: invalidPassword, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)

        self.presentViewController(alert, animated: true, completion: nil)
      }
      else if ((textField == "PasswordRepeat") && (is_error == true)){
        let alert = UIAlertController(title: "Alert", message: "Passwords are not the same.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)

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
      DatabaseManager.sharedManager.createUser(userName.text!, password: password.text!, firstName: name.text!, surName: surname.text!, email: email.text!) { success, message in
        
        self.showMessage(message!, username: self.userName.text!)
        
      }
    }
    
  }
  
  func showMessage(message: String, username: String) {
    dispatch_async(dispatch_get_main_queue(), {
      var title = ""
      var msg = ""
      
      //create alert
      if(message == "true") {
        self.success = true
        title = "Success"
        msg = "Created user: \(username)"
        self.userName.text = ""
        self.name.text = ""
        self.surname.text = ""
        self.email.text = ""
        self.password.text = ""
        self.repeatedPassword.text = ""
      }
      else {
        self.success = false
        title = "Error"
        msg = message
      }
      
      let errorAlert = UIAlertController(title: title,
        message: msg,
        preferredStyle: UIAlertControllerStyle.Alert)
      
      //make button
      let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: self.okHandler)
      
      //add buttons
      errorAlert.addAction(okAction)
      
      // Support display in iPad
      errorAlert.popoverPresentationController?.sourceView = self.view
      errorAlert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)

      //display
      self.presentViewController(errorAlert, animated: true, completion: nil)
    })
  }
  
  func okHandler(alertAction: UIAlertAction!) -> Void {
    dispatch_async(dispatch_get_main_queue(),{
      if(self.success)
      {
        for viewcontoller in (self.navigationController?.viewControllers)!
        {
          if(viewcontoller.isKindOfClass(LoginViewController))
          {
            self.navigationController?.popToViewController(viewcontoller, animated: true);
          }
        }
      }
      
    });
  }
  
}
