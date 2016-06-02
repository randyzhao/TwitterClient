//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by randy_zhao on 5/31/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

@objc protocol ContainedViewControllerDelegate {
  optional func viewController(pushNewViewController nvc: UIViewController, animated: Bool)
}

class TweetsViewController: UIViewController {
  
  @IBOutlet weak var tweetTableView: UITableView!
  var tweets = [Tweet]()
  var delegate: ContainedViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Home"
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(onLogoutButton))
    
    tweetTableView.registerNib(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "tweetCell")
    tweetTableView.dataSource = self
    tweetTableView.delegate = self
    tweetTableView.rowHeight = UITableViewAutomaticDimension
    tweetTableView.estimatedRowHeight = 100
    
    TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) in
      self.tweets = tweets
      self.tweetTableView.reloadData()
      }) { (error) in
        print("error: \(error.localizedDescription)")
    }
    
    let newTweetButton = UIBarButtonItem(image: UIImage(named: "new_tweet"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(onNewTweetButton))
    navigationItem.rightBarButtonItem = newTweetButton
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func onLogoutButton() {
    TwitterClient.sharedInstance.logout()
  }
  
  func onNewTweetButton() {
    let vc = NewTweetViewController()
    parentViewController?.navigationController?.presentViewController(vc, animated: true, completion: nil)
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
