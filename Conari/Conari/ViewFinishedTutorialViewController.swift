//
//  ViewFinishedTutorialViewController.swift
//  Tutorialcloud
//
//  Created on 27.04.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import UIKit
import YouTubePlayer

class ViewFinishedTutorialViewController: UIViewController, UIWebViewDelegate, YouTubePlayerDelegate
{
  // MARK: - Members
  var tutorialID = 0
  var content = ""
  var myTutorial: TutorialItem? = nil
  var infoBarButton = UIBarButtonItem()
  
  // MARK: - Outlets
  @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
  @IBOutlet weak var loadingLabel: UILabel!
  @IBOutlet var videoPlayer: YouTubePlayerView!
  @IBOutlet weak var htmlContent: UIWebView!
  
  
  // MARK: - Methods
  override func viewDidLoad()
  {
    super.viewDidLoad()
    self.view.backgroundColor = Constants.viewBackgroundColor
    
    loadIndicator.startAnimating()
    loadIndicator.transform=CGAffineTransformMakeScale(1.5, 1.5)
    self.automaticallyAdjustsScrollViewInsets = false
    
    videoPlayer.hidden = true
    videoPlayer.delegate = self
    
    requestTutorial(tutorialID)
    
    let infoButton = UIButton(type: .InfoLight)
    infoButton.addTarget(self, action: #selector(self.viewAdditionalInformation), forControlEvents: .TouchUpInside)
    infoButton.tintColor = UIColor.whiteColor()
    
    infoBarButton.customView = infoButton
    navigationItem.rightBarButtonItem = infoBarButton
  }
  
  
  
  
  override func viewWillAppear(animated: Bool)
  {
    self.navigationController?.navigationBarHidden = false
    handleNetworkError()
  }
  
  
  
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }
  
  
  
  
  func requestTutorial(tutorialID: Int)
  {
    DatabaseManager.sharedManager.requestTutorial(tutorialID) { tutorial, message in
      
      if (tutorial == nil)
      {
        if message != nil
        {
          self.showErrorMessage(message!)
          
          dispatch_async(dispatch_get_main_queue(), {
            self.title = "Error"
            self.loadIndicator.stopAnimating()
            self.loadingLabel.hidden = true
          })
          
        }
      }
      else
      {
        dispatch_async(dispatch_get_main_queue(), {
          self.title = tutorial!.title
          
          self.content = Constants.cssTextColor + tutorial!.text
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
      htmlContent.loadHTMLString(content, baseURL: nil)
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
  
  
  
  
  func playerReady(videoPlayer: YouTubePlayerView)
  {
    
  }
  
  
  
  
  func playerStateChanged(videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState)
  {
    if (playerState == .Ended) {
      videoPlayer.stop()
    }
  }
  
  
  
  
  func playerQualityChanged(videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality)
  {
    
  }
  
  
  
  
  func viewAdditionalInformation()
  {
    performSegueWithIdentifier("viewAdditionalInformationSegue", sender: infoBarButton)
  }
  
  
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
  {
    if (segue.identifier == "viewAdditionalInformationSegue")
    {
      let navController = segue.destinationViewController as! UINavigationController
      
      if let detailController = navController.topViewController as? ViewAdditionalInformationTableViewController
      {
        if myTutorial != nil
        {
          detailController.tutorial = myTutorial
        }
      }
    }
  }
  
  
}
