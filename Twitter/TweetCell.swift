//
//  TweetCell.swift
//  Twitter
//
//  Created by Dinaol Melak on 12/13/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    var favored: Bool = false
    var retweeted: Bool = false
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
        }
        if retweeted{
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        }

        // Configure the view for the selected state
    }
    @IBAction func didTapFavor(_ sender: Any) {
        
        
    }
    @IBAction func didTapRetweet(_ sender: Any) {
        
        
    }
    
}
