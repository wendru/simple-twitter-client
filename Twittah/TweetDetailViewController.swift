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
    
    var tweet: Tweet?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hydrate()
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTimelineButtonTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onReplyButtonTap(sender: UIBarButtonItem) {

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
