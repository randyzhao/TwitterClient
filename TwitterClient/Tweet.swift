//
//  Tweet.swift
//  TwitterClient
//
//  Created by randy_zhao on 5/31/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

enum TweetType {
  case Original
  case Retweet
}

protocol Tweet {
  var text: String? { get }
  var timestamp: NSDate? { get }
  var retweetCount: Int? { get }
  var favoritesCount: Int? { get }
  var retweetedByName: String? { get }
  var tweetType: TweetType { get }
  var userName: String? { get }
  var user: User? { get }
}


class TweetHelper {
  class func tweetFromNetworking(data: AnyObject?) -> Tweet? {
    guard let data = data else {
      return nil
    }
    let json = JSON(data)
    return OriginalTweet(json: json)
  }
  
  class func tweetsFromNetworking(data: AnyObject?) -> [Tweet]? {
    guard let data = data else {
      return nil
    }
    var tweets = [Tweet]()
    let json = JSON(data)
    for (_, subJSON): (String, JSON) in json {
      tweets.append(OriginalTweet(json: subJSON))
    }
    return tweets
  }
}

class OriginalTweet: Tweet {
  var text: String?
  var timestamp: NSDate?
  var retweetCount: Int? = 0
  var favoritesCount: Int? = 0
  var retweetedByName: String?
  var userName: String?
  var tweetType: TweetType {
    return .Original
  }
  var user: User?
  /**
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
  
  class func tweetsFromNetworking(response: AnyObject?) -> [Tweet] {
    var tweets = [Tweet]()
    guard let response = response else {
      return tweets
    }
    let json = JSON(response)
  }
 */
  
  init(json: JSON) {
    text = json["text"].string
    if let timestampString = json["created_at"].string {
      let formatter = NSDateFormatter()
      formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
      timestamp = formatter.dateFromString(timestampString)
    }
    retweetCount = json["retweet_count"].int
    favoritesCount = json["favourites_count"].int
    userName = json["user"]["name"].string
    user = User(json: json["user"])
  }
}

/**
class Retweet: Tweet {
  let originalTweet: OriginalTweet?
  var retweetedByName: String?
  var text: String? {
    return originalTweet?.text
  }
  
  var timestamp: NSDate? {
    return originalTweet?.timestamp
  }
  
  var retweetCount: Int? {
    return originalTweet?.retweetCount
  }
  
  var favoritesCount: Int? {
    return originalTweet?.favoritesCount
  }
  
  var tweetType: TweetType {
    return .Retweet
  }
  
  init(json: JSON) {
    if let retweetedStatus = json["retweeted_status"].dictionary {
      originalTweet = OriginalTweet(json: retweetedStatus)
    }
    
  }
 }
 */

