//
//  NewTweetViewController.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/2/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {
  
  @IBOutlet weak var tweetTextField: UITextField!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var closeButton: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onCloseButton(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func onTweet(sender: AnyObject) {
    if let text = tweetTextField.text where text != "" {
      TwitterClient.sharedInstance.newTweet(text, success: {
        print("tweeted successfully")
        self.dismissViewControllerAnimated(true, completion: nil)
        }, failure: { (error: NSError) in
          print("error: \(error.localizedDescription)")
      })
    }
  }
}
