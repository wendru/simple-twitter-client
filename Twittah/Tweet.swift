//
//  Tweet.swift
//  Twittah
//
//  Created by Andrew Wen on 2/22/15.
//  Copyright (c) 2015 wendru. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var dictionary: NSDictionary?
    var timestamp: String?
    var id: NSNumber?
    var retweeted: Bool?
    var favorited: Bool?
    
    init(dict: NSDictionary) {
        self.dictionary = dict
        
        user = User(dict: dict["user"] as NSDictionary)
        text = dict["text"] as? String
        createdAtString = dict["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        id = dict["id"] as? NSNumber
        
        retweeted = dict["retweeted"] as? Bool
        favorited = dict["favorited"] as? Bool
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dict in array {
            tweets.append(Tweet(dict: dict))
        }
        
        return tweets
    }
}
