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
  
  var pickedVideoURL: NSURL?
  
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
    else {
      if pickedVideoURL != nil {
        postVideoToYouTube()
      }
    }
  }
  
  @IBAction func ClickSelectVideoButton(sender: UIButton) {
    videoPicker.allowsEditing = false
    videoPicker.sourceType = .PhotoLibrary
    videoPicker.mediaTypes = [kUTTypeMovie as String]
    presentViewController(videoPicker, animated: true, completion: nil)
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
  }
  
  func imagePickerController(picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String : AnyObject])
  {
    pickedVideoURL = info[UIImagePickerControllerMediaURL] as? NSURL
    
    dismissViewControllerAnimated(true, completion: nil)
    
    let asset:AVAsset = AVAsset(URL: pickedVideoURL!)
    let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
    assetImgGenerate.appliesPreferredTrackTransform = true
    var time: CMTime = asset.duration
    time.value = 0
    
    var imageRef: CGImage?
    do
    {
      imageRef =  try assetImgGenerate.copyCGImageAtTime(time, actualTime: nil)
    }
    catch
    {
      print(error)
    }
    
    let frameImg : UIImage = UIImage(CGImage: imageRef!)
    
    VideoThumbnail.image = frameImg
  }
  
  
  func postVideoToYouTube(){
    
    let urlYoutube = "http://uploads.gdata.youtube.com/feeds/api/users/default/uploads"
    
    print("VideoUrl:\(pickedVideoURL)")
    var videodata: NSData?
    
    do {
      videodata = try NSData(contentsOfFile: (pickedVideoURL!.relativePath!), options: .DataReadingMappedAlways)
    } catch {
      print(error)
    }
    
    print("VideoUrl:\(pickedVideoURL)")
    
    YouTubeManager.sharedManager.postVideoToYouTube(urlYoutube, videoData: videodata!, title: titleTextField_.text!, callback: {(identifier_final, success) in
      
      if(success == false) {
        //self.showErrorMessage("An error occurred while trying to upload a video.")
        print("An error occurred while trying to upload a video.")
        return
      }
      
      self.updateCurrentStruct();
      DatabaseManager.sharedManager.createTutorial(self.current, content:identifier_final) { success, message in
        print("upload-success: \(success), login-message:\(message)")
        if success == true {
          dispatch_async(dispatch_get_main_queue(),{
            
            for viewcontoller in (self.navigationController?.viewControllers)! {
              if(viewcontoller.isKindOfClass(MenuViewController))
              {
                self.navigationController?.popToViewController(viewcontoller, animated: true);
              }
            }
            
          });
        } else {
          dispatch_async(dispatch_get_main_queue(),{
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            
            // Support display in iPad
            alert.popoverPresentationController?.sourceView = self.view
            alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
          });
        }
      }
      
      
    })
    
  }
  
}
