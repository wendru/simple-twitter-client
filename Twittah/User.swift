//
//  User.swift
//  Twittah
//
//  Created by Andrew Wen on 2/22/15.
//  Copyright (c) 2015 wendru. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var profileBackgroundImageUrl: String?
    var tagline: String?
    var location: String?
    var dictionary: NSDictionary
    var followingsCount: Int?
    var followersCount: Int?
    var tweetsCount: Int?
    
    init(dict: NSDictionary) {
        self.dictionary = dict
        
        name = dict["name"] as? String
        screenname = dict["screen_name"] as? String
        profileImageUrl = dict["profile_image_url"] as? String
        profileBackgroundImageUrl = dict["profile_background_image_url"] as? String
        location = dict["location"] as? String
        tagline = dict["description"] as? String
        followingsCount = dict["friends_count"] as? Int
        followersCount = dict["followers_count"] as? Int
        tweetsCount = dict["statuses_count"] as? Int
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    var dict = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
                    _currentUser = User(dict: dict)
                }
            }
        
            return _currentUser
        } set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(
                    user!.dictionary,
                    options: nil,
                    error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
}
