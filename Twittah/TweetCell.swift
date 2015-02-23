//
//  TweetCell.swift
//  Twittah
//
//  Created by Andrew Wen on 2/22/15.
//  Copyright (c) 2015 wendru. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func hygrateWithTweet(tweet: Tweet) {
        profileImage.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!))
        profileImage.layer.cornerRadius = 4
        profileImage.clipsToBounds = true
        
        nameLabel.text = tweet.user?.name!
        nameLabel.sizeToFit()
        
        let sn = tweet.user?.screenname!
        handleLabel.text = NSString(format: "@%@", sn!)
        handleLabel.sizeToFit()
        
        contentLabel.text = tweet.text!
        contentLabel.sizeToFit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
