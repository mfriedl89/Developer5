//
//  ViewFinishedTutorialViewController.swift
//  Conari
//
//  Created by Philipp Preiner on 27.04.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit
import YouTubePlayer

class ViewFinishedTutorialViewController: UIViewController, UIWebViewDelegate, YouTubePlayerDelegate {
  
  var tutorialID = 0
  var content = ""
  
  var myTutorial: Tutorial_item? = nil
  
  @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
  @IBOutlet weak var loadingLabel: UILabel!
  
  @IBOutlet weak var HTMLContent: UIWebView!
  @IBOutlet var videoPlayer: YouTubePlayerView!
  
  var infoBarButton = UIBarButtonItem()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadIndicator.startAnimating()
    loadIndicator.transform=CGAffineTransformMakeScale(1.5, 1.5)
    
    self.automaticallyAdjustsScrollViewInsets = false
    
    videoPlayer.hidden = true
    videoPlayer.delegate = self
    
    requestTutorial(tutorialID)
    
    // Info Button
    let infoButton = UIButton(type: .InfoLight)
    infoButton.addTarget(self, action: #selector(self.viewAdditionalInformation), forControlEvents: .TouchUpInside)
    infoBarButton.customView = infoButton
    navigationItem.rightBarButtonItem = infoBarButton
  }
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBarHidden = false
    handleNetworkError()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func requestTutorial(tutorialID: Int) {
    DatabaseManager.sharedManager.requestTutorial(tutorialID) { tutorial, message in
      
      if (tutorial == nil) {
        if message != nil {
          self.showErrorMessage(message!)
          
          dispatch_async(dispatch_get_main_queue(), {
            self.title = "Error"
            self.loadIndicator.stopAnimating()
            self.loadingLabel.hidden = true
          })
          
        }
      }
      else {
        dispatch_async(dispatch_get_main_queue(), {
          self.title = tutorial!.title
          
          self.content = tutorial!.text
          self.setContent()
        })
      }
    }
  }
  
  func setContent() {
    loadIndicator.stopAnimating()
    loadingLabel.hidden = true
    
    let videoID = YouTubeManager.sharedManager.parseIdentifier(content)
    
    if videoID == nil {
      HTMLContent.loadHTMLString(content, baseURL: nil)
    }
    else {
      loadIndicator.stopAnimating()
      loadingLabel.hidden = true
      
      videoPlayer.hidden = false
      videoPlayer.loadVideoID(videoID!)
    }
  }
  
  func webViewDidFinishLoad(webView: UIWebView) {
    loadIndicator.stopAnimating()
    loadingLabel.hidden = true
  }
  
  func playerReady(videoPlayer: YouTubePlayerView) {
    
  }
  
  func playerStateChanged(videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
    if (playerState == .Ended) {
      videoPlayer.stop()
    }
  }
  
  func playerQualityChanged(videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
    
  }
  
  func viewAdditionalInformation() {
    performSegueWithIdentifier("viewAdditionalInformationSegue", sender: infoBarButton)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if (segue.identifier == "viewAdditionalInformationSegue") {
      let navController = segue.destinationViewController as! UINavigationController
      
      if let detailController = navController.topViewController as? ViewAdditionalInformationTableViewController {
        
        if myTutorial != nil {
          detailController.tutorial = myTutorial
        }
      }
    }
  }

}
