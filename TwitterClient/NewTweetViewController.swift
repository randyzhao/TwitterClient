//
//  NewTweetViewController.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/2/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {
  
  @IBOutlet weak var tweetTextView: UITextView!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var closeButton: UIButton!
  
  var inReplyTo: Tweet?
  var user: User?
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    refreshContent()
    tweetTextView.becomeFirstResponder()
  }
  
  func refreshContent() {
    if let url = user?.profileUrl {
      profileImageView.setImageWithURL(url)
    }
    if inReplyTo != nil {
      tweetTextView.text = "@\(inReplyTo?.user?.screenName ?? "unknown_screen_name") "
    }
  }

  @IBAction func onCloseButton(sender: AnyObject) {
    tweetTextView.resignFirstResponder()
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func onTweet(sender: AnyObject) {
    if let text = tweetTextView.text where text != "" {
      TwitterClient.sharedInstance.newTweet(text, inReplyTo: inReplyTo, success: {
        print("tweeted successfully")
        self.dismissViewControllerAnimated(true, completion: nil)
        }, failure: { (error: NSError) in
          print("error: \(error.localizedDescription)")
      })
    }
  }
}
