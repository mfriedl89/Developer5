//
//  MetaDataViewController.swift
//  Conari
//
//  Created by Stefan Mitterrutzner on 13/04/16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
import AVKit

struct TutorialMetaData {
  var id: Int;
  var OldTitle: String;
  var Title: String;
  var category: Int;
  var duration: Int;
  var difficulty: Int;
}

class MetaDataViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var titleTextField_: UITextField!
  @IBOutlet weak var difficultyLabel_: UILabel!
  @IBOutlet weak var categoryTextField_: UITextField!
  @IBOutlet weak var DifficultyStepper_: UIStepper!
  @IBOutlet weak var DurationTextField_: UITextField!
  
  @IBOutlet weak var SelectVideoButton: UIButton!
  @IBOutlet weak var VideoThumbnail: UIImageView!
  @IBOutlet weak var NextButton: UIBarButtonItem!
  @IBOutlet weak var TutorialTitle: UINavigationItem!

  var current:TutorialMetaData = TutorialMetaData(id: 0, OldTitle: "", Title: "",category: 0,duration: 0,difficulty: 0)

  var categoryPickerView : UIPickerView!
  var timePickerView : UIPickerView!
  let videoPicker = UIImagePickerController()
    
  var categories = ["Arts and Entertainment",
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
  
  var times: [String] = []
  
  var TextOrVideo: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
        
    if TextOrVideo == 1 {
      TutorialTitle.title = "Video Tutorial"
      NextButton.title = "Upload"
    }
    else{
      TutorialTitle.title = "Text Tutorial"
      SelectVideoButton.hidden = true
      VideoThumbnail.hidden = true
    }
    
    DifficultyStepper_.maximumValue = 5
    DifficultyStepper_.minimumValue = 1
    DifficultyStepper_.value = 1
    difficultyLabel_.text = "very easy";
    
    current.duration = 5
    
    categoryPickerView = UIPickerView()
    categoryPickerView.delegate = self
    categoryTextField_.inputView = categoryPickerView
    categoryTextField_.text = categories[0]
    categoryTextField_.selectedTextRange = nil;
    
    for hour in 0...10 {
      for minute in 0...11 {
        times.append(String(format: "%02d:%02d",hour,minute*5))
      }
    }
    
    timePickerView = UIPickerView()
    timePickerView.delegate = self
    DurationTextField_.inputView = timePickerView
    DurationTextField_.text = times[1] + " hh:mm"
    DurationTextField_.selectedTextRange = nil;
    
    titleTextField_.delegate = self
    
    videoPicker.delegate = self
  }
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBarHidden = false
    
    handleNetworkError()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    if (textField == titleTextField_) {
      titleTextField_.resignFirstResponder()
    }
    
    return true
  }
    
  @IBAction func ClickNext(sender: AnyObject) {
    if (TextOrVideo == 0)
    {
      performSegueWithIdentifier("write_tutorial", sender: nil)
    }
  }
      
  @IBAction func ClickSelectVideoButton(sender: UIButton) {
    let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
    
    let Camera = UIAlertAction(title: "Camera", style: .Default, handler: {
      (alert: UIAlertAction!) -> Void in
      if(UIImagePickerController.isSourceTypeAvailable(.Camera))
      {
        self.videoPicker.allowsEditing = true
        self.videoPicker.sourceType = .Camera
        self.videoPicker.mediaTypes = [kUTTypeMovie as String]
        self.presentViewController(self.videoPicker, animated: true, completion: nil)

      }
    })
    
    let Library = UIAlertAction(title: "Photo Library", style: .Default, handler: {
      (alert: UIAlertAction!) -> Void in
      if(UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary))
      {
        self.videoPicker.allowsEditing = true
        self.videoPicker.sourceType = .PhotoLibrary
        self.videoPicker.mediaTypes = [kUTTypeMovie as String]
        self.presentViewController(self.videoPicker, animated: true, completion: nil)

      }
    })
    
    let cancel = UIAlertAction(title: "Cancel", style: .Default, handler: {
      (alert: UIAlertAction!) -> Void in
    })
    
    // 4
    if(UIImagePickerController.isSourceTypeAvailable(.Camera)) {
      optionMenu.addAction(Camera)
    }
    
    if(UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)) {
      optionMenu.addAction(Library)
    }
    
    optionMenu.addAction(cancel)
    
    // Support display in iPad
    optionMenu.popoverPresentationController?.sourceView = self.view
    optionMenu.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
    
    self.presentViewController(optionMenu, animated: true, completion: nil)
    
    
  }
  
  @IBAction func DifficultyValueChanged_(sender: AnyObject) {
    
    switch DifficultyStepper_.value {
    case 5:
      difficultyLabel_.text = "very hard";
    case 4:
      difficultyLabel_.text = "hard";
    case 3:
      difficultyLabel_.text = "medium";
    case 2:
      difficultyLabel_.text = "easy";
    case 1:
      difficultyLabel_.text = "very easy";
    default:
      return;
    }
    updateCurrentStruct();
  }
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView == categoryPickerView{
      return categories.count
    } else {
      return times.count
    }
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView == categoryPickerView{
      return categories[row]
    } else {
      return times[row]
    }
  }
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView == categoryPickerView{
      categoryTextField_.text = categories[row]
      current.category = row;
      categoryTextField_.selectedTextRange = nil;
    } else {
      current.duration = row*5
      DurationTextField_.text = times[row] + " hh:mm"
      
      DurationTextField_.selectedTextRange = nil;
    }
    
    self.view.endEditing(true)
    updateCurrentStruct()
  }
  
  func updateCurrentStruct() {
    current.Title = titleTextField_.text!
    current.difficulty = Int(DifficultyStepper_.value)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    updateCurrentStruct();
    if current.Title.isEmpty {
      let alert = UIAlertController(title: "Error", message: "Please insert a Title", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
      
      // Support display in iPad
      alert.popoverPresentationController?.sourceView = self.view
      alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)

      self.presentViewController(alert, animated: true, completion: nil)
      return
    }
    
    if segue.identifier == "write_tutorial"
    {
      let nextScene =  segue.destinationViewController as! NewTutorialDescriptonViewController
      nextScene.current = current
      return
      }
//    else
//    {
    
    
    
//      let nextScene =  segue.destinationViewController as! VideoSelectorViewController
//      nextScene.current = current
//      return
//    }
  }
  
  func imagePickerController(picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String : AnyObject])
  {
    let pickedVideoURL = info[UIImagePickerControllerMediaURL] as! NSURL
    
    dismissViewControllerAnimated(true, completion: nil)
    
    
//    let asset:AVAsset = AVAsset(URL: pickedVideoURL)
//    let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
//    assetImgGenerate.appliesPreferredTrackTransform = true
//    var time: CMTime = asset.duration
//    time.value = 0
//    
//    var imageRef: CGImage?
//    do
//    {
//      imageRef =  try assetImgGenerate.copyCGImageAtTime(time, actualTime: nil)
//    }
//    catch
//    {
//      print(error)
//    }
//    r
//    let frameImg : UIImage = UIImage(CGImage: imageRef!)
//    
//    VideoThumbnail.image = frameImg
    
    let player = AVPlayer(URL: pickedVideoURL)
    let playerController = AVPlayerViewController()
    playerController.player = player
    playerController.showsPlaybackControls = true
    playerController.view.frame = VideoThumbnail.frame
    playerController.view.layer.zPosition = 1;
    
    self.addChildViewController(playerController);
    self.view.addSubview(playerController.view);
    player.play()

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
