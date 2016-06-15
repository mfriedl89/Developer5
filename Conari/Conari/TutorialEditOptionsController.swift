//
//  TutorialEditOptionsController.swift
//  Tutorialcloud
//
//  Created on 11.05.16.
//  Copyright © 2016 Developer5. All rights reserved.
//

import UIKit

class TutorialEditOptionsController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {
  
  // MARK: - Members
  var categoryPickerView : UIPickerView!
  var timePickerView : UIPickerView!
  var oldTitle : String?
  var oldCategory : String?
  var editTutorial : Tutorial?
  var editTutorialText: String?
  var editTutorialId: String?
  var current:TutorialMetaData = TutorialMetaData(id: 0, OldTitle: "", Title: "",category: 0,duration: 0,difficulty: 0)
  
  
  // MARK: - Outlets
  @IBOutlet weak var categoryTextField: UITextField!
  @IBOutlet weak var durationTextField: UITextField!
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var difficultyLabel: UILabel!
  @IBOutlet weak var difficultyStepper: UIStepper!
  

  // MARK: - category, difficulty and time definitions
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
  
  
  
  
  // MARK: - Methods
  override func viewDidLoad()
  {
    super.viewDidLoad()
    self.view.backgroundColor = Constants.viewBackgroundColor
    
    difficultyStepper.maximumValue = 5
    difficultyStepper.minimumValue = 1
    difficultyStepper.value = Double(self.editTutorial!.difficulty)!
    difficultyLabel.text = self.difficultLabels[Int(self.editTutorial!.difficulty)! - 1];
    
    current.duration = 5
    
    categoryPickerView = UIPickerView()
    categoryPickerView.delegate = self
    categoryTextField.inputView = categoryPickerView
    categoryTextField.text = categories[0]
    categoryTextField.selectedTextRange = nil
    
    for hour in 0...10
    {
      for minute in 0...11
      {
        times.append(String(format: "%02d:%02d",hour,minute*5))
      }
    }
    
    timePickerView = UIPickerView()
    timePickerView.delegate = self
    durationTextField.inputView = timePickerView
    durationTextField.text = times[0] + " hh:mm"
    durationTextField.selectedTextRange = nil
    
    titleTextField.delegate = self
    
    self.current.OldTitle = self.oldTitle!
    self.titleTextField.text = self.editTutorial!.title
    self.categoryTextField.text = self.oldCategory
    let minute = Int(self.editTutorial!.duration)! % 60
    let hour = Int(self.editTutorial!.duration)! / 60
    self.durationTextField.text = String(format: "%02d:%02d",hour,minute) + " hh:mm"
  }
  
  
  
  
  override func viewWillAppear(animated: Bool)
  {
    handleNetworkError()
  }
  
  
  
  
  func textFieldShouldReturn(textField: UITextField) -> Bool
  {
    if (textField == titleTextField)
    {
      titleTextField.resignFirstResponder()
    }
    return true
  }
  
  
  
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
  {
    self.view.endEditing(true)
  }
  
  
  
  
  func updateCurrentStruct()
  {
    current.Title = titleTextField.text!
    current.difficulty = Int(difficultyStepper.value)
  }
  
  
  
  
  @IBAction func DifficultyValueChanged_(sender: AnyObject)
  {
    switch difficultyStepper.value
    {
    case 5:
      difficultyLabel.text = "very hard";
      
    case 4:
      difficultyLabel.text = "hard";
      
    case 3:
      difficultyLabel.text = "medium";
      
    case 2:
      difficultyLabel.text = "easy";
      
    case 1:
      difficultyLabel.text = "very easy";
      
    default:
      return;
    }
    
    updateCurrentStruct();
  }
  
  
  
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
  {
    return 1
  }
  
  
  
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
  {
    if pickerView == categoryPickerView
    {
      return categories.count
    }
    else
    {
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
  
  
  
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
  {
    if pickerView == categoryPickerView
    {
      categoryTextField.text = categories[row]
      current.category = row;
      categoryTextField.selectedTextRange = nil;
      
    }
    else
    {
      current.duration = row * 5
      durationTextField.text = times[row] + " hh:mm"
      durationTextField.selectedTextRange = nil;
    }
    self.view.endEditing(true)
    updateCurrentStruct();
  }
  
  
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
  {
    if segue.identifier == "edit_tutorial"
    {
      updateCurrentStruct();
      if current.Title.isEmpty
      {
        self.showErrorMessage("Please insert a Title")
        return
      }
      
      let nextScene =  segue.destinationViewController as! TutorialEditContentController
      nextScene.current = current
      nextScene.currentText = (editTutorial?.text)!.stringByReplacingOccurrencesOfString("\\\"", withString: "\"")
      nextScene.currentID = self.editTutorialId
      
      return
    }
  }
  
}