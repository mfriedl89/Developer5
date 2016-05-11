//
//  ChangeUserNameViewController.swift
//  Conari
//
//  Created by Paul Krassnig on 11.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class ChangeUserNameViewController: UIViewController {

    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var SurNameTextField: UITextField!
    @IBOutlet weak var DoneBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserNameLabel.text = "User name: test"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func doneBtnClicked(sender: AnyObject) {
        
    }


}
