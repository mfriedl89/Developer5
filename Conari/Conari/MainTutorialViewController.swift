//
//  MainTutorialViewController.swift
//  Conari
//
//  Created by Stefan Mitterrutzner on 27/04/16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class MainTutorialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var CreateTutorialButton_: UIBarButtonItem!
    @IBOutlet weak var SearchField_: UITextField!
    @IBOutlet weak var categoryTableView_: UITableView!
    
    var categories = ["Arts and Entertainment",
                      "Cars & Other Vehicles",
                      "Computers and Electronics",
                      "Conari",
                      "Education and Communications",
                      "Finance and Business",
                      "Food and Entertaining",
                      "Health",
                      "Hobbies and Crafts",
                      "Holidays and Traditions",
                      "Home and Garden",
                      "Personal Care and Style",
                      "Pets and Animals",
                      "Philosophy and Religion",
                      "Relationships",
                      "Sports and Fitness",
                      "Travel",
                      "Work World",
                      "Youth"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(DatabaseManager.sharedManager.username != "" && DatabaseManager.sharedManager.password != "")
        {
            CreateTutorialButton_.enabled = true
        }else
        {
            CreateTutorialButton_.enabled = false
        }
        
        SearchField_.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }

    
    override func willMoveToParentViewController(parent: UIViewController?) {
        super.willMoveToParentViewController(parent)
        if parent == nil {
            if(DatabaseManager.sharedManager.username != "" && DatabaseManager.sharedManager.password != "")
            {
                DatabaseManager.sharedManager.username = ""
                DatabaseManager.sharedManager.password = ""
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if (textField == SearchField_) {
            SearchField_.resignFirstResponder()
        }
        
        return true
    }
    

    @IBAction func SearchButtonPressed(sender: AnyObject) {
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.categoryTableView_.dequeueReusableCellWithIdentifier("category_cell_")! as UITableViewCell
        
        if let label = cell.textLabel{
            label.text = self.categories[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }
 

}
