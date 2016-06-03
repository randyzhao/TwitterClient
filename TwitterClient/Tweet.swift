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
  var tweetType: TweetType { get }
  var user: User? { get }
  var id: String? { get }
  var retweeted: Bool? { get set }
}


class TweetHelper {
  class func tweetFromJSON(json: JSON) -> Tweet {
    if json["retweeted_status"].dictionary != nil {
      return Retweet(json: json)
    } else {
      return OriginalTweet(json: json)
    }
  }
  
  class func tweetsFromNetworking(data: AnyObject?) -> [Tweet]? {
    guard let data = data else {
      return nil
    }
    var tweets = [Tweet]()
    let json = JSON(data)
    //dump(json)
    for (_, subJSON): (String, JSON) in json {
      tweets.append(tweetFromJSON(subJSON))
    }
    return tweets
  }
}

class OriginalTweet: Tweet {
  var text: String?
  var timestamp: NSDate?
  var retweetCount: Int? = 0
  var favoritesCount: Int? = 0
  var tweetType: TweetType {
    return .Original
  }
  var user: User?
  var id: String?
  var retweeted: Bool?
  
  init(json: JSON) {
    text = json["text"].string
    if let timestampString = json["created_at"].string {
      let formatter = NSDateFormatter()
      formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
      timestamp = formatter.dateFromString(timestampString)
    }
    retweetCount = json["retweet_count"].int
    favoritesCount = json["favourites_count"].int
    user = User(json: json["user"])
    id = String(json["id"].int ?? 0)
    retweeted = json["retweeted"].bool
  }
}

class Retweet: Tweet {
  let originalTweet: OriginalTweet?
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
  
  var user: User? {
    return originalTweet?.user
  }
  
  var id: String? {
    return originalTweet?.id
  }
  
  var retweeted: Bool? {
    get {
      return originalTweet?.retweeted
    } set {
      originalTweet?.retweeted = newValue
    }
  }
  
  var retweetedBy: User?
  
  init(json: JSON) {
    originalTweet = OriginalTweet(json: json["retweeted_status"])
    retweetedBy = User(json: json["user"])
  }
 }


