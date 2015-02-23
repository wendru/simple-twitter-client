//
//  TweetViewController.swift
//  Twittah
//
//  Created by Andrew Wen on 2/23/15.
//  Copyright (c) 2015 wendru. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var inputField: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
    }
    
    func setUp() {
        var user = User.currentUser!
        
        profileImage.setImageWithURL(NSURL(string: user.profileImageUrl!))
        profileImage.layer.cornerRadius = 4
        profileImage.clipsToBounds = true
        
        nameLabel.text = user.name!
        nameLabel.sizeToFit()
        
        handleLabel.text = String(format: "@%@", user.screenname!)
        handleLabel.sizeToFit()
        
        inputField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onTweet(sender: AnyObject) {
        var params = NSMutableDictionary()
        params["status"] = inputField.text!
        
        TwitterClient.sharedInstance.updateStatusWithParams(params, completion: { (response, error) -> () in
            if error == nil {
                self.view.endEditing(true)
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                UIAlertView(
                    title: nil,
                    message: "Unable to tweet",
                    delegate: self,
                    cancelButtonTitle: "Well damn...")
                .show()
            }
        })
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
