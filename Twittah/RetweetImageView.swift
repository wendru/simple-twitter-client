//
//  RetweetImageView.swift
//  Twittah
//
//  Created by Andrew Wen on 2/24/15.
//  Copyright (c) 2015 wendru. All rights reserved.
//

import UIKit

class RetweetImageView: UIImageView {
    
    var id: NSNumber?
    
    required init(coder aDecoder: NSCoder) {
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
        self.frame = CGRectMake(0, 0, 16, 16)
        self.image = UIImage(named: "retweet-sprite.png")
        self.contentMode = UIViewContentMode.Left
        self.userInteractionEnabled = true
        self.clipsToBounds = true
    }
    
    func setRetweeted(retweeted: Bool) {
        if retweeted {
            self.contentMode = UIViewContentMode.Right
        } else {
            self.contentMode = UIViewContentMode.Left
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
