//
//  DatabaseManager.swift
//  Conari
//
//  Created by Philipp Preiner on 13.04.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import Foundation


/*struct Tutorial {
    var title: String
    var category: Int
    var difficulty: String
    var duration: String
    var text: String
    var author: String
}*/

class Tutorial_item {
    
    var id          : Int
    var title       : String
    var category    : Int
    var difficulty  : String
    var duration    : String
    
    init(tut_id: Int, tut_title: String, tut_category : Int, tut_difficulty : String, tut_duration : String ){
        self.id     = tut_id
        self.title  = tut_title
        self.category   = tut_category
        self.difficulty = tut_difficulty
        self.duration   = tut_duration
    }
    
}

/**
 This file will act as our Database manager.
 */
class DatabaseManager {

    /** Singletone instance. */
    static let sharedManager = DatabaseManager()
    
    var username: String = ""
    var password: String = ""
    
    func loginWithPHPScript(username: String, password: String, callback: (Bool, String?) -> ()) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.wullschi.com/conari/Login.php")!)
        request.HTTPMethod = "POST"
        let postString = "username=" + username + "&password=" + password
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        var success: Bool = false
        var responseString: NSString?
        //var successValue = 0

        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {data, response, error in
            guard error == nil && data != nil else {
                // check for fundamental networking error
                success = false
                let message: String? = error?.localizedDescription
                callback(success, message)

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
                    //successValue = 1;
                    self.username = username
                    self.password = password
                    success = true
                }
                if let jsonErrorMessage = jsonData["error_message"] as? NSString {
                    responseString = jsonErrorMessage
                }
                if (jsonData["success"] != nil) {
                    //successValue = jsonSuccess
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
    
    
    func CreateTutorial(metadata: TutorialMetaData, content: String, callback: (Bool, String?) -> ()) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.wullschi.com/conari/CreateTutorial.php")!)
        request.HTTPMethod = "POST"
        var postString:String = ""
        postString += "username=" + username
        postString += "&password=" + password
        postString += "&title=" + metadata.Title.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        postString += "&category=" + String(metadata.category+1)
        postString += "&difficulty=" + String(metadata.difficulty+1)
        postString += "&duration=" + String(metadata.duration)
        let allowedCharacters = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet
        allowedCharacters.removeCharactersInString("+/=")
        postString += "&text=" + content.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)! as String!
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
            
            //print("response = \(response)")
            
             responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //print("responseString = \(responseString!)")
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                // check for http errors
                success = false
                responseString = "statusCode should be 200, but is \(httpStatus.statusCode) (\(response))"
                let message: String? = (responseString as? String)
                callback(success, message)
            } else {
            
            }
            

            if(responseString == "success") {
                success = true;
            }

            
            let message: String? = (responseString as? String)
            
            callback(success, message)
        })
        task.resume()
    }

	 func CreateUser(username: String, password: String, firstName: String, surName: String, email: String, callback: (Bool, String?) -> ()) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://wullschi.com/conari/CreateUser.php")!)
        request.HTTPMethod = "POST"
        var postString:String = ""
        postString += "username=" + username
        postString += "&password=" + password
        postString += "&firstName=" + firstName
        postString += "&surName=" + surName
        postString += "&email=" + email
        
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
            
            //print("response = \(response)")
            
            responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //print("responseString = \(responseString!)")
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                // check for http errors
                success = false
                responseString = "statusCode should be 200, but is \(httpStatus.statusCode) (\(response))"
                let message: String? = (responseString as? String)
                callback(success, message)
            }else
            {
                
            }
            
            let message: String? = (responseString as? String)
            
            callback(success, message)
        })
        task.resume()
    }
	


  func requestTutorial(tutorialID: Int, callback: (Tutorial?, String?) -> ()){
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.wullschi.com/conari/RequestTutorial.php")!)
        request.HTTPMethod = "POST"
        let postString = "tutorialID=" + String(tutorialID)
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)

        //var jsonString: String = ""
        var responseString: NSString?
        //var successValue = 0
        
        var responseTutorial: Tutorial? = nil
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {data, response, error in
            guard error == nil && data != nil else {
                // check for fundamental networking error
                let message: String? = error?.localizedDescription
                
                callback(nil, message)
                
                return
            }
            

            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                // check for http errors
                responseString = "statusCode should be 200, but is \(httpStatus.statusCode) (\(response))"
            }
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                
                if data!.length > 2  {
                    responseTutorial = Tutorial(
                        title: jsonData[0] as! String,
                        category: jsonData[1] as! Int,
                        difficulty: jsonData[2] as! String,
                        duration: jsonData[3] as! String,
                        text: (jsonData[4] as! String).stringByReplacingOccurrencesOfString("\\\"", withString: "\""),
                        author: jsonData[5] as! String)
                }
                else {
                  responseString = "Tutorial not found!"
                }
                if let jsonErrorMessage = jsonData["error_message"] as? NSString {
                    responseString = jsonErrorMessage
                }
                //if let jsonSuccess = jsonData["success"] as? Int {
                    //successValue = jsonSuccess
                //}
                
              
                
            } catch {
                print("error serializing JSON: \(error)")
                callback(nil, "\(error)")
            }
            
            
            let message: String? = (responseString as? String)
            
            callback(responseTutorial, message)
            
        })
        task.resume()
    }
    
    func findTutorialByCategory(tutorial_title: String, tutorial_category: Int , completionHandler: (response: [Tutorial_item]) -> Void) -> Void {
        
        /*
         
         FindTutorialInCategory.php:
         /*	 Reveives:          title, category 								*/
         /*  Returns Array: 	[[TutID,Title,Category,Difficulty,Duration]] 	*/
         $title   	= $_POST['title'];
         $category   = $_POST['category'];
         
         */
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.wullschi.com/conari/FindTutorialInCategory.php")!)
        
        request.HTTPMethod = "POST"
        
        let allowedCharacters = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet
        allowedCharacters.removeCharactersInString("+/=")
        
        var postString:String = ""
        if tutorial_title != "" {
            postString += "title=" + tutorial_title.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)! as String!
        }
        
        postString += "&category=" + String(tutorial_category)
        
        //print(postString)
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        //var responseString: NSString?
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
        
            
            var tutorial_array = [Tutorial_item]()
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                //print(json)
                
                
                for anItem in json as! [Dictionary<String, AnyObject>] {
                    let title = anItem["title"] as! String
                    let difficulty = anItem["difficulty"] as! String
                    let duration = anItem["duration"] as! String
                    let category = anItem["category"] as! Int
                    let id = anItem["id"] as! Int
                    
                    
                    
                    tutorial_array.append(Tutorial_item(tut_id: id, tut_title: title, tut_category: category, tut_difficulty: difficulty, tut_duration: duration))
                    // do something with personName and personID
                }
                

            } catch {
                print("error serializing JSON: \(error)")
                tutorial_array.removeAll()
            }
            
            
            completionHandler(response: tutorial_array)
            
            
        }
        task.resume()
    }

    
}