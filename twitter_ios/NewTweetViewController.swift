//
//  NewTweetViewController.swift
//  twitter_ios
//
//  Created by Priscilla Lok on 2/20/16.
//  Copyright © 2016 Priscilla Lok. All rights reserved.
//

import UIKit

@objc protocol NewTweetViewControllerDelegate {
    optional func newTweetViewController(newTweetViewController: NewTweetViewController, didCreateTweet newTweetString: String)
}

class NewTweetViewController: UIViewController, UITextViewDelegate {

    weak var delegate: NewTweetViewControllerDelegate?
    
    @IBOutlet weak var newTweetText: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumImageView: UIImageView!
    @IBOutlet weak var charCountLabel: UILabel!
    
    var newTweet:String?
    
    var charCount: Int?
    var isReplyTweet: Bool?
    var replyUsername: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = User.currentUser?.name
        usernameLabel.text = "@" + (User.currentUser?.screenname)!
        thumImageView.setImageWithURL(NSURL(string: (User.currentUser?.profileImageUrl)!)!)
        if newTweet == nil {
            charCount = 140
        } else {
            charCount = 140 - (newTweet?.characters.count)!
        }
//        charCount = 140 - (newTweet?.characters.count)!
        charCountLabel.text = String(charCount!)
        newTweetText.becomeFirstResponder()
        if newTweet == nil {
            newTweetText.text = ""
        } else {
            newTweetText.text = newTweet
        }
        newTweetText.delegate = self
        
        thumImageView.layer.cornerRadius = 3
        thumImageView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChange(textView: UITextView) {
        let currCharCount = newTweetText.text.characters.count
        charCount = 140-currCharCount
        charCountLabel.text = String(charCount!)
        newTweet = newTweetText.text
    }
    
    @IBAction func cancelButtonClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func tweetButtonClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        self.delegate?.newTweetViewController!(self, didCreateTweet: newTweet!)
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
