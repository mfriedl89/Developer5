//
//  NewUserViewController.swift
//  Conari
//
//  Created by Paul Krassnig on 13.04.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

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
    
    if(lowLetterExists == true &&
       upperLetterExists == true &&
       specialLetterExists == true &&
       countExists == true) {
        return true
    }
    else {
        return false
    }
    
}

func checkRepeatedPassword(password:String, repeated:String) -> Bool {

    return (password == repeated) ? true : false
}

class NewUserViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatedPassword: UITextField!
    
    
    @IBOutlet weak var doneBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        userName.delegate = self
        name.delegate = self
        surname.delegate = self
        email.delegate = self
        password.delegate = self
        repeatedPassword.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func test(sender: UIButton) {
        
        var bool = checkingUsername(userName.text!)
        checkInput(bool, textField: userName)
        
        bool = checkingNameAndSurname(name.text!)
        checkInput(bool, textField: name)

        bool = checkingNameAndSurname(surname.text!)
        checkInput(bool, textField: surname)
        
        bool = checkEmailAddress(email.text!)
        checkInput(bool, textField: email)
        
        bool = checkPassword(password.text!)
        checkInput(bool, textField: password)
        
        bool = checkRepeatedPassword(password.text!, repeated: repeatedPassword.text!)
        checkInput(bool, textField: repeatedPassword)
        
    }
    
}
