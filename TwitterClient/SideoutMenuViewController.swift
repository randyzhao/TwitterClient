//
//  SideoutMenuViewController.swift
//  TwitterClient
//
//  Created by randy_zhao on 6/2/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

class SideoutMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  let MenuContents = ["Profile", "Home Timeline", "Mentions"]
  var viewControllers: [UIViewController]!
  
  var hamburgerViewController: HamburgerViewController!
  
  @IBOutlet weak var menuTableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    menuTableView.delegate = self
    menuTableView.dataSource = self
    
    let tvc = TweetsViewController()
    tvc.delegate = hamburgerViewController
    viewControllers = [
      ProfileViewController(),
      tvc,
    ]

    hamburgerViewController.contentViewController = viewControllers[1]
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MenuContents.count
  }

  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = MenuContents[indexPath.row]
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    if indexPath.row < viewControllers.count {
      hamburgerViewController.contentViewController = viewControllers[indexPath.row]
    }
  }
}
