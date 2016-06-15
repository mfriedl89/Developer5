//
//  UIViewController+Alert.swift
//  Tutorialcloud
//
//  Created on 01.06.16.
//  Copyright © 2016 Developer5. All rights reserved.
//


import UIKit

extension UIViewController {
  
  // MARK: - General
  

  func showAlert(title: String, message: String) {
    showAlert(title, message: message, buttonTitle: "OK")
  }
  

  func showErrorMessage(message: String) {
    showAlert("Error", message: message, buttonTitle: "OK")
  }

  func showAlert(title: String, message: String, buttonTitle: String) {
    showAlert(title, message: message, okAction: (buttonTitle, nil), cancelAction: nil)
  }
  
  func showAlert(title: String,
                 message: String,
                 okAction: (title: String, action: ((UIAlertAction) -> Void)?),
                 cancelAction: (title: String, action: ((UIAlertAction) -> Void)?)?) {
    
    dispatch_async(dispatch_get_main_queue(), {
      
      // Create alert
      let alertController = UIAlertController(title: title,
        message: message,
        preferredStyle: .Alert)
      
      // Add button
      alertController.addAction(UIAlertAction(title: okAction.title, style: .Default, handler: okAction.action))
      
      if let action = cancelAction {
        alertController.addAction(UIAlertAction(title: action.title, style: .Default, handler: action.action))
      }
      
      // Support display in iPad
      alertController.popoverPresentationController?.sourceView = self.view
      alertController.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
      
      self.presentViewController(alertController, animated: true, completion: nil)
    })
    
  }
  
}