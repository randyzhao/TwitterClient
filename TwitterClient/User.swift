//
//  User.swift
//  TwitterClient
//
//  Created by randy_zhao on 5/31/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit
import SwiftyJSON

class User {
  var name: String?
  var screenname: String?
  var profileUrl: NSURL?
  var profileBannerUrl: NSURL?
  var tagline: String?
  var screenName: String?
  var originalDictionary: NSDictionary?
  var followingCount: Int?
  var followersCount: Int?
  var id: String?
  
  private static let CurrentUserDataKey = "currentUserData"
  private static var _currentUser: User?
  
  init(dictionary: NSDictionary) {
    originalDictionary = dictionary
    name = dictionary["name"] as? String
    screenname = dictionary["screen_name"] as? String
    
    if let profileUrlString = dictionary["profile_image_url_https"] as? String {
      profileUrl = NSURL(string: profileUrlString)
    }
    tagline = dictionary["description"] as? String
    followingCount = dictionary["friends_count"] as? Int
    followersCount = dictionary["followers_count"] as? Int
  }
  
  init(json: JSON) {
    name = json["name"].string
    screenname = json["screenname"].string
    if let profileUrlString = json["profile_image_url_https"].string {
      profileUrl = NSURL(string: profileUrlString)
    }
    if let profileBannerUrlString = json["profile_banner_url"].string {
      profileBannerUrl = NSURL(string: profileBannerUrlString)
    }
    tagline = json["description"].string
    originalDictionary = json.dictionaryObject
    screenName = json["screen_name"].string
    followersCount = json["followers_count"].int
    followingCount = json["friends_count"].int
    id = json["id_str"].string
  }
  
  class var currentUser: User? {
    get {
      if _currentUser != nil {
        return _currentUser
      }
      let defaults = NSUserDefaults.standardUserDefaults()
      if let data = defaults.objectForKey(CurrentUserDataKey) as? NSData {
        let dictionary = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
        _currentUser = User(dictionary: dictionary)
      }
      
      return _currentUser
    }
    
    set(user) {
      let defaults = NSUserDefaults.standardUserDefaults()
      if let user = user {
        _currentUser = user

        let data = try! NSJSONSerialization.dataWithJSONObject(user.originalDictionary!, options: [])
        defaults.setObject(data, forKey: CurrentUserDataKey)
        defaults.synchronize()
      } else {
        _currentUser = nil
        defaults.removeObjectForKey(CurrentUserDataKey)
      }
    }
  }
}
