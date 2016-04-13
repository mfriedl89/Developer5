//
//  MetaDataViewController.swift
//  Conari
//
//  Created by Stefan Mitterrutzner on 13/04/16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class MetaDataViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var titleTextField_: UITextField!
    @IBOutlet weak var difficultyLabel_: UILabel!
    @IBOutlet weak var categoryTextField_: UITextField!
    @IBOutlet weak var DifficultyStepper_: UIStepper!
    @IBOutlet weak var DurationTextField_: UITextField!
    var categoryPickerView : UIPickerView!
    var timePickerView : UIPickerView!
    
    
    var categories = ["one", "two", "three", "seven", "fifteen"]
    var times: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DifficultyStepper_.maximumValue = 5
        DifficultyStepper_.minimumValue = 1
        
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
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            categoryTextField_.selectedTextRange = nil;
            
        }else
        {
            DurationTextField_.text = times[row] + " hh:mm"
            
            DurationTextField_.selectedTextRange = nil;
        }
         self.view.endEditing(true)
        //pickerView.hidden = true
    }
    
    
    

}
