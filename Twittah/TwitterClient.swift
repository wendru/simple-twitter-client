//
//  TwitterClient.swift
//  Twittah
//
//  Created by Andrew Wen on 2/18/15.
//  Copyright (c) 2015 wendru. All rights reserved.
//

let twitterConsumerKey = "jnyC3P1zXQrLlry7hc6pGRjAt"
let twitterConsumerSecret = "2PPnZjjTyBQKoo5Yb082b3lKZjNdp81teYo3D6mh4JvnT331de"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
}
