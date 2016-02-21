//
//  tweetCell.swift
//  twitter_ios
//
//  Created by Priscilla Lok on 2/19/16.
//  Copyright © 2016 Priscilla Lok. All rights reserved.
//

import UIKit

@objc protocol tweetCellDelegate {
    optional func tweetedCell (tweetedCell: tweetCell, retweetButtonPressed value:Bool)
    optional func tweetedCell (tweetedCell: tweetCell, favoriteButtonPressed value:Bool)
}

class tweetCell: UITableViewCell {

    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var retweetTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: tweetCellDelegate?
    var isRetweeted: Bool?
    var isFavorited: Bool?
    
    var timeAtLoad: NSDate!
    
    let calendar = NSCalendar.currentCalendar()
    
    var tweet: Tweet! {
        didSet {
            if tweet.isRetweeted == true {
                retweetLabel.text = (tweet.retweetedUser?.name)! + " Retweeted"
            } else {
                retweetLabel.text = "this tweet was not retweeted"
                retweetTopConstraint.constant = -16
            }
            thumbImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageUrl)!)!)
            nameLabel.text = tweet.user?.name
            usernameLabel.text = "@" + (tweet.user?.screenname)!
            timeLabel.text = formattedCreatedAtString(tweet.createdAt!)
            tweetLabel.text = tweet.text
            favoriteCountLabel.text = String(tweet.favoriteCount!)
            retweetCountLabel.text = String(tweet.retweetCount!)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.width

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.width
        
        retweetButton.addTarget(self, action: "tweetButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        favoriteButton.addTarget(self, action: "favoriteButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: -Private Methods
    func tweetButtonPressed() {
        TwitterClient.sharedInstance.retweetWithCompletion(["id": tweet.id!]) { (tweets, error) -> () in
            print ("tweet was retweeted")
        }
        delegate?.tweetedCell!(self, retweetButtonPressed: retweetButton.touchInside)
    }
    
    func setRetweetButtonImage() {
        if isRetweeted == true {
            retweetButton.setImage(UIImage(named: "retweet-true"), forState: UIControlState.Normal)
        } else {
            retweetButton.setImage(UIImage(named: "retweet"), forState: UIControlState.Normal)
        }
    }
    
    func favoriteButtonPressed() {
        delegate?.tweetedCell!(self, favoriteButtonPressed: favoriteButton.touchInside)
    }
    
    func setFavoriteButtonImage() {
        if isFavorited == true {
            favoriteButton.setImage(UIImage(named: "star"), forState: UIControlState.Normal)
        } else {
            favoriteButton.setImage(UIImage(named: "star-unselected"), forState: UIControlState.Normal)
        }
    }
    
    func formattedCreatedAtString (date: NSDate) -> String {
        var formattedDateString = ""
        let elapsedTimeComponents = calendar.components(
            [.Second, .Minute, .Hour, .Day],
            fromDate: tweet.createdAt!,
            toDate: NSDate(),
            options: [])
        if elapsedTimeComponents.day >= 1 {
            formattedDateString = String(elapsedTimeComponents.day) + "days"
        } else if elapsedTimeComponents.hour >= 1 {
            formattedDateString = String(elapsedTimeComponents.hour) + " h"
        } else if elapsedTimeComponents.minute >= 1 {
            formattedDateString = String(elapsedTimeComponents.minute) + " min"
        } else if elapsedTimeComponents.second >= 1 {
            formattedDateString = String(elapsedTimeComponents.second) + " s"
        }
        return formattedDateString
        
    }
}
