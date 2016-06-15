//
//  AcknowledgementsViewController.swift
//  Tutorial Cloud
//
//  Created on 15.06.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class AcknowledgementsViewController: UIViewController {
  
  @IBOutlet var WebView: UIWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationBar()
    setupWebView()
  }
  
  // MARK: - Setup
  
  private func setupNavigationBar() {
    self.title = "Acknowledgements"
  }
  
  private func setupWebView() {
    let url = NSBundle.mainBundle().URLForResource("Acknowledgements", withExtension:"html")
    let requestObject = NSURLRequest(URL: url!)
    WebView.loadRequest(requestObject)
  }
}
