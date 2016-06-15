//
//  AppDelegate+Setup.swift
//  Tutorialcloud
//
//  Created on 01.06.16.
//  Copyright © 2016 Developer5. All rights reserved.
//


import UIKit

extension AppDelegate {
  
  func setupAppearance() {
    // Navigation Bar
    UINavigationBar.appearance().barTintColor = Constants.navigationBarBackgroundColor
    UINavigationBar.appearance().tintColor = Constants.navigationBarTextColor
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: Constants.navigationBarTextColor]
    UINavigationBar.appearance().barStyle = UIBarStyle.BlackTranslucent
    
    // Text Field
    UITextField.appearance().textColor = UIColor.blackColor()
    UITextField.appearance().tintColor = UIColor.blackColor()
    
    
    // Web View
    UIWebView.appearance().opaque = false
    UIWebView.appearance().backgroundColor = UIColor.clearColor()
    
    //Table View
    UITableView.appearance().backgroundColor = Constants.viewBackgroundColor
    
    UITableViewCell.appearance().backgroundColor = Constants.viewBackgroundColor
    UITableViewCell.appearance().textLabel?.textColor = Constants.labelColor
    
    let cellBackgroundView = UIView()
    cellBackgroundView.backgroundColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.0)
    UITableViewCell.appearance().selectedBackgroundView = cellBackgroundView
    
    //Others
    UIButton.appearance().tintColor = Constants.buttonColor
//    UILabel.appearance().textColor = Constants.labelColor
    UIStepper.appearance().tintColor = Constants.buttonColor
  }
  
}