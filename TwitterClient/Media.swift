//
//  Media.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/3/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import Foundation
import SwiftyJSON

class Media {
  static let Sizes = ["large", "medium", "small", "thumb"]
  private var originalUrlString: String?
  private var size: String?
  
  var mediaUrl: NSURL? {
    if originalUrlString != nil && size != nil {
      return NSURL(string: originalUrlString! + ":" + size!)
    } else {
      return nil
    }
  }
  
  init(json: JSON) {
    originalUrlString = json["media_url_https"].string
    for sizeName in Media.Sizes {
      if json["sizes"][sizeName].dictionary != nil {
        size = sizeName
      }
    }
  }
}