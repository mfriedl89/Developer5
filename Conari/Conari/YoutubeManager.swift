//
//  YoutubeManager.swift
//  Conari
//
//  Created by Stefan Mitterrutzner on 18/05/16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import Foundation

struct YoutubeVideo {
  var title: String
  var thumbnail:String
  var videoId: String
}


/**
 This file will act as our Youutube manager.
 */
class YoutubeManager {
  
  /** Singletone instance. */
  static let sharedManager = YoutubeManager()
  let apiKey = "AIzaSyBkPodgj3cSzd8XYnzEnUBIsonzRx7QaZA"

  
  func searchVideoByTitle(title: String, completionHandler: (response: [YoutubeVideo]) -> Void) -> Void {
    let e_title = title.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
    let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(e_title)&type=video&key=\(apiKey)"
    //urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters()!
    
    // Create a NSURL object based on the above string.
    let targetURL = NSURL(string: urlString)
    let request = NSMutableURLRequest(URL: targetURL!)
    
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {data, response, error in
      guard error == nil && data != nil else {
        // check for fundamental networking error
        print("error=\(error)")
        return
      }
      
      if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
        // check for http errors
        print("statusCode should be 200, but is \(httpStatus.statusCode)")
        print("response = \(response)")
        return
      }
      
      do {
        let resultsDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! Dictionary<NSObject, AnyObject>
        
        var returnArray = [YoutubeVideo]()
        
        // Get all search result items ("items" array).
        let items: Array<Dictionary<NSObject, AnyObject>> = resultsDict["items"] as! Array<Dictionary<NSObject, AnyObject>>
        for item in items
        {
          let snippetDict = item["snippet"] as! Dictionary<NSObject, AnyObject>
          
           let title = snippetDict["title"] as! String
           let thumbnail = ((snippetDict["thumbnails"] as! Dictionary<NSObject, AnyObject>)["default"] as! Dictionary<NSObject, AnyObject>)["url"] as! String
           let videoid = (item["id"] as! Dictionary<NSObject, AnyObject>)["videoId"] as! String
            
          returnArray.append(YoutubeVideo(title: title,thumbnail: thumbnail,videoId: videoid))
        
        }
        completionHandler(response: returnArray)

        
        
        
      } catch {
        print("error serializing JSON: \(error)")
      }
      
    })
    task.resume()

    
  }
  
}