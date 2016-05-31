//
//  Tweet.swift
//  TwitterClient
//
//  Created by randy_zhao on 5/31/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import Foundation
import UIKit

class Tweet {
  var text: String?
  var timestamp: NSDate?
  var retweetCount: Int = 0
  var favoritesCount: Int = 0
  
  init(dictionary: NSDictionary) {
    text = dictionary["text"]  as? String
    retweetCount = dictionary["retweet_count"] as? Int ?? 0
    favoritesCount = dictionary["favourites_count"] as? Int ?? 0
    
    let timestampString = dictionary["created_at"] as? String
    let formatter = NSDateFormatter()
    formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
    if let timestampString = timestampString {
      timestamp = formatter.dateFromString(timestampString)
    }
  }
  
  class func tweetsFromArray(dictionaries: [NSDictionary]) -> [Tweet] {
    var tweets = [Tweet]()
    
    for dictionary in dictionaries {
      let tweet = Tweet(dictionary: dictionary)
      tweets.append(tweet)
    }
    return tweets
  }
}