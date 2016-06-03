//
//  TweetsViewController+ButtonsView.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/3/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import Foundation
extension TweetsViewController: ButtonsViewDelegate {
  func buttonsView(buttonsView: ButtonsView, retweeted tweet: Tweet, success: (() -> ())?, failure: ((NSError) -> ())?) {
    if tweet.retweeted == false {
      TwitterClient.sharedInstance.retweet(tweet, success: {
        print("retweet \(tweet.id!) success")
        success?()
      }) { (error: NSError) in
        print("retweet \(tweet.id!) failed")
        failure?(error)
      }
    }
  }
  
  func buttonsView(buttonsView: ButtonsView, userReplied user: User, success: (() -> ())?, failure: ((NSError) -> ())?) {
    
  }
  
  func buttonsView(buttonsView: ButtonsView, tweetLoved tweet: Tweet, success: (() -> ())?, failure: ((NSError) -> ())?) {
    
  }
}