//
//  TweetDetailsViewController.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/2/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var tweetContentView: TweetContentView!
  var tweet: Tweet?
  
  private func setContent() {
    if let url = tweet?.user?.profileUrl {
      profileImageView.setImageWithURL(url)
    }
    usernameLabel.text = tweet?.user?.name
    tweetContentView.tweet = tweet
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Tweet"
    setContent()
    
    navigationController?.navigationBar.translucent = false
  }
  
  /**
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    self.edgesForExtendedLayout = UIRectEdge.None
  }
 */
}
