//
//  tweetCell.swift
//  twitter_ios
//
//  Created by Priscilla Lok on 2/19/16.
//  Copyright © 2016 Priscilla Lok. All rights reserved.
//

import UIKit

class tweetCell: UITableViewCell {

    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var replyImage: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    var timeAtLoad: NSDate!
    
    let calendar = NSCalendar.currentCalendar()
    
    var tweet: Tweet! {
        didSet {
            thumbImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageUrl)!)!)
            nameLabel.text = tweet.user?.name
            usernameLabel.text = "@" + (tweet.user?.screenname)!
            timeLabel.text = formattedCreatedAtString(tweet.createdAt!)
            tweetLabel.text = tweet.text
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: -Private Methods
    
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
