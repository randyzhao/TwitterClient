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
      self.navigationController?.pushViewController(hvc, animated: true)
    }) { (error: NSError) in
      print("error: \(error.localizedDescription)")
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
