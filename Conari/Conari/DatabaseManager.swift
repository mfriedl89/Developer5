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
    
    func loginWithPHPScript(username: String, password: String, callback: (Bool, String?) -> ()) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://citycommerce.net/Login.php")!)
        request.HTTPMethod = "POST"
        let postString = "username=" + username + "&password=" + password
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        var success: Bool = false
        var responseString: NSString?
        var successValue = 0

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
                    successValue = 1;
                    success = true
                }
                if let jsonErrorMessage = jsonData["error_message"] as? NSString {
                    responseString = jsonErrorMessage
                }
                if let jsonSuccess = jsonData["success"] as? Int {
                    successValue = jsonSuccess
                    success = false
                }
                
            } catch {
                print("error serializing JSON: \(error)")
            }
            
            //responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
//            print("success \(success)")
//            
//            print("responseString = \(responseString)")
            
            let message: String? = (responseString as? String)
            
            callback(success, message)
        })
        task.resume()
    }
    
    func login(username: String, password: String) -> (Bool, String) {
        var retValue:(Bool, String) = (false, "")
        
        loginWithPHPScript(username, password: password) { success, message in
            print("login-success: \(success), login-message:\(message)")
            retValue = (success, message!)
        }
        
        return retValue
    }
}