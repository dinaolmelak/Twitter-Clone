//
//  PostTweetViewController.swift
//  Twitter
//
//  Created by Dinaol Melak on 12/19/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class PostTweetViewController: UIViewController {

    @IBOutlet weak var tweetTextLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func onTapTweet(_ sender: Any) {
        if tweetTextLabel.text != ""{
            let tweet = tweetTextLabel.text!
            TwitterAPICaller.client?.postTweet(tweetText: tweet, success: {
                print("Yes")
            }, failure: { (Error) in
                print(Error)
            })
        }else{
            let alert = UIAlertController(title: "Missing Tweet", message: "Their is no tweet in the text field", preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "Okay, I'll Tweet", style: .cancel, handler: nil)
            alert.addAction(alertButton)
            present(alert, animated: true)
            
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
