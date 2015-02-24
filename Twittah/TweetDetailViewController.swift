//
//  TweetDetailViewController.swift
//  Twittah
//
//  Created by Andrew Wen on 2/23/15.
//  Copyright (c) 2015 wendru. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var replyButton: UIBarButtonItem!
    
    @IBOutlet weak var faveImage: FaveImageView!
    @IBOutlet weak var retweetImage: RetweetImageView!
    @IBOutlet weak var replyImage: ReplyImageView!
    
    var tweet: Tweet?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
        hydrate()
    }
    
    func setUp() {
        replyButton.tintColor = UIColor.whiteColor()
        textField.hidden = true
    }
    
    func hydrate() {
        profileImage.setImageWithURL(NSURL(string: tweet!.user!.profileImageUrl!))
        profileImage.layer.cornerRadius = 4
        profileImage.clipsToBounds = true
        
        nameLabel.text = tweet!.user?.name!
        
        let sn = tweet!.user?.screenname!
        handleLabel.text = NSString(format: "@%@", sn!)
        
        contentLabel.text = tweet!.text!
        
        timestampLabel.text = tweet!.createdAtString
        
        let faved = tweet?.favorited!
        let retweeted = tweet?.retweeted!
        faveImage.setFaved(faved!)
        retweetImage.setRetweeted(retweeted!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTimelineButtonTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func retweetButtonTapped(sender: AnyObject) {
        var params = NSMutableDictionary()
        params["id"] = tweet?.id
        
        TwitterClient.sharedInstance.retweetWithParams(params, completion: { (response, error) -> () in
            if error == nil {
                self.retweetImage.setRetweeted(true)
            } else {
                UIAlertView(
                    title: nil,
                    message: "Unable to retweet",
                    delegate: self,
                    cancelButtonTitle: "Well damn...")
                    .show()
            }
        })
    }
    
    @IBAction func favButtonTapped(sender: AnyObject) {
        var params = NSMutableDictionary()
        params["id"] = tweet?.id
        
        TwitterClient.sharedInstance.createFavoriteWithParams(params, completion: { (response, error) -> () in
            if error == nil {
                self.faveImage.setFaved(true)
            } else {
                UIAlertView(
                    title: nil,
                    message: "Unable to mark tweet as favorite",
                    delegate: self,
                    cancelButtonTitle: "Well damn...")
                    .show()
            }
        })
    }
    

    @IBAction func onReplyButtonTap(sender: UIBarButtonItem) {
        var params = NSMutableDictionary()
        params["status"] = textField.text!
        params["in_reply_to_status_id"] = tweet?.id
        
        TwitterClient.sharedInstance.updateStatusWithParams(params, completion: { (response, error) -> () in
            if error == nil {
                self.replyImage.setReplied(true)
                self.replyButton.tintColor = UIColor.whiteColor()
                self.resignFirstResponder()
                self.textField.editable = false
            } else {
                UIAlertView(
                    title: nil,
                    message: "Unable to reply",
                    delegate: self,
                    cancelButtonTitle: "Well damn...")
                .show()
            }
        })
    }
    
    @IBAction func replyTapped(sender: AnyObject) {
        replyButton.tintColor = UIColor.grayColor()
        
        textField.hidden = false
        let sn = tweet?.user?.screenname!
        textField.text = NSString(format: "@%@ ", sn!)
        textField.becomeFirstResponder()
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
