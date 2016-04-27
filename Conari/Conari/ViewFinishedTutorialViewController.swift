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
    
    
    requestTutorial()
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
    
    func requestTutorial(){
        DatabaseManager.sharedManager.requestTutorial(32) { tutorial, message in
            
            if (tutorial == nil){
                self.showErrorMessage(message!)
            }
            else{
                self.HTMLContent.loadHTMLString(tutorial!.text, baseURL: nil)

            }

            

        }
    }
    
    
    func showErrorMessage(message: String) {
        dispatch_async(dispatch_get_main_queue(), {
            //create alert
            let errorAlert = UIAlertController(title: "Error",
                message: message,
                preferredStyle: UIAlertControllerStyle.Alert)
            
            //make button
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            //add buttons
            errorAlert.addAction(okAction)
            
            //display
            self.presentViewController(errorAlert, animated: true, completion: nil)
        })
    }


}
