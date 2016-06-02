//
//  RetweetStatusView.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/1/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

class RetweetStatusView: UIView {
  @IBOutlet weak var retweetStatusLabel: UILabel!
  @IBOutlet weak var iconLeadingConstraint: NSLayoutConstraint!
  @IBOutlet var mainView: UIView!

  var tweet: Tweet? {
    didSet {
      if let retweet = tweet as? Retweet {
        retweetStatusLabel.text = "\(retweet.retweetedBy?.name ?? "Unknown") Retweeted"
      }
    }
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    nibSetup()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    nibSetup()
    
  }
  
  private func nibSetup() {
    let view = NSBundle.mainBundle().loadNibNamed("RetweetStatusView", owner: self, options: nil).first as! UIView
    addSubview(view)
    view.frame.size.height = frame.height
    //mainView.frame.size.height = 20
  }
}
