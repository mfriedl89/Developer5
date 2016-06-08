//
//  Constants.swift
//  Conari
//
//  Created by Philipp Preiner on 04.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import Foundation
import UIKit

/**
 Global constants class of the project.
 */
class Constants {
  
  // MARK: - Appearance Colors
  
  static let navigationBarBackgroundColor = UIColor(red: 0.25, green: 0.04, blue: 0.40, alpha: 1.00)

  static let navigationBarTextColor = UIColor.whiteColor()
  
  static let buttonColor = UIColor(red:0.57, green:0.10, blue:0.75, alpha:1.0)

  static let labelColor = UIColor.blackColor()
  
  static let viewBackgroundColor = UIColor.whiteColor()
  
  static let contentBackgroundColor = UIColor(red: 0.45, green: 0.24, blue: 0.81, alpha: 1.00)
  
  static let welcomeScreenBackgroundLila = UIColor(red:0.55, green:0.18, blue:0.84, alpha:1.0)
  
  static let welcomeScreenBackgroundBlue = UIColor(red:0.37, green:0.53, blue:0.92, alpha:1.0)

  static let cssTextColor = "<style>body{color: black;}</style>"
  
  
  static func setRadiusWithColor(color: UIColor, forButton: UIButton) -> Void {
    let cornerRadius : CGFloat = 15
    let borderWith : CGFloat = 1
    let borderColor = color.CGColor
    
    forButton.layer.cornerRadius = cornerRadius
    forButton.layer.borderWidth = borderWith
    forButton.layer.borderColor = borderColor
    
  }
}