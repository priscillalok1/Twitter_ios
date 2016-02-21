//
//  TweetDetailViewController.swift
//  twitter_ios
//
//  Created by Priscilla Lok on 2/20/16.
//  Copyright © 2016 Priscilla Lok. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

  
    @IBOutlet weak var retweetTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var retweetsNumberLabel: UILabel!
    @IBOutlet weak var favoritesNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        if tweet != nil {
            if tweet.isRetweeted == true {
                retweetLabel.text = (tweet.retweetedUser?.name)! + " Retweeted"
            } else {
                retweetLabel.text = "this tweet was not retweeted"
                retweetTopConstraint.constant = -16
            }
            
            thumbImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageUrl)!)!)
            nameLabel.text = tweet.user?.name
            usernameLabel.text = "@" + (tweet.user?.screenname)!
            //        dateLabel.text = formattedCreatedAtString(tweet.createdAt!)
            tweetLabel.text = tweet.text
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
