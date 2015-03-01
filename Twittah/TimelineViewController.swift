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
    var HUD = JGProgressHUD(style: JGProgressHUDStyle.Dark)
    var tweetDetailVC = TweetDetailViewController()
    
    var timelineViewOriginaPosition: CGPoint?
    var timelineViewDocked = false
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var timelineView: UIView!
    @IBOutlet weak var timelineTable: UITableView!
    
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
        
        // Change status bar style
        setNeedsStatusBarAppearanceUpdate()
        
        // Table auto height and edge to edge border
        timelineTable.rowHeight = UITableViewAutomaticDimension
        timelineTable.estimatedRowHeight = 50
        timelineTable.separatorInset = UIEdgeInsetsZero
        timelineTable.layoutMargins = UIEdgeInsetsZero
        
        // Add border
        timelineView.layer.borderColor = UIColor.lightGrayColor().CGColor
        timelineView.layer.borderWidth = 1.5
        
        // Add some drop shawdow to the view
        timelineView.layer.shadowColor = UIColor.blackColor().CGColor
        timelineView.layer.shadowOpacity = 0.7
        timelineView.layer.shadowRadius = 3.0
        timelineView.layer.shadowOffset = CGSizeMake(2.0, 2.0)
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onMenuTap(sender: UIBarButtonItem) {
        if timelineViewDocked {
            dockTimelineView(false)
        } else {
            timelineViewOriginaPosition = timelineView.center
            dockTimelineView(true)
        }
    }
    
//    @IBAction func onLogout(sender: AnyObject) {
//        User.currentUser?.logout()
//    }
    
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
    
    @IBAction func onTimelineViewPanned(sender: UIPanGestureRecognizer) {
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        var destination: CGFloat?
        var dockedPositionX = CGFloat(495)
        
        if sender.state == .Began {
            if !timelineViewDocked {
                timelineViewOriginaPosition = timelineView.center
            }
        } else if sender.state == .Changed {
            destination = timelineViewOriginaPosition!.x + translation.x
            
            if destination >= timelineViewOriginaPosition!.x && !timelineViewDocked { timelineView.center.x = destination!
            } else if timelineViewDocked && timelineView.center.x + translation.x >= self.view.frame.width / 2 {
                timelineView.center.x += translation.x
            }
        } else if sender.state == .Ended {
            if self.view.frame.width < self.timelineView.center.x {
                self.dockTimelineView(true)
            } else {
                self.dockTimelineView(false)
            }
        }
    }

    func dockTimelineView(toDock: Bool) {
        self.timelineViewDocked = toDock
        
        UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
            
            if toDock {
                self.timelineView.center.x = CGFloat(495)
            } else {
                self.timelineView.center = self.timelineViewOriginaPosition!
            }
            
        }, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TweetDetail" {
            self.tweetDetailVC = segue.destinationViewController as TweetDetailViewController
            tweetDetailVC.tweet = currentTweet()
            super.prepareForSegue(segue, sender: sender)
        }
    }
    
}
