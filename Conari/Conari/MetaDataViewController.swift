//
//  MetaDataViewController.swift
//  Conari
//
//  Created by Stefan Mitterrutzner on 13/04/16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

struct TutorialMetaData {
    var Title:String;
    var category:Int;
    var duration:Int;
    var difficulty:Int;
}

class MetaDataViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var titleTextField_: UITextField!
    @IBOutlet weak var difficultyLabel_: UILabel!
    @IBOutlet weak var categoryTextField_: UITextField!
    @IBOutlet weak var DifficultyStepper_: UIStepper!
    @IBOutlet weak var DurationTextField_: UITextField!
    var categoryPickerView : UIPickerView!
    var timePickerView : UIPickerView!
    
    var current:TutorialMetaData = TutorialMetaData(Title: "",category: 0,duration: 0,difficulty: 0)
    
    
    var categories = ["Arts and Entertainment",
                      "Cars & Other Vehicles'",
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
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
    
    func updateCurrentStruct()
    {
        current.Title = titleTextField_.text!
        current.difficulty = Int(DifficultyStepper_.value)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "write_tutorial"
        {
            updateCurrentStruct();
            if current.Title.isEmpty {
                let alert = UIAlertController(title: "Error", message: "Please insert a Title", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                return
            }

            
            let nextScene =  segue.destinationViewController as! NewTutorialDescriptonViewController
            nextScene.current = current
            return

        }
    }
    
    
    

}
