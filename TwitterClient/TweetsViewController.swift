//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by randy_zhao on 5/31/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

@objc protocol ContainedViewControllerDelegate {
  optional func viewController(pushNewViewController nvc: UIViewController, animated: Bool)
}

enum TweetsViewControllerType {
  case Home
  case Mentions
}

class TweetsViewController: UIViewController {
  
  @IBOutlet weak var tweetTableView: UITableView!
  var tweets = [Tweet]()
  var delegate: ContainedViewControllerDelegate?
  var containerViewController: UIViewController?
  var controllerType: TweetsViewControllerType!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    switch controllerType! {
    case .Home:
      containerViewController?.navigationItem.title = "Home"
    case .Mentions:
      containerViewController?.navigationItem.title = "Mentions"
    }
    
    containerViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(onLogoutButton))
    
    tweetTableView.registerNib(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "tweetCell")
    tweetTableView.dataSource = self
    tweetTableView.delegate = self
    tweetTableView.rowHeight = UITableViewAutomaticDimension
    tweetTableView.estimatedRowHeight = 200
    
    
//    TwitterClient.sharedInstance.homeTimeline(success: { (tweets: [Tweet]) in
//      self.tweets = tweets
//      self.tweetTableView.reloadData()
//      }) { (error) in
//        print("error: \(error.localizedDescription)")
//    }
    refreshTweets(nil, maxId: nil, success: nil, failure: nil)
    
    let icon = UIImage(named: "new_tweet")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    let newTweetButton = UIBarButtonItem(image: icon, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(onNewTweetButton))
    containerViewController?.navigationItem.rightBarButtonItem = newTweetButton
    
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshControlAction), forControlEvents: UIControlEvents.ValueChanged)
    tweetTableView.insertSubview(refreshControl, atIndex: 0)
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func onLogoutButton() {
    TwitterClient.sharedInstance.logout()
  }
  
  func onNewTweetButton() {
    let vc = NewTweetViewController()
    vc.user = User.currentUser
    containerViewController?.navigationController?.presentViewController(vc, animated: true, completion: nil)
  }
  
  func refreshTweets(sinceId: String?, maxId: String?, success: (() -> ())?, failure: ((NSError) -> ())?) {
    let timelineType: TimelineType!
    switch controllerType! {
    case .Home:
      timelineType = .Home
    case .Mentions:
      timelineType = .Mentions
    }
    
    TwitterClient.sharedInstance.timeline(timelineType, sinceId: sinceId, maxId: maxId, success: { (tweets: [Tweet]) in
      self.tweets = tweets + self.tweets
      self.tweetTableView.reloadData()
      success?()
    }) { (error: NSError) in
      failure?(error)
    }
  }
  
  func refreshControlAction(refreshControl: UIRefreshControl) {
    refreshTweets(tweets.first?.id, maxId: nil, success: { 
      refreshControl.endRefreshing()
    }) { (error: NSError) in
      print("\(error.localizedDescription)")
      refreshControl.endRefreshing()
    }
  }
}
