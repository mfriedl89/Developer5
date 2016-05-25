//
//  TutorialEditOptionsController.swift
//  Conari
//
//  Created by Markus Schofnegger on 11/05/16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class TutorialEditOptionsController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {
  @IBOutlet weak var categoryTextField_: UITextField!
  @IBOutlet weak var DurationTextField_: UITextField!
  @IBOutlet weak var titleTextField_: UITextField!
  @IBOutlet weak var difficultyLabel_: UILabel!
  @IBOutlet weak var DifficultyStepper_: UIStepper!
  
  var categoryPickerView : UIPickerView!
  var timePickerView : UIPickerView!
  
  var oldTitle : String?
  var oldCategory : String?
  
  var editTutorial : Tutorial?
  var editTutorialText: String?
  var editTutorialId: String?
  
  var current:TutorialMetaData = TutorialMetaData(id: 0, OldTitle: "", Title: "",category: 0,duration: 0,difficulty: 0)
  
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
  
  var difficultLabels = ["very easy",
                         "easy",
                         "medium",
                         "hard",
                         "very hard"]
  
  var times: [String] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    DifficultyStepper_.maximumValue = 5
    DifficultyStepper_.minimumValue = 1
    DifficultyStepper_.value = Double(self.editTutorial!.difficulty)!
    difficultyLabel_.text = self.difficultLabels[Int(self.editTutorial!.difficulty)! - 1];
    
    current.duration = 5
    
    categoryPickerView = UIPickerView()
    categoryPickerView.delegate = self
    categoryTextField_.inputView = categoryPickerView
    categoryTextField_.text = categories[0]
    categoryTextField_.selectedTextRange = nil
    
    for hour in 0...10 {
      for minute in 0...11 {
        times.append(String(format: "%02d:%02d",hour,minute*5))
      }
    }
    
    timePickerView = UIPickerView()
    timePickerView.delegate = self
    DurationTextField_.inputView = timePickerView
    DurationTextField_.text = times[0] + " hh:mm"
    DurationTextField_.selectedTextRange = nil
    
    titleTextField_.delegate = self
    
    // Set OldTitle of struct
    self.current.OldTitle = self.oldTitle!
    
    // Set title field
    //        self.titleTextField_.text = self.oldTitle
    self.titleTextField_.text = self.editTutorial!.title
    
    // Set category field
    self.categoryTextField_.text = self.oldCategory
    
    let minute = Int(self.editTutorial!.duration)! % 60
    let hour = Int(self.editTutorial!.duration)! / 60
    self.DurationTextField_.text = String(format: "%02d:%02d",hour,minute) + " hh:mm"
  }
  
  override func viewWillAppear(animated: Bool) {
    //        self.navigationController?.navigationBarHidden = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    if (textField == titleTextField_) {
      titleTextField_.resignFirstResponder()
    }
    return true
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  // Maybe needed
  func showErrorMessage(message: String) {
    dispatch_async(dispatch_get_main_queue(), {
      //create alert
      let errorAlert = UIAlertController(title: "Error",
        message: message,
        preferredStyle: UIAlertControllerStyle.Alert)
      
      //make button
      let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
      
      //add buttons
      errorAlert.addAction(okAction)
      
      //display
      self.presentViewController(errorAlert, animated: true, completion: nil)
    })
  }
  
  func updateCurrentStruct()
  {
    current.Title = titleTextField_.text!
    current.difficulty = Int(DifficultyStepper_.value)
  }
  
  @IBAction func DifficultyValueChanged_(sender: AnyObject) {
    switch DifficultyStepper_.value {
    case 5:
      difficultyLabel_.text = "very hard";
      break;
    case 4:
      difficultyLabel_.text = "hard";
      break;
    case 3:
      difficultyLabel_.text = "medium";
      break;
    case 2:
      difficultyLabel_.text = "easy";
      break;
    case 1:
      difficultyLabel_.text = "very easy";
      break;
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
    }else
    {
      return times.count
    }
    
  }
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView == categoryPickerView{
      return categories[row]
    }else
    {
      return times[row]
    }
    
  }
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView == categoryPickerView{
      categoryTextField_.text = categories[row]
      current.category = row;
      categoryTextField_.selectedTextRange = nil;
      
    }else
    {
      current.duration = row*5
      DurationTextField_.text = times[row] + " hh:mm"
      
      DurationTextField_.selectedTextRange = nil;
    }
    self.view.endEditing(true)
    updateCurrentStruct();
    //pickerView.hidden = true
  }
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "edit_tutorial"
    {
      updateCurrentStruct();
      if current.Title.isEmpty {
        self.showErrorMessage("Please insert a Title")
        return
      }
      
      
      let nextScene =  segue.destinationViewController as! TutorialEditContentController
      nextScene.current = current
      nextScene.currentText = (editTutorial?.text)!.stringByReplacingOccurrencesOfString("\\\"", withString: "\"")
      nextScene.currentId = self.editTutorialId
      
      return
    }
  }
  
}