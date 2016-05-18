//
//  CategorySearchViewController.swift
//  Conari
//
//  Created by ST R W on 20.04.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class CategorySearchViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, UISearchResultsUpdating  {
    
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
    
    
    var selected_category = 0
    var text_search = ""
    
    var screen_width: CGFloat = 0
    var screen_height: CGFloat = 0
    
    var searchController: UISearchController!
  
    deinit{
      if let sc = searchController
      {
        if let superView = sc.view.superview
        {
          superView.removeFromSuperview()
        }
      }
    }
  
    
    var tutorial_array = [Tutorial_item]()
    
        
    @IBOutlet var table_View: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
            table_View.delegate = self
            table_View.dataSource = self
            
            
            
            screen_width = self.view.frame.width
            screen_height = self.view.frame.height
            
            
            if (text_search == "")
            {
                configureSearchController()
                self.title = categories[selected_category]
            }else
            {
                self.title = text_search
            
            }
            
            
            
            
            DatabaseManager.sharedManager.findTutorialByCategory(text_search, tutorial_category: selected_category) { (response) in
                
                if(!response.isEmpty){
                    
                    self.tutorial_array = response
                    
                    self.table_View.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: true)
                    //self.table_View.reloadData()
                    
                    print("Tutorial Count: \(response.count)")
                    
                }else{
                    
                    print("Tutorial not found")
                    self.tutorial_array.removeAll()
                    self.table_View.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: true)
                    print("Tutorial Count: \(self.tutorial_array.count)")
                    //self.table_View.reloadData()
                }
                
              dispatch_async(dispatch_get_main_queue(),
                             {
                              self.table_View.reloadData();
              })
                
            }

        }
    
    
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            let cell = tableView.dequeueReusableCellWithIdentifier("SearchTableViewCell", forIndexPath: indexPath) as! CategorySearchTableViewCell
            let duration_hours = Int(tutorial_array[indexPath.row].duration)!/60
            let duration_minutes = Int(tutorial_array[indexPath.row].duration)!%60
            
            //cell.textLabel?.text = "test"
            cell.label_title?.text = tutorial_array[indexPath.row].title
            cell.label_category?.text = categories[tutorial_array[indexPath.row].category]
          
            cell.label_duration.text = String(format: "%02d:%02d", duration_hours,duration_minutes)
            cell.image_view.image = UIImage(named: "\(tutorial_array[indexPath.row].category-1)")
          
        switch Int(tutorial_array[indexPath.row].difficulty)! {
          case 5:
            cell.label_difficulty?.text = "very hard";
            break;
          case 4:
            cell.label_difficulty?.text = "hard";
            break;
          case 3:
            cell.label_difficulty?.text = "medium";
            break;
          case 2:
            cell.label_difficulty?.text = "easy";
            break;
          case 1:
            cell.label_difficulty?.text = "very easy";
            break;
          default:
            break;
          }

            
            return cell
        }
        
        func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return tutorial_array.count
        }
        
        func numberOfSectionsInTableView(tableView:UITableView) -> Int {
            
            return 1
        }
        
        func tableView(tableView:UITableView, heightForRowAtIndexPath indexPath:NSIndexPath)->CGFloat
        {
            return 70
        }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("show_tutorial", sender: indexPath.row)
        tableView.deselectRowAtIndexPath(indexPath, animated: false);
    }
    
    
    
    func configureSearchController() {
        // Initialize and perform a minimum configuration to the search controller.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        //searchController.searchBar.frame = CGRect(x: 0, y: 0, width: screen_width, height: 50)
        
        // Place the search bar view to the tableview headerview.
        table_View.tableHeaderView = searchController.searchBar
        //self.search_bar_view.addSubview(searchController.searchBar)
        //self.search_bar_view.bringSubviewToFront(searchController.searchBar)
    }
  
  
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar)
    {
      if searchBar.text != "" {
        text_search = searchBar.text!
      }
      if(text_search != "")
      {
        searchBar.placeholder = text_search
      }else
      {
        searchBar.placeholder = "Search here..."
      }
      DatabaseManager.sharedManager.findTutorialByCategory(text_search, tutorial_category: selected_category) { (response) in
        
        if(!response.isEmpty){
          
          self.tutorial_array = response
          
          self.table_View.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: true)
          //self.table_View.reloadData()
          
          print("Tutorial Count: \(response.count)")
          
        }else{
          
          print("Tutorial not found")
          self.tutorial_array.removeAll()
          self.table_View.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: true)
          print("Tutorial Count: \(self.tutorial_array.count)")
          //self.table_View.reloadData()
        }
        
        // Reload the tableview.
        //self.tableView.reloadData()
        
        dispatch_async(dispatch_get_main_queue(),
                       {
                        self.table_View.reloadData();
        })
        
      }
    }

    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar)
    {
        searchBar.text = text_search
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
      
      if searchBar.text != "" {
        text_search = searchBar.text!
      }
      if(text_search != "")
      {
        searchBar.placeholder = text_search
      }else
      {
        searchBar.placeholder = "Search here..."
      }
      
      DatabaseManager.sharedManager.findTutorialByCategory(text_search, tutorial_category: selected_category) { (response) in
        
        if(!response.isEmpty){
          
          self.tutorial_array = response
          
          self.table_View.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: true)
          //self.table_View.reloadData()
          
          print("Tutorial Count: \(response.count)")
          
        }else{
          
          print("Tutorial not found")
          self.tutorial_array.removeAll()
          self.table_View.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: true)
          print("Tutorial Count: \(self.tutorial_array.count)")
          //self.table_View.reloadData()
        }
        
        // Reload the tableview.
        //self.tableView.reloadData()
        
        dispatch_async(dispatch_get_main_queue(),
                       {
                        self.table_View.reloadData();
        })
        
      }
      
    }
  
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        table_View.reloadData()
      
        searchController.searchBar.resignFirstResponder()
    }
        
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {

        
    }
  
  

  
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        let searchString = searchController.searchBar.text
        text_search = searchString!

      


        //if(searchString == "")
        //{
            DatabaseManager.sharedManager.findTutorialByCategory(searchString!, tutorial_category: selected_category) { (response) in
                
                if(!response.isEmpty){
                    
                    self.tutorial_array = response
                    
                    self.table_View.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: true)
                    //self.table_View.reloadData()
                    
                    print("Tutorial Count: \(response.count)")
                    
                }else{
                    
                    print("Tutorial not found")
                    self.tutorial_array.removeAll()
                    self.table_View.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: true)
                    print("Tutorial Count: \(self.tutorial_array.count)")
                    //self.table_View.reloadData()
                }
                
              dispatch_async(dispatch_get_main_queue(),
                             {
                              self.table_View.reloadData();
              })
                
            }
        //}
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "show_tutorial"
        {
            let csvc = (segue.destinationViewController as! ViewFinishedTutorialViewController)
            csvc.TutorialID = self.tutorial_array[(sender as! Int)].id
            
        }
    }
}
