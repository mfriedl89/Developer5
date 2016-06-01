//
//  AppDelegate+Setup.swift
//  Conari
//
//  Created by Philipp Preiner on 01.06.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

extension AppDelegate {
  
  func setupAppearance() {
    // Navigation Bar
    UINavigationBar.appearance().barTintColor = Constants.navigationBarBackgroundColor
    UINavigationBar.appearance().tintColor = Constants.navigationBarTextColor
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: Constants.navigationBarTextColor]
    UINavigationBar.appearance().barStyle = UIBarStyle.BlackTranslucent
    
    //Others
    UIButton.appearance().tintColor = Constants.buttonColor
    UILabel.appearance().textColor = Constants.labelColor
    
    // Text Field
    UITextField.appearance().textColor = UIColor.blackColor()
    UITextField.appearance().tintColor = UIColor.blackColor()
    
    // Web View
    UIWebView.appearance().opaque = false
    UIWebView.appearance().backgroundColor = UIColor.clearColor()
    
    UITableViewCell.appearance().backgroundColor = Constants.viewBackgroundColor
    let cellBackgroundView = UIView()
    cellBackgroundView.backgroundColor = Constants.navigationBarBackgroundColor
    UITableViewCell.appearance().selectedBackgroundView = cellBackgroundView
    
    
}

}