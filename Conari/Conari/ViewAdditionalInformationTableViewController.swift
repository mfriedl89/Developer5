//
//  ViewAdditionalInformationTableViewController.swift
//  Conari
//
//  Created by Philipp Preiner on 04.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class ViewAdditionalInformationTableViewController: UITableViewController {
  
  var tutorial: Tutorial_item? = nil
  
  var difficultLabels = ["very easy",
                         "easy",
                         "medium",
                         "hard",
                         "very hard"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Constants.viewBackgroundColor
    navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
  }
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBarHidden = false
    handleNetworkError()
  }
  
  @IBAction func doneTapped(sender: UIBarButtonItem) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 5
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
    
    // Configure the cell...
    
    switch indexPath.row {
    case 0:
      cell.textLabel?.text = "Title"
      cell.detailTextLabel?.text = tutorial?.title
      
    case 1:
      cell.textLabel?.text = "Author"
      cell.detailTextLabel?.text = tutorial?.author
      
    case 2:
      cell.textLabel?.text = "Category"
      cell.detailTextLabel?.text = categories[(tutorial?.category)!-1]
      
    case 3:
      cell.textLabel?.text = "Difficulty"
      cell.detailTextLabel?.text = self.difficultLabels[Int((tutorial?.difficulty)!)!-1]
      
    case 4:
      cell.textLabel?.text = "Duration"
      
      let durationInSec: Int = Int((tutorial?.duration)!)! * 60
      let duration: String = String( (durationInSec / 3600) ) + " : " + String( ((durationInSec % 3600) / 60) )
      
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "HH:mm"
      
      let date = dateFormatter.dateFromString(duration)
      let dateString = dateFormatter.stringFromDate(date!)
      
      cell.detailTextLabel?.text = dateString
      
    default:
      break
    }
    
    return cell
  }
}