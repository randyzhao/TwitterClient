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

class TweetsViewController: UIViewController {
  
  @IBOutlet weak var tweetTableView: UITableView!
  var tweets = [Tweet]()
  var delegate: ContainedViewControllerDelegate?
  var containerViewController: UIViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    containerViewController?.navigationItem.title = "Home"
    containerViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(onLogoutButton))
    
    tweetTableView.registerNib(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "tweetCell")
    tweetTableView.dataSource = self
    tweetTableView.delegate = self
    tweetTableView.rowHeight = UITableViewAutomaticDimension
    tweetTableView.estimatedRowHeight = 100
    
    TwitterClient.sharedInstance.homeTimeline(success: { (tweets: [Tweet]) in
      self.tweets = tweets
      self.tweetTableView.reloadData()
      }) { (error) in
        print("error: \(error.localizedDescription)")
    }
    
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
    TwitterClient.sharedInstance.homeTimeline(sinceId: sinceId, maxId: maxId, success: { (tweets: [Tweet]) in
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
