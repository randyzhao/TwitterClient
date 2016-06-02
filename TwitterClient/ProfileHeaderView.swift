//
//  ProfileHeaderView.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/2/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {

  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var profileBannerImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  var user: User? {
    didSet {
      if let url = user?.profileUrl {
        profileImageView.setImageWithURL(url)
      }
      nameLabel.text = user?.name
      if let bannerUrl = user?.profileBannerUrl {
        profileBannerImageView.setImageWithURL(bannerUrl)
      } else {
        profileBannerImageView.backgroundColor = UIColor(hue: 0.5444, saturation: 1, brightness: 0.92, alpha: 1.0)
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
    let view = NSBundle.mainBundle().loadNibNamed("ProfileHeaderView", owner: self, options: nil).first as! UIView
    addSubview(view)
    view.frame.size = frame.size
  }
  
  override func intrinsicContentSize() -> CGSize {
    return CGSize(width: UIViewNoIntrinsicMetric, height: 170)
  }
}
