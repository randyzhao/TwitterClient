//
//  TwitterClient.swift
//  TwitterClient
//
//  Created by randy_zhao on 5/31/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import Foundation
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
  static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "O7nUPAjghP7CsDjKp9DCtfhgi", consumerSecret: "7qW6FFx3YybObsSrmYDQqUbHIdgdue2TE7JcSWUszCiaYdU2y8")
  
  var loginSuccess: (() -> Void)?
  var loginFailure: ((NSError) -> Void)?
  
  func currentAccount(success: (User) -> Void, failure: (NSError) -> Void) {
    GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
      let user = User(dictionary: response as! NSDictionary)
      print("name: \(user.name)")
      success(user)
      }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
        print("error: \(error.localizedDescription)")
    })

  }
  
  func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
    GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
      let tweets = Tweet.tweetsFromArray(response as! [NSDictionary])
      success(tweets)
    }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
        failure(error)
    })
  }
  
  func login(success: () -> Void, failure: (NSError) -> Void) {
    loginSuccess = success
    loginFailure = failure
    
    fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "rztwitterclient://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) in
      print("I got a token!")
      
      let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
      UIApplication.sharedApplication().openURL(url)
      
    }) { (error: NSError!) in
      self.loginFailure?(error)
      print("error: \(error.localizedDescription)")
    }
  }
  
  func handleOpenUrl(url: NSURL) {
    let requestToken = BDBOAuth1Credential(queryString: url.query)
    fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToekn: BDBOAuth1Credential!) in
      print("I got the access token")
      
      self.loginSuccess?()
      
      self.homeTimeline({ (tweets: [Tweet]) -> Void in
        for tweet in tweets {
          print(tweet.text!)
        }
        }, failure: { (error: NSError) -> Void in
      })
      
      self.currentAccount({ (User) in
        
        }, failure: { (error: NSError) in
          
      })
      
      
    }) { (error: NSError!) in
      print("error: \(error.localizedDescription)")
      self.loginFailure?(error)
    }

  }
}