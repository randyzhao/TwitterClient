//
//  ButtonsView.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/2/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

protocol ButtonsViewDelegate {
  func buttonsView(retweeted tweet: Tweet)
  func buttonsView(userReplied user: User)
  func buttonsView(tweetLoved tweet: Tweet)
}

class ButtonsView: UIView {
  
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var favoritesCountLabel: UILabel!
  
  @IBOutlet weak var retweetImageView: UIImageView!
  @IBOutlet weak var replayImageView: UIImageView!
  @IBOutlet weak var loveImageView: UIImageView!
  
  var delegate: ButtonsViewDelegate?
  
  var tweet: Tweet? {
    didSet {
      retweetCountLabel.text = String(tweet?.retweetCount ?? 0)
      favoritesCountLabel.text = String(tweet?.favoritesCount ?? 0)
      if retweetImageView.gestureRecognizers == nil{
        let tap = UITapGestureRecognizer(target: self, action: #selector(onRetweet))
        retweetImageView.addGestureRecognizer(tap)
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
    let view = NSBundle.mainBundle().loadNibNamed("ButtonsView", owner: self, options: nil).first as! UIView
    addSubview(view)
    view.frame.size = frame.size
  }
  
  override func intrinsicContentSize() -> CGSize {
    return CGSize(width: UIViewNoIntrinsicMetric, height: 30)
  }
  
  func onReply() {
    if let user = tweet?.user {
      delegate?.buttonsView(userReplied: user)
    }
  }
  
  func onRetweet() {
    if tweet != nil {
      delegate?.buttonsView(retweeted: tweet!)
    }
  }
  
  func onLove() {
    if tweet != nil {
      delegate?.buttonsView(tweetLoved: tweet!)
    }
  }
}
