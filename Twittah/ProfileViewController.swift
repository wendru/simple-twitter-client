//
//  ProfileViewController.swift
//  Twittah
//
//  Created by Andrew Wen on 3/1/15.
//  Copyright (c) 2015 wendru. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    
    @IBOutlet weak var tweetsView: UIView!
    @IBOutlet weak var followingsView: UIView!
    @IBOutlet weak var followersView: UIView!
    
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Change status bar style
        setNeedsStatusBarAppearanceUpdate()
        setUp()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUp() {
        var user: User?
        
        if targetUser == nil {
            user = User.currentUser
        } else {
            user = targetUser
        }
        
        profileImage.setImageWithURL(NSURL(string: user!.profileImageUrl!))
        profileImage.layer.cornerRadius = 4
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        profileImage.layer.borderWidth = 2;
        
        nameLabel.text = user!.name
        handleLabel.text = String(format: "@%@", user!.screenname!)
        backgroundImage.setImageWithURL(NSURL(string: user!.profileBackgroundImageUrl!))
        backgroundImage.clipsToBounds = true
        
//        tweetsView.layer.borderColor = UIColor.lightGrayColor().CGColor
//        tweetsView.layer.borderWidth = 1
//        followingsView.layer.borderColor = UIColor.lightGrayColor().CGColor
//        followingsView.layer.borderWidth = 1
//        followersView.layer.borderColor = UIColor.lightGrayColor().CGColor
//        followersView.layer.borderWidth = 1
        
        tweetCountLabel.text = String(format: "%d", user!.tweetsCount!)
        followerCountLabel.text = String(format: "%d", user!.followersCount!)
        followingCountLabel.text = String(format: "%d", user!.followingsCount!)
    }
    
    
    @IBAction func onBack(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
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
