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
  
  func buttonsView(buttonsView: ButtonsView, tweetReplied tweet: Tweet, success: (() -> ())?, failure: ((NSError) -> ())?) {
    let ntvc = NewTweetViewController()
    ntvc.inReplyTo = tweet
    ntvc.user = User.currentUser
    containerViewController?.navigationController?.presentViewController(ntvc, animated: true, completion: {
      success?()
    })
  }
  
  func buttonsView(buttonsView: ButtonsView, tweetLoved tweet: Tweet, success: (() -> ())?, failure: ((NSError) -> ())?) {
    
  }
}