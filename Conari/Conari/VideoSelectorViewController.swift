//
//  VideoSelectorViewController.swift
//  Conari
//
//  Created by Hildebrand on 25.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit
import RichEditorView
import AVFoundation
import MobileCoreServices


class VideoSelectorViewController: UIViewController, UIImagePickerControllerDelegate,
  UINavigationControllerDelegate{
  
  let imagePicker = UIImagePickerController()
  
  var current:TutorialMetaData = TutorialMetaData(id: 0, OldTitle: "", Title: "",category: 0,duration: 0,difficulty: 0);
 
  @IBAction func ClickSelectVideo(sender: AnyObject) {
    
    imagePicker.allowsEditing = false
    imagePicker.sourceType = .PhotoLibrary
    imagePicker.mediaTypes = [kUTTypeMovie as String]
    presentViewController(imagePicker, animated: true, completion: nil)
    
  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    self.title = current.Title
    imagePicker.delegate = self
  }
  
  
  func imagePickerController(picker: UIImagePickerController,
      didFinishPickingMediaWithInfo info: [String : AnyObject])
  {
    let pickedVideoURL = info[UIImagePickerControllerReferenceURL] as! NSURL
    
    let alert = UIAlertController(title: "Error", message: pickedVideoURL.absoluteString, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)
    return
  }

  
 /* func postVideoToYouTube(token: String, callback: Bool -> Void){
    
    let headers = ["Authorization": "Bearer \(token)"]
    let urlYoutube = "https://www.googleapis.com/upload/youtube/v3/videos?part=id"
    
    let path = NSBundle.mainBundle().pathForResource("video", ofType: "mp4")
    let videodata: NSData = NSData.dataWithContentsOfMappedFile(path!)! as! NSData
    upload(
      .POST,
      urlYoutube,
      headers: headers,
      multipartFormData: { multipartFormData in
        multipartFormData.appendBodyPart(data: videodata, name: "video", fileName: "video.mp4", mimeType: "application/octet-stream")
      },
      encodingCompletion: { encodingResult in
        switch encodingResult {
        case .Success(let upload, _, _):
          upload.responseJSON { request, response, error in
            print(response)
            callback(true)
          }
        case .Failure(_):
          callback(false)
        }
    })
  }*/
  
}


