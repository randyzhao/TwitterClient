//
//  HamburgerViewController+ContainedViewController.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/2/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import Foundation
import UIKit
extension HamburgerViewController: ContainedViewControllerDelegate {
  func viewController(pushNewViewController nvc: UIViewController, animated: Bool) {
    navigationController?.pushViewController(nvc, animated: animated)
  }
}