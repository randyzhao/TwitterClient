//
//  LoginViewController.swift
//  TwitterClient
//
//  Created by randy_zhao on 5/31/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {
  
  @IBOutlet weak var backgroundImageView: UIImageView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onLoginButton(sender: AnyObject) {
    TwitterClient.sharedInstance.login({ 
      print("I have logged in")
      //self.navigationController?.pushViewController(TweetsViewController(), animated: true)
      let hvc = HamburgerViewController()
      let mvc = SideoutMenuViewController()
      mvc.hamburgerViewController = hvc
      hvc.menuViewController = mvc
      let nvc = UINavigationController()
      nvc.navigationBar.translucent = false
      nvc.pushViewController(hvc, animated: false)
      UIApplication.sharedApplication().keyWindow?.rootViewController = nvc
    }) { (error: NSError) in
      print("error: \(error.localizedDescription)")
    }
  }
}
