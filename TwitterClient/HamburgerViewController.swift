//
//  HamburgerViewController.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/2/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
  
  @IBOutlet weak var contentViewLeftMargin: NSLayoutConstraint!
  var originalLeftMargin: CGFloat = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
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
      contentViewLeftMargin.constant = originalLeftMargin + translation.x
    case UIGestureRecognizerState.Ended:
      UIView.animateWithDuration(0.3, animations: { 
        if velocity.x > 0 {
          // opening the menu
          self.contentViewLeftMargin.constant = self.view.frame.size.width - 50
        } else {
          self.contentViewLeftMargin.constant = 0
        }
      })
    default:
      break
    }
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
