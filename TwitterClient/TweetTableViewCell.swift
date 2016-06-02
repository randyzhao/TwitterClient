//
//  TweetTableViewCell.swift
//  TwitterClient
//
//  Created by randy_zhao on 5/31/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
  
  @IBOutlet weak var retweetStatusView: RetweetStatusView!
  @IBOutlet weak var retweetStatusViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var loveCountLabel: UILabel!
  @IBOutlet weak var timestampDiffLabel: UILabel!
  var tweet: Tweet? {
    didSet {
      tweetTextLabel.text = tweet?.text
      usernameLabel.text = tweet?.user?.name
      if let profileUrl = tweet?.user?.profileUrl {
        profileImageView.setImageWithURL(profileUrl)
      }
      retweetCountLabel.text = String(tweet?.retweetCount ?? 0)
      loveCountLabel.text = String(tweet?.favoritesCount ?? 0)
      timestampDiffLabel.text = calcTimestampDiff(tweet?.timestamp)
      retweetStatusView.tweet = tweet
      
      if let tweetType = tweet?.tweetType {
        switch tweetType {
        case .Original:
          retweetStatusViewHeightConstraint.constant = 0
          retweetStatusView.hidden = true
        case .Retweet:
          retweetStatusViewHeightConstraint.constant = 20
          retweetStatusView.hidden = false
        }
      }
    }
  }
  
  func calcTimestampDiff(timestamp: NSDate?) -> String {
    guard timestamp != nil else {
      return ""
    }
    
    let now = NSDate()
    let cal = NSCalendar.currentCalendar()
    let components = cal.components(NSCalendarUnit.Minute, fromDate: timestamp!, toDate: now, options: [])
    let minutes = components.minute
    switch minutes {
    case 0:
      return "now"
    case 1..<60:
      return "\(minutes)m"
    case 60..<1440:
      return "\(minutes / 60)h"
    default:
      return "\(minutes / 1440)d"
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
