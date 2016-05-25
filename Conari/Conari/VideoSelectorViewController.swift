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
  
  
}


