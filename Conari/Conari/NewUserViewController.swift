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


class NewUserViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatedPassword: UITextField!
    
      
    @IBOutlet weak var doneBtn: UIButton!
    
    @IBAction func test(sender: UIButton) {
        
        var bool = checkingUsername(userName.text!)
        checkInput(bool, textField: userName)
        
        bool = checkingNameAndSurname(name.text!)
        checkInput(bool, textField: name)

        bool = checkingNameAndSurname(surname.text!)
        checkInput(bool, textField: surname)

        
    }
    
}
