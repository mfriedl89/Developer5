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
    UINavigationBar.appearance().barTintColor = Constants.navigationBarBackgroundColor
    UINavigationBar.appearance().tintColor = Constants.navigationBarTextColor
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: Constants.navigationBarTextColor]
    UINavigationBar.appearance().barStyle = UIBarStyle.BlackTranslucent
    
    UIButton.appearance().tintColor = Constants.buttonColor
    UILabel.appearance().textColor = Constants.labelColor
    
    UITextField.appearance().textColor = UIColor.blackColor()
    UITextField.appearance().tintColor = UIColor.blackColor()
    UIWebView.appearance().opaque = false
    UIWebView.appearance().backgroundColor = UIColor.clearColor()
    
    UITableViewCell.appearance().backgroundColor = Constants.viewBackgroundColor
    let cellBackgroundView = UIView()
    cellBackgroundView.backgroundColor = Constants.navigationBarBackgroundColor
    UITableViewCell.appearance().selectedBackgroundView = cellBackgroundView
    
    
}

}