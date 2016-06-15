//
//  CategorySearchViewController.swift
//  Mr Tutor
//
//  Created on 20.04.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import UIKit
import SDWebImage
import YouTubePlayer

class CategorySearchViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, SDWebImageManagerDelegate, UISearchDisplayDelegate, UISearchResultsUpdating,YouTubePlayerDelegate
{
  
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
  
  var selectedCategory = 0
  var textSearch = ""
  var tutorials = [TutorialItem]()
  var alphabetizedTutorials = [String: [TutorialItem]]()
  
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
  
  var tutorialArray = [TutorialItem]()
  var youtubeArray = [YoutubeVideo]()
  
  // MARK: - Outlets
  
  @IBOutlet var table_View: UITableView!
  
  // MARK: - Lifecycle
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBarHidden = false
    
    handleNetworkError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Constants.viewBackgroundColor
    
    table_View.delegate = self
    table_View.dataSource = self
    
    
    screenWidth = self.view.frame.width
    screenHeight = self.view.frame.height
    
    
    if (textSearch == "") {
      configureSearchController()
      self.title = self.categories[selectedCategory]
    } else {
      self.title = textSearch
    }
    
    reloadArrays()
  }
  
  // MARK: - Table View
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if (textSearch != "") {
      switch indexPath.section {
      case 0:
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchTableViewCell", forIndexPath: indexPath) as! CategorySearchTableViewCell
        let durationHours = Int(tutorialArray[indexPath.row].duration)!/60
        let durationMinutes = Int(tutorialArray[indexPath.row].duration)!%60
        
        cell.label_title?.text = tutorialArray[indexPath.row].title
        cell.label_category?.text = categories[tutorialArray[indexPath.row].category]
        
        cell.label_duration.text = String(format: "%02d:%02d", durationHours,durationMinutes)
        cell.image_view.image = UIImage(named: "\(tutorialArray[indexPath.row].category-1)")
        
        switch Int(tutorialArray[indexPath.row].difficulty)! {
          
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
        cell.label_title?.text = youtubeArray[indexPath.row].title
        
        cell.imageView?.sd_setImageWithURL(NSURL(string:self.youtubeArray[indexPath.row].thumbnail), placeholderImage: UIImage(), completed: {(image: UIImage?, error: NSError?, cacheType: SDImageCacheType!, imageURL: NSURL?) in
          
          if let cellToUpdate = self.table_View?.cellForRowAtIndexPath(indexPath) {
            cellToUpdate.setNeedsLayout()
          }
        })
        
        return cell
        
      default:
        break
        
      }
    } else {
      let cell = tableView.dequeueReusableCellWithIdentifier("SearchTableViewCell", forIndexPath: indexPath) as! CategorySearchTableViewCell
      
      // Fetch and Sort Keys
      let keys = alphabetizedTutorials.keys.sort({ (a, b) -> Bool in
        a.lowercaseString < b.lowercaseString
      })
      
      // Fetch Fruits for Section
      let key = keys[indexPath.section]
      
      if let tutorialsForSection = alphabetizedTutorials[key] {
        // Fetch Fruit
        let currentTutorial = tutorialsForSection[indexPath.row]
        
        // Configure Cell
        let durationHours = Int(currentTutorial.duration)!/60
        let durationMinutes = Int(currentTutorial.duration)!%60
        
        cell.label_title?.text = currentTutorial.title
        cell.label_category?.text = categories[currentTutorial.category]
        
        cell.label_duration.text = String(format: "%02d:%02d", durationHours, durationMinutes)
        cell.image_view.image = UIImage(named: "\(currentTutorial.category - 1)")
        
        switch Int(currentTutorial.difficulty)! {
          
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
      }
    }

    return UITableViewCell()
  }
  
  func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
    if textSearch != "" {
      switch section {
      case 0:
        return tutorialArray.count
        
      case 1:
        return youtubeArray.count
        
      default:
        return 0
      }
    } else {
      let keys = alphabetizedTutorials.keys
      
      // Sort Keys
      let sortedKeys = keys.sort({ (a, b) -> Bool in
        a.lowercaseString < b.lowercaseString
      })
      
      // Fetch
      let key = sortedKeys[section]
      
      if let alphabetizedTutorials = alphabetizedTutorials[key] {
        return alphabetizedTutorials.count
      }
    }
    return 0
  }
  
  func numberOfSectionsInTableView(tableView:UITableView) -> Int {
    if textSearch != "" {
      return 2
    } else {
      let keys = alphabetizedTutorials.keys
      return keys.count
    }
  }
  
  func tableView(tableView:UITableView, heightForRowAtIndexPath indexPath:NSIndexPath)->CGFloat {
    return 100
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if textSearch != "" {
      switch section {
      case 0:
        if tutorialArray.count == 0 {
          return ""
        } else {
          return "Tutorials"
        }
        
      case 1:
        if youtubeArray.count == 0 {
          return ""
        } else {
          return "YouTube"
        }
        
      default:
        return ""
      }
    } else {
//      // Fetch and Sort Keys
//      let keys = alphabetizedTutorials.keys.sort({ (a, b) -> Bool in
//        a.lowercaseString < b.lowercaseString
//      })
//      
//      return keys[section]
      return nil
    }
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    switch indexPath.section {
    case 0:
      self.performSegueWithIdentifier("show_tutorial", sender: indexPath.row)
      
    case 1:
      if(indexPath.row < youtubeArray.count)
      {
        let height = self.navigationController!.navigationBar.frame.height
        let youtubevc = UIViewController();
        let videoPlayer = YouTubePlayerView(frame: self.view.frame)
        videoPlayer.delegate = self
        videoPlayer.loadVideoID(youtubeArray[indexPath.row].videoId)
        //self.showViewController(videoPlayer, sender: nil);
        youtubevc.navigationController?.navigationBarHidden = false
        youtubevc.view.addSubview(videoPlayer);
        self.navigationController?.pushViewController(youtubevc, animated: true)
        //self.view.addSubview(videoPlayer)
      }
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
  
  func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]?{
    // Fetch and Sort Keys
    let keys = alphabetizedTutorials.keys.sort({ (a, b) -> Bool in
      a.lowercaseString < b.lowercaseString
    })
    
    return keys
  }
  
  // MARK: - Helper
  
  private func configureSearchController() {
    // Initialize and perform a minimum configuration to the search controller.
    searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = true
    searchController.searchBar.placeholder = "Search here..."
    searchController.searchBar.delegate = self
    searchController.searchBar.sizeToFit()
    
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
        
        self.youtubeArray.removeAll()
        
        self.youtubeArray = response
        self.youtubeArray.sortInPlace({ $0.title < $1.title })
        
        dispatch_async(dispatch_get_main_queue(), {
          self.table_View.reloadData();
        })
      })
    }
    
    DatabaseManager.sharedManager.findTutorialByCategory(textSearch, tutorialCategory: selectedCategory) { (response) in
      if(!response.isEmpty) {
        self.tutorialArray = response
        self.tutorialArray.sortInPlace({ $0.title.lowercaseString  < $1.title.lowercaseString })
        self.alphabetizeArray()
        
      } else {
        self.tutorialArray.removeAll()
        self.table_View.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: true)
      }
      
      dispatch_async(dispatch_get_main_queue(), {
        self.table_View.reloadData();
      })
    }
  }
  
  private func alphabetizeArray() {
    for tutorial in tutorialArray {
      tutorials.append(tutorial)
    }
    alphabetizedTutorials = alphabetizeArray(tutorials)
  }
  
  private func alphabetizeArray(array: [TutorialItem]) -> [String: [TutorialItem]] {
    var result = [String: [TutorialItem]]()
    
    for item in array {
      let index = item.title.startIndex.advancedBy(1)
      let firstLetter = item.title.substringToIndex(index).uppercaseString
      
      if result[firstLetter] != nil {
        result[firstLetter]!.append(item)
      } else {
        result[firstLetter] = [item]
      }
    }
    
    for (key, value) in result {
      result[key] = value.sort({ (a, b) -> Bool in
        a.title.lowercaseString < b.title.lowercaseString
      })
    }
    
    return result
  }
  
  // MARK: - Navigation
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "show_tutorial" {
      let csvc = (segue.destinationViewController as! ViewFinishedTutorialViewController)
      csvc.tutorialID = self.tutorialArray[(sender as! Int)].id
      csvc.myTutorial = self.tutorialArray[(sender as! Int)]
    }
  }
  
  // MARK: - Delegate Protocols
  
  func playerReady(videoPlayer: YouTubePlayerView) {
    videoPlayer.play()
  }
  
  func playerStateChanged(videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
    if (playerState == .Ended) {
      videoPlayer.stop()
    }
  }
  
  func playerQualityChanged(videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
    
  }
}