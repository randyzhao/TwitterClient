//
//  TweetTableViewCell.swift
//  TwitterClient
//
//  Created by randy_zhao on 5/31/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
  
  @IBOutlet weak var retweetStatusView: UIView!
  @IBOutlet weak var retweetStatusViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var retweetedByLabel: UILabel!
  @IBOutlet weak var profileImageView: UIImageView!
  
  var tweet: Tweet? {
    didSet {
      tweetTextLabel.text = tweet?.text
      usernameLabel.text = tweet?.user?.name
      if let profileUrl = tweet?.user?.profileUrl {
        profileImageView.setImageWithURL(profileUrl)
      }
      
      if let tweetType = tweet?.tweetType {
        switch tweetType {
        case .Original:
          retweetStatusViewHeightConstraint.constant = 0
          retweetStatusView.hidden = true
        case .Retweet:
          retweetStatusViewHeightConstraint.constant = 20
          retweetStatusView.hidden = false
          let retweet = tweet as! Retweet
          retweetedByLabel.text = retweet.retweetedBy?.name
        }
      }
    }
  }
    
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
