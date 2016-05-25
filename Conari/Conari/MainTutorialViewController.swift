//
//  MainTutorialViewController.swift
//  Conari
//
//  Created by Stefan Mitterrutzner on 27/04/16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class MainTutorialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
  @IBOutlet weak var SearchField_: UITextField!
  @IBOutlet weak var categoryTableView_: UITableView!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    SearchField_.delegate = self
    
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBarHidden = false
  }
  
  
  override func willMoveToParentViewController(parent: UIViewController?) {
    super.willMoveToParentViewController(parent)
    if parent == nil {
      if(DatabaseManager.sharedManager.username != "" && DatabaseManager.sharedManager.password != "") {
        
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
    performSegueWithIdentifier("tutorial_list_search", sender: nil)
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell:UITableViewCell = self.categoryTableView_.dequeueReusableCellWithIdentifier("category_cell")! as UITableViewCell
    
    cell.textLabel?.text = categories[indexPath.row]
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("tutorial_list_category", sender: indexPath.row)
    tableView.deselectRowAtIndexPath(indexPath, animated: false)
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "tutorial_list_category" {
      let csvc = (segue.destinationViewController as! CategorySearchViewController)
      csvc.selectedCategory = (sender as! Int)+1
      
    } else if segue.identifier == "tutorial_list_search" {
      let csvc = (segue.destinationViewController as! CategorySearchViewController)
      csvc.textSearch = SearchField_.text!
    }
  }
}
