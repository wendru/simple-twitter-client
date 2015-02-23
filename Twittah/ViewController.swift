//
//  ViewController.swift
//  Twittah
//
//  Created by Andrew Wen on 2/18/15.
//  Copyright (c) 2015 wendru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUp()
    }
    
    func setUp() {
        // To make the status bar text white
        setNeedsStatusBarAppearanceUpdate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                UIAlertView(
                    title: nil,
                    message: "Login Failure",
                    delegate: self,
                    cancelButtonTitle: "Try again")
                .show()
            }
        }
    }
    
    // To make the status bar text white
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}

