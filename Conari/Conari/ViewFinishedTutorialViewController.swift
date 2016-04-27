//
//  ViewFinishedTutorialViewController.swift
//  Conari
//
//  Created by Philipp Preiner on 27.04.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class ViewFinishedTutorialViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    //let url = NSURL (string: "http://www.google.com");
    //let requestObj = NSURLRequest(URL: url!);
    HTMLContent.loadHTMLString("<html><body><p>Hello!</p></body></html>", baseURL: nil)
  }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  @IBOutlet weak var HTMLContent: UIWebView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
