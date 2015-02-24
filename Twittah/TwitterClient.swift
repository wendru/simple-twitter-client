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
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func createFavoriteWithParams(params: NSDictionary?, completion: (response: NSDictionary?, error: NSError?) -> ()) {
        POST("1.1/favorites/create.json",
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                completion(response: response as? NSDictionary, error: nil)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Failed to update:\n\(error)")
                completion(response: nil, error: error)
        })
    }
    
    func retweetWithParams(params: NSDictionary?, completion: (response: NSDictionary?, error: NSError?) -> ()) {
        POST("1.1/statuses/retweet/:id.json",
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                completion(response: response as? NSDictionary, error: nil)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Failed to update:\n\(error)")
                completion(response: nil, error: error)
        })
    }
    
    func updateStatusWithParams(params: NSDictionary?, completion: (response: NSDictionary?, error: NSError?) -> ()) {
        POST("1.1/statuses/update.json",
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                completion(response: response as? NSDictionary, error: nil)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Failed to update:\n\(error)")
                completion(response: nil, error: error)
        })
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json",
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
                completion(tweets: tweets, error: nil)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Failed to fetch timeline:\n\(error)")
                completion(tweets: nil, error: error)
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        requestSerializer.removeAccessToken()
        
        // Fetch reqest token and redirect to auth page
        fetchRequestTokenWithPath(
            "oauth/request_token",
            method: "GET",
            callbackURL: NSURL(string: "twittahclient://oauth"),
            scope: nil,
            success: { (requestToken: BDBOAuth1Credential!) -> Void in
                println("Got the request token: \(requestToken.token)")
                var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authURL!)
            },
            failure: { (error: NSError!) -> Void in
                self.loginCompletion!(user: nil, error: error)
            }
        )
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath(
            "oauth/access_token",
            method: "POST",
            requestToken: BDBOAuth1Credential(queryString: url.query),
            success: { (accessToken: BDBOAuth1Credential!) -> Void in
                
                println("Got the access token: \(accessToken.token)")
                
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(BDBOAuth1Credential(token: accessToken.token, secret: accessToken.secret, expiration: nil))
                
                self.GET(
                    "1.1/account/verify_credentials.json",
                    parameters: nil,
                    success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                        
                        var user = User(dict: response as NSDictionary)
                        User.currentUser = user
                        
//                        println("User: \(user.name)\n\n")
                        self.loginCompletion!(user: user, error: nil)
                        
                    }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                        
                        println("Failed to verify credential:\n\(error)")
                        self.loginCompletion!(user: nil, error: error)
                })
            },
            failure: { (error: NSError!) -> Void in
                println("Failed to fetch access token:\n\(error)")
                self.loginCompletion!(user: nil, error: error)
            }
        )
    }
}
