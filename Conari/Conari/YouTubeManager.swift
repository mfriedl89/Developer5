//
//  YouTubeManager.swift
//  Conari
//
//  Created by Philipp Preiner on 11.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import Foundation
import Alamofire

struct YoutubeVideo {
  var title: String
  var thumbnail:String
  var videoId: String
}

/**
 This file will act as our YouTube manager.
 */
class YouTubeManager {
  
  /** Singletone instance. */
  static let sharedManager = YouTubeManager()
  
  var apiKey = "AIzaSyBkPodgj3cSzd8XYnzEnUBIsonzRx7QaZA"
  var channelID = "UCTwXFSPFmBofWhl71T85WNQ"
  var searchApiUrl = "https://www.googleapis.com/youtube/v3/search"
  var identifier = "ConariYouTubeTutorial - apiKey: " + "AIzaSyBkPodgj3cSzd8XYnzEnUBIsonzRx7QaZA" + ", videoID: "
  
  
  func parseIdentifier(input: String) -> String? {
    let seperator = "videoID: "
    
    if input.containsString(self.identifier) {
      let videoID = input.componentsSeparatedByString(seperator)
      return videoID.last
    }
    
    return nil;
  }
  
  func searchVideoByTitle(title: String, completionHandler: (response: [YoutubeVideo], success:Bool, messagge:String) -> Void) -> Void {
    let eTitle = title.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
    let urlString = searchApiUrl+"?part=snippet&q=\(eTitle)&type=video&key=\(apiKey)"
    //urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters()!
    
    // Create a NSURL object based on the above string.
    let targetURL = NSURL(string: urlString)
    let request = NSMutableURLRequest(URL: targetURL!)
    var returnArray = [YoutubeVideo]()
    
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {data, response, error in
      guard error == nil && data != nil else {
        // check for fundamental networking error
        completionHandler(response: returnArray, success: false, messagge: "error=\(error)")
        
        return
      }
      
      if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
        completionHandler(response: returnArray, success: false, messagge: "response = \(response)")
        return
      }
      
      do {
        let resultsDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! Dictionary<NSObject, AnyObject>
        
        
        
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
        completionHandler(response: returnArray, success: true, messagge: "")
        
        
        
        
      } catch {
        completionHandler(response: returnArray, success: false, messagge: "error serializing JSON: \(error)")
      }
      
    })
    task.resume()
  }
  
  func postVideoToYouTube(uploadUrl: String, videoData: NSData, title: String, callback: (String, Bool) -> ()){
    
    DatabaseManager.sharedManager.getAccessToken({accessToken in
      
      if(accessToken == "Error") {
        return
      }
      
      let headers = ["Authorization": "Bearer \(accessToken!)"]
      upload(
        .POST,
        "https://www.googleapis.com/upload/youtube/v3/videos?part=snippet",
        headers: headers,
        multipartFormData: { multipartFormData in
          multipartFormData.appendBodyPart(data:"{'snippet':{'title' : '\(title)', 'description': 'This video was uploaded using Mr Tutor.'}}".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name: "snippet", mimeType: "application/json")
          multipartFormData.appendBodyPart(data: videoData, name: "video", fileName: "sample.mp4", mimeType: "application/octet-stream")
        },
        encodingCompletion: { encodingResult in
          switch encodingResult {
          case .Success(let upload, _, _):
            upload.responseJSON { response in
              
              do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments)
                
                let videoID = jsonData["id"] as! String
                let identifierFinal = self.identifier + videoID
                callback(identifierFinal, true)
                
              } catch {
                print("error serializing JSON: \(error)")
                callback("", false)
              }
              
              print("Success")
            }
          case .Failure(_):
            print("Failure")
            callback("", false)
          }
      })
      
      
    })
  }
  
}