//
//  YouTubeManager.swift
//  Conari
//
//  Created by Philipp Preiner on 11.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import Foundation

/**
 This file will act as our YouTube manager.
 */
class YouTubeManager {
  
  /** Singletone instance. */
  static let sharedManager = YouTubeManager()
  
  static let apiKey = "AIzaSyBkPodgj3cSzd8XYnzEnUBIsonzRx7QaZA"
  static let channelID = "UCTwXFSPFmBofWhl71T85WNQ"
  let identifier = "ConariYouTubeTutorial - apiKey: " + apiKey + ", videoID: "
  
  func parseIdentifier(input: String) -> String? {
    let seperator = "videoID: "
    
    if input.containsString(identifier) {
      let videoID = input.componentsSeparatedByString(seperator)
      return videoID.last
    }
    
    return nil;
  }
  
}