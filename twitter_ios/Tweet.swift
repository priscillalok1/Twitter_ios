//
//  Tweet.swift
//  twitter_ios
//
//  Created by Priscilla Lok on 2/19/16.
//  Copyright © 2016 Priscilla Lok. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var id: Int?
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var isRetweeted: Bool?
    var retweetedUser: User?
    var retweetCount: Int?
    var favoriteCount: Int?
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? Int
        isRetweeted = dictionary["retweeted_status"] != nil ? true: false
        
        if isRetweeted == true {
            user = User(dictionary: dictionary["retweeted_status"]!["user"] as! NSDictionary)
            retweetedUser = User(dictionary: dictionary["user"] as! NSDictionary)

        } else {
            user = User(dictionary: dictionary["user"] as! NSDictionary)
            retweetedUser = nil
        }
        
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        retweetCount = dictionary["retweet_count"] as? Int
        favoriteCount = dictionary["favorite_count"] as? Int
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
}
