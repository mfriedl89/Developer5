//
//  AdminTutorialViewController.swift
//  Tutorialcloud
//
//  Created on 04.05.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import UIKit

class AdminTutorialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  // MARK: - Members
  
  var categories = ["All",
                    "Arts and Entertainment",
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
  
  var tutorialIndexPath: NSIndexPath? = nil
  var tutorialArray = [TutorialItem]()
  var editTutorial : Tutorial?
  
  // MARK: - Outlets
  
  @IBOutlet weak var tutorialsTableView: UITableView!
  @IBOutlet weak var laodIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Constants.viewBackgroundColor
  }
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBarHidden = false
    
    tutorialsTableView.reloadData()
    
    handleNetworkError()
    
    DatabaseManager.sharedManager.findTutorialByUsername(DatabaseManager.sharedManager.username) { (response) in
      
      if(!response.isEmpty) {
        self.tutorialArray = response
        self.tutorialsTableView.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: true)
      } else {
        self.tutorialArray.removeAll()
        self.tutorialsTableView.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: true)
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  

  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tutorialArray.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "TutorialTableViewCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TutorialTableViewCell
    
    cell.tutorialTitleLabel.text = tutorialArray[indexPath.row].title
    cell.tutorialDetailTextLabel.text = categories[tutorialArray[indexPath.row].category]
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.requestTutorial(self.tutorialArray[indexPath.row].id)
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == UITableViewCellEditingStyle.Delete {
      let cell = tableView.cellForRowAtIndexPath(indexPath) as! TutorialTableViewCell
      self.tutorialIndexPath = indexPath
      
      self.confirmDelete(cell.tutorialTitleLabel.text!)
    }
  }
  
  func requestTutorial(tutorialID: Int) {
    DatabaseManager.sharedManager.requestTutorial(tutorialID) { tutorial, message in
      
      dispatch_async(dispatch_get_main_queue(), {
        let svc = self.storyboard?.instantiateViewControllerWithIdentifier("showEditOptions") as! TutorialEditOptionsController
        
        svc.oldTitle = tutorial?.title
        svc.oldCategory = self.categories[(tutorial?.category)!]
        svc.editTutorial = tutorial
        svc.editTutorialId = String(tutorialID)
        
        self.navigationController?.pushViewController(svc, animated: true)
      })
    }
  }
  
  func confirmDelete(tutorial: String) {
    let alert = UIAlertController(title: "Delete Tutorial", message: "Are you sure you want to permanently delete \(tutorial)?", preferredStyle: .ActionSheet)
    
    let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeleteTutorial)
    let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDeleteTutorial)
    
    alert.addAction(DeleteAction)
    alert.addAction(CancelAction)
    
    // Support display in iPad
    alert.popoverPresentationController?.sourceView = self.view
    alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
    
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
  func handleDeleteTutorial(alertAction: UIAlertAction!) -> Void {
    self.laodIndicator.startAnimating()
    self.laodIndicator.transform=CGAffineTransformMakeScale(1.5, 1.5)
    self.laodIndicator.hidden = false
    
    if let indexPath = tutorialIndexPath {
      tutorialsTableView.beginUpdates()
      let tutId = tutorialArray[indexPath.row].id
      print("want to delete tutorial with title " + tutorialArray[indexPath.row].title)
      
      DatabaseManager.sharedManager.deleteTutorial(tutId) { success, message in
        print("upload-success: \(success), login-message:\(message)")
        if success == true {
          print("success");
          dispatch_async(dispatch_get_main_queue(),{
            self.tutorialArray.removeAtIndex(indexPath.row)
            self.tutorialsTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            self.laodIndicator.stopAnimating()
            self.laodIndicator.hidden = true
          });
        } else {
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
      
      tutorialIndexPath = nil
      tutorialsTableView.endUpdates()
    }
  }
  
  func cancelDeleteTutorial(alertAction: UIAlertAction!) {
    tutorialIndexPath = nil
  }
}
