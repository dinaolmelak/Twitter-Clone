//
//  TweetCell.swift
//  Twitter
//
//  Created by Dinaol Melak on 12/13/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    var favored: Bool!
    var retweeted: Bool!
    var currentTweet: [String:Any]!
    var currentTweetID: Int!
    
    @IBOutlet weak var favorButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if favored{
            favorButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        }else{
            favorButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
        if retweeted{
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        }else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        }

        // Configure the view for the selected state
    }
    @IBAction func didTapFavor(_ sender: Any) {
        togglefavor()
        
    }
    @IBAction func didTapRetweet(_ sender: Any) {
        toggleRetweeted()
        
    }
    
    func togglefavor(){
        if favored == true{
            favorButton.setImage(UIImage(named: "favor-icon"), for: .normal)
            
            TwitterAPICaller.client!.unfavorTweet(tweetID: currentTweetID, success: {
                
            }) { (Error) in
                print(Error)
            }
            favored = false
        }else{
            favorButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
            
            TwitterAPICaller.client!.favorTweet(tweetID: currentTweetID, success: {
                
            }, failure: { (Error) in
                print("encountered Error\(Error)")
            })
            
            favored = true
        }
    }
    
    func toggleRetweeted(){
        if retweeted == true{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            
            TwitterAPICaller.client!.unretweetTweet(tweetID: currentTweetID, success: {
                print("Unretweeted")
            }) { (Error) in
                print("This is \(Error)")
            }
            
            retweeted = false
        }else{
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            
            TwitterAPICaller.client!.retweetTweet(tweetID: currentTweetID, success: {
                print("Retweeted")
            }) { (Error) in
                print(Error)
            }
            
            retweeted = true
        }
    }
}
