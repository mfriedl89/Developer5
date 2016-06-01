//
//  NewTutorialDescriptonViewController.swift
//  Conari
//
//  Created by Stefan Mitterrutzner on 20/04/16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit
import RichEditorView
import AVFoundation


class NewTutorialDescriptonViewController: UIViewController {
  
  var current:TutorialMetaData = TutorialMetaData(id: 0, OldTitle: "", Title: "",category: 0,duration: 0,difficulty: 0);
  
  var editor:RichEditorView?
  var keyman:KeyboardManager?
  
  let imagePicker = UIImagePickerController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = current.Title
    
    editor = RichEditorView(frame: self.view.bounds)
    editor!.setHTML("<h2>"+current.Title+"</h2>" )
    editor?.delegate = self
    editor?.accessibilityLabel = "texteditor"
    editor?.webView.becomeFirstResponder()
    
    self.view.addSubview(editor!)
    keyman = KeyboardManager(view: self.view)
    keyman?.toolbar.delegate = self
    keyman?.toolbar.editor = editor
    
    imagePicker.delegate = self
    if(UIImagePickerController.isSourceTypeAvailable(.Camera)) {
      imagePicker.sourceType = .Camera
    } else {
      imagePicker.sourceType = .PhotoLibrary
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    keyman?.beginMonitoring()
    handleNetworkError()
  }
  
  override func viewWillDisappear(animated: Bool) {
    keyman?.stopMonitoring()
  }
  
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func SavePressed(sender: AnyObject) {
    
    DatabaseManager.sharedManager.createTutorial(current, content:(editor?.getHTML())!) { success, message in
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
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
  }
}

extension NewTutorialDescriptonViewController: RichEditorDelegate {
  
  func richEditor(editor: RichEditorView, heightDidChange height: Int) { }
  
  func richEditor(editor: RichEditorView, contentDidChange content: String) { }
  
  func richEditorTookFocus(editor: RichEditorView) { }
  
  func richEditorLostFocus(editor: RichEditorView) { }
  
  func richEditorDidLoad(editor: RichEditorView) { }
  
  func richEditor(editor: RichEditorView, shouldInteractWithURL url: NSURL) -> Bool { return false }
  
  func richEditor(editor: RichEditorView, handleCustomAction content: String) { }
  
}

//http://stackoverflow.com/questions/29137488/how-do-i-resize-the-uiimage-to-reduce-upload-image-size
extension UIImage {
  func resizeToWidth(width:CGFloat)-> UIImage {
    let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
    imageView.contentMode = UIViewContentMode.ScaleAspectFit
    imageView.image = self
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
    imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
    let result = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return result
  }
}

extension NewTutorialDescriptonViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      let imageData = UIImageJPEGRepresentation(pickedImage.resizeToWidth(200),0.3)
      let base64String = imageData!.base64EncodedStringWithOptions([])
      editor?.insertImage("data:image/gif;base64,"+base64String, alt: "picture")
    }
    
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
}

extension NewTutorialDescriptonViewController: RichEditorToolbarDelegate {
  
  private func randomColor() -> UIColor {
    let colors = [
      UIColor.redColor(),
      UIColor.orangeColor(),
      UIColor.yellowColor(),
      UIColor.greenColor(),
      UIColor.blueColor(),
      UIColor.purpleColor()
    ]
    
    let color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
    return color
  }
  
  func richEditorToolbarChangeTextColor(toolbar: RichEditorToolbar) {
    let color = randomColor()
    toolbar.editor?.setTextColor(color)
  }
  
  func richEditorToolbarChangeBackgroundColor(toolbar: RichEditorToolbar) {
    let color = randomColor()
    toolbar.editor?.setTextBackgroundColor(color)
  }
  
  func richEditorToolbarInsertImage(toolbar: RichEditorToolbar) {
    
    let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
    
    let Camera = UIAlertAction(title: "Camera", style: .Default, handler: {
      (alert: UIAlertAction!) -> Void in
      if(UIImagePickerController.isSourceTypeAvailable(.Camera))
      {
        self.imagePicker.sourceType = .Camera;
        // Support display in iPad
        self.imagePicker.popoverPresentationController?.sourceView = self.view
        self.imagePicker.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
      }
    })
    
    let Library = UIAlertAction(title: "Photo Library", style: .Default, handler: {
      (alert: UIAlertAction!) -> Void in
      if(UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary))
      {
        self.imagePicker.sourceType = .PhotoLibrary;
        
        // Support display in iPad
        self.imagePicker.popoverPresentationController?.sourceView = self.view
        self.imagePicker.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
 
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
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
}