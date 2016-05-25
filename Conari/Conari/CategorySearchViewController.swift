//
//  CategorySearchViewController.swift
//  Conari
//
//  Created by ST R W on 20.04.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit
import SDWebImage

class CategorySearchViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, SDWebImageManagerDelegate, UISearchDisplayDelegate, UISearchResultsUpdating  {
  
  var selectedCategory = 0
  var textSearch = ""
  
  var screenWidth: CGFloat = 0
  var screenHeight: CGFloat = 0
  
  var searchController: UISearchController!
  
  deinit {
    if let sc = searchController {
      if let superView = sc.view.superview {
        superView.removeFromSuperview()
      }
    }
  }
  
  var tutorial_array = [Tutorial_item]()
  var youtube_array = [YoutubeVideo]()
  
  @IBOutlet var table_View: UITableView!
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBarHidden = false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    table_View.delegate = self
    table_View.dataSource = self
    
    screenWidth = self.view.frame.width
    screenHeight = self.view.frame.height
    
    if (textSearch == "") {
      configureSearchController()
      self.title = categories[selectedCategory]
    } else {
      self.title = textSearch
    }
    
    reloadArrays()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeueReusableCellWithIdentifier("SearchTableViewCell", forIndexPath: indexPath) as! CategorySearchTableViewCell
      let duration_hours = Int(tutorial_array[indexPath.row].duration)!/60
      let duration_minutes = Int(tutorial_array[indexPath.row].duration)!%60
      
      cell.label_title?.text = tutorial_array[indexPath.row].title
      cell.label_category?.text = categories[tutorial_array[indexPath.row].category]
      
      cell.label_duration.text = String(format: "%02d:%02d", duration_hours,duration_minutes)
      cell.image_view.image = UIImage(named: "\(tutorial_array[indexPath.row].category-1)")
      
      switch Int(tutorial_array[indexPath.row].difficulty)! {
      case 5:
        cell.label_difficulty?.text = "very hard";
        
      case 4:
        cell.label_difficulty?.text = "hard";
        
      case 3:
        cell.label_difficulty?.text = "medium";
        
      case 2:
        cell.label_difficulty?.text = "easy";
        
      case 1:
        cell.label_difficulty?.text = "very easy";
        
      default:
        break
      }
      return cell
      
    case 1:
      let cell = tableView.dequeueReusableCellWithIdentifier("SearchTableYoutubeViewCell", forIndexPath: indexPath) as! CategorySearchYoutubeTableViewCell
      cell.label_title?.text = youtube_array[indexPath.row].title
      cell.imageView?.sd_setImageWithURL(NSURL(string:self.youtube_array[indexPath.row].thumbnail), placeholderImage: UIImage(), completed: {(image: UIImage?, error: NSError?, cacheType: SDImageCacheType!, imageURL: NSURL?) in
        if let cellToUpdate = self.table_View?.cellForRowAtIndexPath(indexPath)
        {
          cellToUpdate.setNeedsLayout()
        }
      })
      return cell
      
    default:
      break
      
    }
    return UITableViewCell()
    
  }
  
  func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return tutorial_array.count
      
    case 1:
      return youtube_array.count
      
    default:
      return 0
    }
  }
  
  func numberOfSectionsInTableView(tableView:UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView:UITableView, heightForRowAtIndexPath indexPath:NSIndexPath)->CGFloat {
    return 100
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      if tutorial_array.count == 0 {
        return ""
      } else {
        return "Tutorials"
      }
    case 1:
      if youtube_array.count == 0 {
        return ""
      } else {
        return "Youtube"
      }
    default:
      return ""
    }
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    switch indexPath.section {
    case 0:
      self.performSegueWithIdentifier("show_tutorial", sender: indexPath.row)
      
    case 1:
      break;
      
    default:
      return
    }
    
    tableView.deselectRowAtIndexPath(indexPath, animated: false);
  }
  
  func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    cell.imageView?.sd_cancelCurrentImageLoad();
    cell.imageView?.image = nil
  }
  
  func configureSearchController() {
    // Initialize and perform a minimum configuration to the search controller.
    searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = true
    searchController.searchBar.placeholder = "Search here..."
    searchController.searchBar.delegate = self
    searchController.searchBar.sizeToFit()
    //searchController.searchBar.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 50)
    
    // Place the search bar view to the tableview headerview.
    table_View.tableHeaderView = searchController.searchBar
  }
  
  func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    if searchBar.text != "" {
      textSearch = searchBar.text!
    }
    if(textSearch != "") {
      searchBar.placeholder = textSearch
    } else {
      searchBar.placeholder = "Search here..."
    }
    reloadArrays()
  }
  
  func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
    searchBar.text = textSearch
  }
  
  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    if searchBar.text != "" {
      textSearch = searchBar.text!
    }
    if(textSearch != "") {
      searchBar.placeholder = textSearch
    } else {
      searchBar.placeholder = "Search here..."
    }
    
    reloadArrays()
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    table_View.reloadData()
    searchController.searchBar.resignFirstResponder()
  }
  
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    
  }
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    let searchString = searchController.searchBar.text
    textSearch = searchString!
    reloadArrays()
  }
  
  func reloadArrays() {
    if textSearch != "" {
      YouTubeManager.sharedManager.searchVideoByTitle(textSearch, completionHandler: {
        (response,success,message ) in
        if(!success || response.isEmpty) {
          return
        }
        self.youtube_array.removeAll()
        self.youtube_array = response
        dispatch_async(dispatch_get_main_queue(), {
          self.table_View.reloadData();
        })
      })
    }
    
    DatabaseManager.sharedManager.findTutorialByCategory(textSearch, tutorial_category: selectedCategory) { (response) in
      if(!response.isEmpty) {
        self.tutorial_array = response
        self.table_View.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: true)
        
      } else {
        self.tutorial_array.removeAll()
        self.table_View.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: true)
      }
      
      dispatch_async(dispatch_get_main_queue(), {
        self.table_View.reloadData();
      })
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "show_tutorial" {
      let csvc = (segue.destinationViewController as! ViewFinishedTutorialViewController)
      csvc.TutorialID = self.tutorial_array[(sender as! Int)].id
    }
  }
}