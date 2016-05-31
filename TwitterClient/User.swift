//
//  User.swift
//  TwitterClient
//
//  Created by randy_zhao on 5/31/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

class User {
  var name: String?
  var screenname: String?
  var profileUrl: NSURL?
  var tagline: String?
  
  init(dictionary: NSDictionary) {
    name = dictionary["name"] as? String
    screenname = dictionary["screen_name"] as? String
    
    if let profileUrlString = dictionary["profile_image_url_https"] as? String {
      profileUrl = NSURL(string: profileUrlString)
    }
    
    tagline = dictionary["description"] as? String
  }
}
