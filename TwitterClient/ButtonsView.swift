//
//  ButtonsView.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/2/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

protocol ButtonsViewDelegate {
  func buttonsView(buttonsView: ButtonsView, retweeted tweet: Tweet, success: (() -> ())?, failure: ((NSError) -> ())?)
  func buttonsView(buttonsView: ButtonsView, tweetReplied tweet: Tweet, success: (() -> ())?, failure: ((NSError) -> ())?)
  func buttonsView(buttonsView: ButtonsView, tweetLoved tweet: Tweet, success: (() -> ())?, failure: ((NSError) -> ())?)
}

class ButtonsView: UIView {
  
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var favoritesCountLabel: UILabel!
  
  @IBOutlet weak var retweetImageView: UIImageView!
  @IBOutlet weak var replyImageView: UIImageView!
  @IBOutlet weak var loveImageView: UIImageView!
  
  var delegate: ButtonsViewDelegate?
  
  var tweet: Tweet? {
    didSet {
      refreshContent()
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
  func refreshContent() {
    if tweet != nil {
      if tweet?.retweeted == true {
        retweetImageView.image = UIImage(named: "retweeted")
      } else {
        retweetImageView.image = UIImage(named: "retweet")
      }
      
      retweetCountLabel.text = String(tweet?.retweetCount ?? 0)
      favoritesCountLabel.text = String(tweet?.favoritesCount ?? 0)
      if retweetImageView.gestureRecognizers == nil{
        let tap = UITapGestureRecognizer(target: self, action: #selector(onRetweet))
        retweetImageView.addGestureRecognizer(tap)
      }
      
      if replyImageView.gestureRecognizers == nil {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onReply))
        replyImageView.addGestureRecognizer(tap)
      }
    }
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
    if tweet != nil {
      delegate?.buttonsView(self, tweetReplied: tweet!, success: nil, failure: nil)
    }
  }
  
  func onRetweet() {
    if tweet != nil {
      delegate?.buttonsView(self, retweeted: tweet!, success: {
        () -> () in
        self.tweet?.retweeted = true
        if self.tweet?.retweetCount != nil {
          self.tweet?.retweetCount! += 1
        }
        self.refreshContent()
        UIView.animateWithDuration(0.3, animations: {
          self.retweetImageView.transform = CGAffineTransformMakeScale(2, 2)
          }, completion: { (completed) in
            UIView.animateWithDuration(0.3, animations: {
              self.retweetImageView.transform = CGAffineTransformIdentity
              }, completion: nil)
        })
        }, failure: nil)
    }
  }
  
  func onLove() {
    if tweet != nil {
      delegate?.buttonsView(self, tweetLoved: tweet!, success: nil, failure: nil)
    }
  }
}
