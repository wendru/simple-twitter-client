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
    
    @IBOutlet weak var favImage: FaveImageView!
    @IBOutlet weak var retweetImage: RetweetImageView!
    @IBOutlet weak var replyImage: ReplyImageView!
    
    
    func hygrateWithTweet(tweet: Tweet) {
        profileImage.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!))
        profileImage.layer.cornerRadius = 4
        profileImage.clipsToBounds = true
        
        nameLabel.text = tweet.user?.name!
        
        let sn = tweet.user?.screenname!
        handleLabel.text = NSString(format: "@%@", sn!)
        
        contentLabel.text = tweet.text!
        
        let faved = tweet.favorited!
        let retweeted = tweet.retweeted!
        favImage.setFaved(faved)
        retweetImage.setRetweeted(retweeted)
        favImage.id = tweet.id
        retweetImage.id = tweet.id
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentLabel.preferredMaxLayoutWidth = contentLabel.frame.size.width
    }

    override func layoutSubviews() {
         super.layoutSubviews()
        contentLabel.preferredMaxLayoutWidth = contentLabel.frame.size.width
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
