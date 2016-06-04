//
//  HamburgerViewController.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/2/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController{
  
  @IBOutlet weak var contentViewLeftMargin: NSLayoutConstraint!
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var menuView: UIView!
  var originalLeftMargin: CGFloat = 0
  var menuViewController: UIViewController! {
    didSet {
      view.layoutIfNeeded()
      menuViewController.willMoveToParentViewController(self)
      menuView.addSubview(menuViewController.view)
      menuViewController.didMoveToParentViewController(self)
    }
  }
  
  var contentViewController: UIViewController! {
    didSet(oldContentViewController) {
      view.layoutIfNeeded()
      
      if oldContentViewController != nil {
        oldContentViewController.willMoveToParentViewController(nil)
        oldContentViewController.view.removeFromSuperview()
        oldContentViewController.didMoveToParentViewController(nil)
      }
      
      contentViewController.willMoveToParentViewController(self)
      contentViewController.view.frame = contentView.bounds
      contentView.addSubview(contentViewController.view)
      contentViewController.didMoveToParentViewController(self)
      
      UIView.animateWithDuration(0.3) { 
        self.contentViewLeftMargin.constant = 0
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
    let translation = sender.translationInView(view)
    let velocity = sender.velocityInView(view)
    
    switch sender.state {
    case UIGestureRecognizerState.Began:
      originalLeftMargin = contentViewLeftMargin.constant
    case UIGestureRecognizerState.Changed:
      if originalLeftMargin + translation.x > 0 {
        contentViewLeftMargin.constant = originalLeftMargin + translation.x
      }
    case UIGestureRecognizerState.Ended:
      UIView.animateWithDuration(0.3, animations: { 
        if velocity.x > 0 {
          // opening the menu
          self.contentViewLeftMargin.constant = self.view.frame.size.width - 100
        } else {
          self.contentViewLeftMargin.constant = 0
        }
      })
    default:
      break
    }
  }
}
