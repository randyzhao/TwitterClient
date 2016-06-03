//
//  TableViewExtension.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/1/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import Foundation
import UIKit

extension TweetsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
  // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tweetTableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetTableViewCell
    cell.tweet = tweets[indexPath.row]
    cell.delegate = self
    cell.buttonsView.delegate = self
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: false)
    let vc = TweetDetailsViewController()
    vc.tweet = tweets[indexPath.row]
    //parentViewController?.navigationController?.pushViewController(vc, animated: true)
    delegate?.viewController?(pushNewViewController: vc, animated: true)
  }
}