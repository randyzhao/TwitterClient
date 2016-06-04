//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/2/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit



class ProfileViewController: UIViewController {
  
  @IBOutlet weak var profileHeaderView: ProfileHeaderView!
  @IBOutlet weak var tweetsTableView: UITableView!
  
  var user: User?
  var containerViewController: UIViewController?
  var tweets = [Tweet]()
  
  private func setup() {
    profileHeaderView.user = user
    containerViewController?.navigationItem.title = "Profile"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tweetsTableView.dataSource = self
    tweetsTableView.delegate = self
    tweetsTableView.rowHeight = UITableViewAutomaticDimension
    tweetsTableView.estimatedRowHeight = 200
    tweetsTableView.registerNib(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "tweetCell")
    refreshTweets(nil, maxId: nil, success: nil, failure: nil)
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    setup()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func refreshTweets(sinceId: String?, maxId: String?, success: (() -> ())?, failure: ((NSError) -> ())?) {
    TwitterClient.sharedInstance.timeline(.User, sinceId: sinceId, maxId: maxId, success: { (tweets: [Tweet]) in
      self.tweets = tweets + self.tweets
      self.tweetsTableView.reloadData()
      success?()
    }) { (error: NSError) in
      failure?(error)
    }
  }
}
