//
//  DatabaseManager.swift
//  Mr Tutor
//
//  Created on 13.04.16.
//  Copyright © 2016 Developer5. All rights reserved.
//
import Foundation

struct User {
  var email: String
  var firstname: String
  var surname: String
}

struct Tutorial {
  var title: String
  var category: Int
  var difficulty: String
  var duration: String
  var text: String
  var id: String
}

class TutorialItem {
  
  var id          : Int
  var title       : String
  var category    : Int
  var difficulty  : String
  var duration    : String
  var author      : String
  
  init(tutID: Int, tutTitle: String, tutCategory : Int, tutDifficulty : String, tutDuration : String, tutAuthor : String){
    self.id     = tutID
    self.title  = tutTitle
    self.category   = tutCategory
    self.difficulty = tutDifficulty
    self.duration   = tutDuration
    self.author     = tutAuthor
  }
  
}

var categories = ["Arts and Entertainment",
                  "Cars & Other Vehicles",
                  "Computers and Electronics",
                  "Conari",
                  "Education and Communications",
                  "Finance and Business",
                  "Food and Entertaining",
                  "Health",
                  "Hobbies and Crafts",
                  "Holidays and Traditions",
                  "Home and Garden",
                  "Personal Care and Style",
                  "Pets and Animals",
                  "Philosophy and Religion",
                  "Relationships",
                  "Sports and Fitness",
                  "Travel",
                  "Work World",
                  "Youth"]

/**
 This file will act as our Database manager.
 */
class DatabaseManager {
  
  /** Singletone instance. */
  static let sharedManager = DatabaseManager()
  
  var username: String = ""
  var password: String = ""
  
  var baseUrl = "http://wullschi.com/"
  
  func login(username: String, password: String, callback: (Bool, String?) -> ()) {
    
    let request = NSMutableURLRequest(URL: NSURL(string: baseUrl+"conari/Login.php")!)
    request.HTTPMethod = "POST"
    let postString = "username=" + username + "&password=" + password
    request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
    
    var success: Bool = false
    var responseString: NSString?
    
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
          self.username = username
          self.password = password
          success = true
        }
        if let jsonErrorMessage = jsonData["error_message"] as? NSString {
          responseString = jsonErrorMessage
        }
        if (jsonData["success"] != nil) {
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
  
  func createTutorial(metadata: TutorialMetaData, content: String, callback: (Bool, String?) -> ()) {
    
    let request = NSMutableURLRequest(URL: NSURL(string: baseUrl+"/conari/CreateTutorial.php")!)
    request.HTTPMethod = "POST"
    var postString:String = ""
    postString += "username=" + username
    postString += "&password=" + password
    postString += "&title=" + metadata.Title.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
    postString += "&category=" + String(metadata.category+1)
    postString += "&difficulty=" + String(metadata.difficulty)
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
      
      responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
      
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
  
  func editTutorial(metadata: TutorialMetaData, content: String, callback: (Bool, String?) -> ()) {
    
    let request = NSMutableURLRequest(URL: NSURL(string: baseUrl+"/conari/EditTutorial.php")!)
    request.HTTPMethod = "POST"
    var postString:String = ""
    postString += "username=" + username
    postString += "&password=" + password
    postString += "&tutid=" + String(metadata.id)
    postString += "&newtitle=" + metadata.Title.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
    postString += "&category=" + String(metadata.category+1)
    postString += "&difficulty=" + String(metadata.difficulty)
    postString += "&duration=" + String(metadata.duration)
    
    let allowedCharacters = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet
    allowedCharacters.removeCharactersInString("+/=")
    postString += "&text=" + content.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)! as String!
    
    print(postString)
    
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
      
      responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
      
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
  
  func deleteTutorial(id: Int, callback: (Bool, String?) -> ()) {
    
    let request = NSMutableURLRequest(URL: NSURL(string: baseUrl+"/conari/DeleteTutorial")!)
    request.HTTPMethod = "POST"
    var postString:String = ""
    postString += "username=" + username
    postString += "&password=" + password
    postString += "&tutid=" + String(id)
    
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
      
      responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
      
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
  
  func createUser(username: String, password: String, firstName: String, surName: String, email: String, callback: (Bool, String?) -> ()) {
    
    let request = NSMutableURLRequest(URL: NSURL(string: baseUrl+"/conari/CreateUser.php")!)
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
      
      responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
      
      if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
        // check for http errors
        success = false
        responseString = "statusCode should be 200, but is \(httpStatus.statusCode) (\(response))"
        let message: String? = (responseString as? String)
        callback(success, message)
      } else {
        
      }
      
      let message: String? = (responseString as? String)
      
      callback(success, message)
    })
    task.resume()
  }
  
  
  func getUserName() -> String {
    return username
  }
  
  func getUserPassword() -> String {
    return password
  }
  
  func requestTutorial(tutorialID: Int, callback: (Tutorial?, String?) -> ()){
    
    let request = NSMutableURLRequest(URL: NSURL(string: baseUrl+"/conari/RequestTutorial.php")!)
    request.HTTPMethod = "POST"
    let postString = "tutorialID=" + String(tutorialID)
    request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
    
    var responseString: NSString?
    
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
            id: String(tutorialID)
          )
        }
        else {
          responseString = "Tutorial not found!"
        }
        if let jsonErrorMessage = jsonData["error_message"] as? NSString {
          responseString = jsonErrorMessage
        }
        
      } catch {
        callback(nil, "\(error)")
      }
      
      let message: String? = (responseString as? String)
      
      callback(responseTutorial, message)
      
    })
    task.resume()
  }
  
  func findTutorialByUsername(username: String, completionHandler: (response: [TutorialItem]) -> Void) -> Void {
    
    let request = NSMutableURLRequest(URL: NSURL(string: baseUrl+"/conari/FindTutorialByUsername.php")!)
    
    request.HTTPMethod = "POST"
    
    let allowedCharacters = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet
    allowedCharacters.removeCharactersInString("+/=")
    
    var postString:String = ""
    if username != "" {
      postString += "username=" + username.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)! as String!
    }
    
    request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
    
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
      guard error == nil && data != nil else {                                                          // check for fundamental networking error
        print("error=\(error)")
        return
      }
      
      if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
        print("statusCode should be 200, but is \(httpStatus.statusCode)")
        print("response = \(response)")
      }
      
      var tutorialArray = [TutorialItem]()
      
      do {
        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
        
        for anItem in json as! [Dictionary<String, AnyObject>] {
          let title = anItem["title"] as! String
          let difficulty = anItem["difficulty"] as! String
          let duration = anItem["duration"] as! String
          let category = anItem["category"] as! Int
          let id = anItem["id"] as! Int
          let author = anItem["author"] as! String
          
          tutorialArray.append(TutorialItem(tutID: id, tutTitle: title, tutCategory: category, tutDifficulty: difficulty, tutDuration: duration, tutAuthor: author))
          // do something with personName and personID
        }
        
      } catch {
        print("error serializing JSON: \(error)")
        tutorialArray.removeAll()
      }
      
      completionHandler(response: tutorialArray)
    }
    task.resume()
  }
  
  func findTutorialByCategory(tutorialTitle: String, tutorialCategory: Int , completionHandler: (response: [TutorialItem]) -> Void) -> Void {
    
    let request = NSMutableURLRequest(URL: NSURL(string: baseUrl+"/conari/FindTutorialInCategory.php")!)
    
    request.HTTPMethod = "POST"
    
    let allowedCharacters = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet
    allowedCharacters.removeCharactersInString("+/=")
    
    var postString:String = ""
    if tutorialTitle != "" {
      postString += "title=" + tutorialTitle.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)! as String!
    }
    postString += "&category=" + String(tutorialCategory)
    
    request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
    
    
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
      guard error == nil && data != nil else {                                                          // check for fundamental networking error
        print("error=\(error)")
        return
      }
      
      if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
        print("statusCode should be 200, but is \(httpStatus.statusCode)")
        print("response = \(response)")
      }
      
      var tutorialArray = [TutorialItem]()
      
      do {
        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
        
        for anItem in json as! [Dictionary<String, AnyObject>] {
          let title = anItem["title"] as! String
          let difficulty = anItem["difficulty"] as! String
          let duration = anItem["duration"] as! String
          let category = anItem["category"] as! Int
          let id = anItem["id"] as! Int
          let author = anItem["author"] as! String
          
          tutorialArray.append(TutorialItem(tutID: id, tutTitle: title, tutCategory: category, tutDifficulty: difficulty, tutDuration: duration, tutAuthor: author))
          // do something with personName and personID
        }
        
      } catch {
        print("error serializing JSON: \(error)")
        tutorialArray.removeAll()
      }
      
      completionHandler(response: tutorialArray)
      
    }
    task.resume()
  }
  
  
  func changeUserPassword(username: String, newPassword: String, oldPassword: String, callback: (Bool, String?) -> ()) {
    
    let request = NSMutableURLRequest(URL: NSURL(string: baseUrl+"/conari/ChangePassword.php")!)
    request.HTTPMethod = "POST"
    let postString = "username=" + username +
      "&new_password=" + newPassword +
      "&old_password=" + oldPassword
    
    request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
    
    var success: Bool = false
    var responseString: NSString?
    
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
          self.password = newPassword
          success = true
        }
        if let jsonErrorMessage = jsonData["error_message"] as? NSString {
          responseString = jsonErrorMessage
        }
        if (jsonData["success"] != nil) {
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
  
  func changeUserEmail(username: String, password: String, newEmail: String, callback: (Bool, String?) -> ()) {
    
    let request = NSMutableURLRequest(URL: NSURL(string: baseUrl+"/conari/ChangeMail.php")!)
    request.HTTPMethod = "POST"
    let postString = "username=" + username +
      "&password=" + password +
      "&new_email=" + newEmail
    
    request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
    
    var success: Bool = false
    var responseString: NSString?
    
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
          success = true
        }
        if let jsonErrorMessage = jsonData["error_message"] as? NSString {
          responseString = jsonErrorMessage
        }
        if (jsonData["success"] != nil) {
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
  
  func changeUserFirstAndSurname(username: String, password: String, newFirstname: String, newSurname: String, callback: (Bool, String?) -> ()) {
    
    let request = NSMutableURLRequest(URL: NSURL(string: baseUrl+"/conari/ChangeName.php")!)
    request.HTTPMethod = "POST"
    let postString = "username=" + username +
      "&password=" + password +
      "&new_firstname=" + newFirstname +
      "&new_surname=" + newSurname
    
    request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
    
    var success: Bool = false
    var responseString: NSString?
    
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
          success = true
        }
        if let jsonErrorMessage = jsonData["error_message"] as? NSString {
          responseString = jsonErrorMessage
        }
        if (jsonData["success"] != nil) {
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
  
  
  func requestUser(username: String, callback: (User?, String?) -> ()){
    
    let request = NSMutableURLRequest(URL: NSURL(string: "http://www.wullschi.com/conari/RequestUser.php")!)
    request.HTTPMethod = "POST"
    let postString = "username=" + username
    request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
    
    var responseString: NSString?
    var responseUser: User? = nil
    
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
          responseUser = User(
            email: jsonData[0]["email"] as! String,
            firstname: jsonData[0]["firstname"] as! String,
            surname: jsonData[0]["surname"] as! String
          )
        }
        else {
          responseString = "User not found!"
        }
        if let jsonErrorMessage = jsonData["error_message"] as? NSString {
          responseString = jsonErrorMessage
        }
        
      } catch {
        print("error serializing JSON: \(error)")
      }
      
      let message: String? = (responseString as? String)
      
      callback(responseUser, message)
      
    })
    task.resume()
  }
  
  func getAccessToken(callback: (String?) -> ()){
    
    /* Remark (Security)
     Storing the data inside here is not secure, but still better than requesting it from a custom request.
     Two possibilities:
     1. Storing all data here
     2. Storing all data on an external server and only requesting the access token from this server
     Option 1 was chosen based on the assumption that decompiling the app should be more difficult than just
     monitoring the request and getting the access token (which allows the attacker to do anything with our
     YouTube account). The disadvantage is that an attacker gets everything after a successful decompilation
     and not only the access token.
    */
    
    let client_secret = "ElQiVGifufIdwIBF5T609ZVN"
    let grant_type = "refresh_token"
    let refresh_token = "1/1nfHW0Q1BZAmb7YBeD4XiLZJF2p-P9BFNa4WWPDKZUU"
    let client_id = "234918812842-5jlqchqd5oc53tvq4s3l754ah1vhvglc.apps.googleusercontent.com"
    
    let request = NSMutableURLRequest(URL: NSURL(string: "https://accounts.google.com/o/oauth2/token")!)
    request.HTTPMethod = "POST"
    let postString = "client_secret=" + client_secret +
        "&grant_type=" + grant_type +
        "&refresh_token=" + refresh_token +
        "&client_id=" + client_id
    request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
    
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {data, response, error in
        guard error == nil && data != nil else {
            callback("Error")
            return
        }
        if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
            callback("Error")
            return
        }
        do {
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            let accessToken = jsonData["access_token"]! as? String
            callback(accessToken)
            
        } catch {
            callback("Error")
        }
        return
        
    })
    task.resume()
    
  }
}