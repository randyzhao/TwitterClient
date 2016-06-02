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
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
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
    view.frame.size = frame.size
    tweetTextLabel.preferredMaxLayoutWidth = frame.size.width
    tweetTextLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
    tweetTextLabel.sizeToFit()
  }
  
  override func intrinsicContentSize() -> CGSize {
    return CGSize(width: UIViewNoIntrinsicMetric, height: mainView.frame.height)
  }
}
