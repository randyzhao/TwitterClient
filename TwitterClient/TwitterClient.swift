//
//  TwitterClient.swift
//  TwitterClient
//
//  Created by randy_zhao on 5/31/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import Foundation
import BDBOAuth1Manager

private var _sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "O7nUPAjghP7CsDjKp9DCtfhgi", consumerSecret: "7qW6FFx3YybObsSrmYDQqUbHIdgdue2TE7JcSWUszCiaYdU2y8")

class TwitterClient: BDBOAuth1SessionManager {
  static var sharedInstance: TwitterClient {
    let client = _sharedInstance
    print("Authorized: \(client.authorized)")
    return client
  }
  
  var loginSuccess: (() -> Void)?
  var loginFailure: ((NSError) -> Void)?
  
  func currentAccount(success: (User) -> Void, failure: (NSError) -> Void) {
    GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
      let user = User(dictionary: response as! NSDictionary)
      print("name: \(user.name!)")
      success(user)
      }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
        print("error: \(error.localizedDescription)")
    })
    
  }
  
  func homeTimeline(count: Int? = 20, sinceId: String? = nil, maxId: String? = nil, success: ([Tweet]) -> (), failure: (NSError) -> ()) {
    var parameters = [String: String]()
    if count != nil {
      parameters["count"] = String(count!)
    }
    if sinceId != nil {
      parameters["since_id"] = sinceId
    }
    if maxId != nil {
      parameters["max_id"] = maxId
    }
    GET("1.1/statuses/home_timeline.json", parameters: parameters, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
      let tweets = TweetHelper.tweetsFromNetworking(response)
      success(tweets ?? [])
      }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
        failure(error)
    })
  }
  
  
  func newTweet(status: String, inReplyTo: Tweet?, success: () -> (), failure: (NSError) -> ()) {
    var parameters = ["status": status]
    if let inReplyToId = inReplyTo?.id {
      parameters["in_reply_to_status_id"] = inReplyToId
    }
    POST("1.1/statuses/update.json", parameters: parameters, progress: nil, success: { (_: NSURLSessionDataTask, _: AnyObject?) in
      success()
    }) { (_: NSURLSessionDataTask?, error: NSError) in
      failure(error)
    }
  }
  
  func retweet(tweet: Tweet, success: () -> (), failure: (NSError) -> ()) {
    POST("1.1/statuses/retweet/\(tweet.id!).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
        success()
      }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
        failure(error)
    })
  }
  
  func love(tweet: Tweet, success: () -> (), failure: (NSError) -> ()) {
    let parameters = ["id": tweet.id ?? "0"]
    POST("1.1/favorites/create.json", parameters: parameters, progress: nil,
         success: {
          (task: NSURLSessionTask, response: AnyObject?) in
          success()
      }, failure: {
        (task: NSURLSessionTask?, error: NSError) in
        failure(error)
      }
    )
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
    fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) in
      print("I got the access token")
      
      self.homeTimeline(success: { (tweets: [Tweet]) -> Void in
        }, failure: { (error: NSError) -> Void in
      })
      
      self.currentAccount(
        { (user: User) in
          User.currentUser = user
          self.loginSuccess?()
        }, failure: { (error: NSError) in
          self.loginFailure?(error)
        }
      )
    }) { (error: NSError!) in
      print("error: \(error.localizedDescription)")
      self.loginFailure?(error)
    }
  }
  
  func logout() {
    deauthorize()
    User.currentUser = nil
    
    NSNotificationCenter.defaultCenter().postNotificationName("UserDidLogout", object: nil)
  }
}