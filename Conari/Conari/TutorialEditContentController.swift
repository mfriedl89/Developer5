//
//  TutorialEditOptionsController.swift
//  Conari
//
//  Created by Markus Schofnegger on 11/05/16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit
import RichEditorView
import AVFoundation

class TutorialEditContentController: UIViewController, RichEditorDelegate, RichEditorToolbarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var current:TutorialMetaData = TutorialMetaData(id: 0, OldTitle: "", Title: "",category: 0,duration: 0,difficulty: 0);
    var currentText: String?
    
    var editor:RichEditorView?
    var keyman:KeyboardManager?
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = current.Title
        
        editor = RichEditorView(frame: self.view.bounds)
        editor!.setHTML("<h2>"+current.Title+"</h2>" )
        editor?.delegate = self
        editor?.accessibilityLabel = "texteditor"
        editor?.webView.becomeFirstResponder()
        editor?.setHTML(currentText!)
        
        self.view.addSubview(editor!)
        keyman = KeyboardManager(view: self.view)
        keyman?.toolbar.delegate = self
        keyman?.toolbar.editor = editor
        
        imagePicker.delegate = self
        if(UIImagePickerController.isSourceTypeAvailable(.Camera))
        {
            imagePicker.sourceType = .Camera
        }else
        {
            imagePicker.sourceType = .PhotoLibrary
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    @IBAction func savePressed(sender: AnyObject) {
        DatabaseManager.sharedManager.EditTutorial(current, content:(editor?.getHTML())!) { success, message in
            print("upload-success: \(success), login-message:\(message)")
            if success == true
            {
                
                print("sucess");
                dispatch_async(dispatch_get_main_queue(),{
                    
                    for viewcontoller in (self.navigationController?.viewControllers)!
                    {
                        if(viewcontoller.isKindOfClass(AdminTutorialViewController))
                        {
                            self.navigationController?.popToViewController(viewcontoller, animated: true);
                        }
                    }
                    
                });
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(),{
                    let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                });
            }
        }
    }
    
}

