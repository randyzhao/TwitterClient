//
//  TweetContentView.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/2/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

class TweetContentView: UIView {

  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet var mainView: UIView!
  var tweet: Tweet? {
    didSet {
      tweetTextLabel.text = tweet?.text
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
    let view = NSBundle.mainBundle().loadNibNamed("TweetContentView", owner: self, options: nil).first as! UIView
    addSubview(view)
    view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    view.frame = bounds
  }
}
