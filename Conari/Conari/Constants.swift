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
  
  static let buttonColor = UIColor(red:0.55, green:0.18, blue:0.84, alpha:1.0)

  static let labelColor = UIColor.blackColor()
  
  static let viewBackgroundColor = UIColor.whiteColor()
  
  static let lightBackgroundColor = UIColor(red:0.55, green:0.18, blue:0.84, alpha:1.0)
  
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
  
  static func setGradientColor(view: UIView) -> Void {
    let gradient: CAGradientLayer = CAGradientLayer()
    gradient.frame = view.bounds
    gradient.colors = [Constants.welcomeScreenBackgroundLila.CGColor, Constants.welcomeScreenBackgroundBlue.CGColor]
    view.layer.insertSublayer(gradient, atIndex: 0)
  }
  
  static func setTextFieldForLogin(textField: UITextField) -> Void {
    textField.backgroundColor = UIColor.clearColor()
    let border = CALayer()
    let width = CGFloat(2.0)
    border.borderColor = UIColor.whiteColor().CGColor
    border.frame = CGRect(x: 0, y: textField.frame.size.height - width,
                          width: textField.frame.size.width,
                          height: textField.frame.size.height)
    
    border.borderWidth = width
    textField.layer.addSublayer(border)
    textField.layer.masksToBounds = true
    
    textField.textColor = UIColor.whiteColor()
    textField.tintColor = UIColor.whiteColor()
  
  }
  
}