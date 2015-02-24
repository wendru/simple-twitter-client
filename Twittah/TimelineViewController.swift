//
//  TimelineViewController.swift
//  Twittah
//
//  Created by Andrew Wen on 2/22/15.
//  Copyright (c) 2015 wendru. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets = [Tweet]()
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var timelineTable: UITableView!
    var HUD = JGProgressHUD(style: JGProgressHUDStyle.Dark)
    var tweetDetailVC = TweetDetailViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
        loadTimeline()
    }
    
    func setUp() {
        timelineTable.delegate = self
        timelineTable.dataSource = self
        
        createRefreshControl()
        
        timelineTable.rowHeight = UITableViewAutomaticDimension
        timelineTable.estimatedRowHeight = 50
        timelineTable.separatorInset = UIEdgeInsetsZero
        timelineTable.layoutMargins = UIEdgeInsetsZero
    }
    
    func loadTimeline() {
        HUD.showInView(self.view)
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            if tweets != nil {
                self.tweets = tweets!
                self.timelineTable.reloadData()
            } else {
                UIAlertView(
                    title: nil,
                    message: "Unable to fetch your timeline",
                    delegate: self,
                    cancelButtonTitle: "Well damn...")
                    .show()
            }
            
        })
        
        HUD.dismissAfterDelay(0.5, animated: true)
        refreshControl.endRefreshing()
    }
    
    func createRefreshControl() {
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(
            self,
            action: "loadTimeline",
            forControlEvents: UIControlEvents.ValueChanged)
        
        timelineTable.insertSubview(refreshControl, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = timelineTable.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        cell.hygrateWithTweet(self.tweets[indexPath.row] as Tweet)
        
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func currentTweet() -> Tweet? {
        let row = timelineTable.indexPathForSelectedRow()?.row
        if row == nil {
            return nil
        } else {
            return tweets[row!]
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if self.currentTweet() != nil {
            self.tweetDetailVC = segue.destinationViewController as TweetDetailViewController
            tweetDetailVC.tweet = currentTweet()
            super.prepareForSegue(segue, sender: sender)
        }
        
    }
    
}
