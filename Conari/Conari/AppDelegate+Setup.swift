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
    
    //
    UIButton.appearance().tintColor = Constants.buttonColor
    UILabel.appearance().textColor = Constants.labelColor
  }
}