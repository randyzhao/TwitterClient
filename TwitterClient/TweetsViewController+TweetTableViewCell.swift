//
//  TweetsViewController+TweetTableViewCell.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/2/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import Foundation
import UIKit

extension TweetsViewController: TweetTableCellDelegate {
  func tweetTableCell(userSelected user: User) {
    let pvc = ProfileViewController()
    pvc.user = user
    delegate?.viewController?(pushNewViewController: pvc, animated: true)
  }
}