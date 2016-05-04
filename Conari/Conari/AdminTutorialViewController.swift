//
//  AdminTutorialViewController.swift
//  Conari
//
//  Created by Markus Friedl on 04.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class AdminTutorialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tutorialsTableView: UITableView!

    var tutorialIndexPath: NSIndexPath? = nil

    // For testing BEGIN
    var tutorials = ["Arts and Entertainment",
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
    // For testing END

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

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutorials.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "TutorialTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TutorialTableViewCell
        
        cell.tutorialTitleLabel.text = tutorials[indexPath.row]
        cell.tutorialDetailTextLabel.text = "Detailtext #" + String(indexPath.row)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let rename = UITableViewRowAction(style: .Normal, title: "Rename") { action, index in
            print("rename button tapped")
            
            self.tutorialIndexPath = indexPath
            
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

            self.renameTutorial()
        }
        rename.backgroundColor = UIColor.lightGrayColor()
        
        let edit = UITableViewRowAction(style: .Normal, title: "Edit") { action, index in
            print("edit button tapped")
        }
        edit.backgroundColor = UIColor.orangeColor()
        
        let delete = UITableViewRowAction(style: .Default, title: "Delete") { action, index in
            print("delete button tapped")
            
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! TutorialTableViewCell
            
            self.tutorialIndexPath = indexPath
            
            //            let planetToDelete = tableView[indexPath.row]
            
            self.confirmDelete(cell.tutorialTitleLabel.text!)
        }
        
        return [delete, edit, rename]
    }
    
    func renameTutorial() {
        if let indexPath = tutorialIndexPath {
            var alertController:UIAlertController?
            alertController = UIAlertController(title: "Change tutorial name",
                                                message: tutorials[indexPath.row],
                                                preferredStyle: .Alert)
            
            alertController!.addTextFieldWithConfigurationHandler(
                {(textField: UITextField!) in
                    textField.placeholder = "Enter new tutorial name"
            })
            
            let action = UIAlertAction(title: "Submit",
                                       style: UIAlertActionStyle.Default,
                                       handler: {[weak self]
                                        (paramAction:UIAlertAction!) in
                                        if let textFields = alertController?.textFields{
                                            let theTextFields = textFields as [UITextField]
                                            let enteredText = theTextFields[0].text
                                            self!.tutorials[indexPath.row] = enteredText!
                                            
                                            
//                                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                                self!.tutorialsTableView.reloadData()
//                                            })
                                        }
                })
            
            alertController?.addAction(action)
            alertController?.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
                alertController! .dismissViewControllerAnimated(true, completion: nil)
            }))
            
            self.presentViewController(alertController!,
                                       animated: true,
                                       completion: nil)
            
            tutorialIndexPath = nil
        }
    }
    
    func confirmDelete(tutorial: String) {
        let alert = UIAlertController(title: "Delete Tutorial", message: "Are you sure you want to permanently delete \(tutorial)?", preferredStyle: .ActionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeletePlanet)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDeletePlanet)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func handleDeletePlanet(alertAction: UIAlertAction!) -> Void {
        if let indexPath = tutorialIndexPath {
            tutorialsTableView.beginUpdates()
            
            tutorials.removeAtIndex(indexPath.row)
            
            // Note that indexPath is wrapped in an array:  [indexPath]
            tutorialsTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            tutorialIndexPath = nil
            
            tutorialsTableView.endUpdates()
        }
    }
    
    func cancelDeletePlanet(alertAction: UIAlertAction!) {
        tutorialIndexPath = nil
    }
}
