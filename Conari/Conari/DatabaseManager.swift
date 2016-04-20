//
//  DatabaseManager.swift
//  Conari
//
//  Created by Philipp Preiner on 13.04.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import Foundation


/**
 This file will act as our Database manager.
 */
class DatabaseManager {

    /** Singletone instance. */
    static let sharedManager = DatabaseManager()
    var username:String = "3"
    var password:String = "3"
    
    func loginWithPHPScript(username: String, password: String) -> String? {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://citycommerce.net/Login.php")!)
        request.HTTPMethod = "POST"
        let postString = "username=" + username + "&password=" + password
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        var responseString: NSString?
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        }
        task.resume()
        
        return (responseString as? String)
    }
    
    
    func CreateTutorial(metadata: TutorialMetaData, content: String, callback: (Bool, String?) -> ()) {
        

        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://citycommerce.net/Login.php")!)
        request.HTTPMethod = "POST"
        var postString:String = ""
        postString += "username=" + username
        postString += "&password=" + password
        postString += "&title=" + metadata.Title.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        postString += "&category=" + String(metadata.category+1)
        postString += "&difficulty=" + String(metadata.difficulty+1)
        postString += "&duration=" + String(metadata.duration)
        postString += "&text=" + content.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        var success: Bool = false
        var responseString: NSString?
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {data, response, error in
            guard error == nil && data != nil else {
                // check for fundamental networking error
                success = false
                responseString = error?.localizedDescription
                
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                // check for http errors
                success = false
                responseString = "statusCode should be 200, but is \(httpStatus.statusCode) (\(response))"
            }
            
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                if jsonData as! NSObject == 1 {
                    success = true
                }
                if let jsonErrorMessage = jsonData["error_message"] as? NSString {
                    responseString = jsonErrorMessage
                }
                if let jsonSuccess = jsonData["success"] as? Int {
                    success = false
                }
                
            } catch {
                print("error serializing JSON: \(error)")
            }

            
            let message: String? = (responseString as? String)
            
            callback(success, message)
        })
        task.resume()
    }
    
}