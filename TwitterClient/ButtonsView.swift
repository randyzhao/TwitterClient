//
//  ButtonsView.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/2/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

class ButtonsView: UIView {
  
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var favoritesCountLabel: UILabel!
  
  var tweet: Tweet? {
    didSet {
      retweetCountLabel.text = String(tweet?.retweetCount ?? 0)
      favoritesCountLabel.text = String(tweet?.favoritesCount ?? 0)
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
}