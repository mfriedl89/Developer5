//
//  UIViewController+ErrorHandling.swift
//  Conari
//
//  Created by Philipp Preiner on 01.06.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

extension UIViewController {
  
  /**
   This method checks for internet connection and handles the possible error.
   */
  func handleNetworkError() {
    let connectionStatus = Reach().connectionStatus()
    
    switch connectionStatus {
    case .Unknown, .Offline:
      showErrorMessage("The Internet connection appears to be offline!")
      
    case .Online(.WWAN), .Online(.WiFi):
      break
    }
  }
  
}