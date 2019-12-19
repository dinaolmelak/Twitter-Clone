//
//  PostTweetViewController.swift
//  Twitter
//
//  Created by Center for Innovation on 12/19/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class PostTweetViewController: UIViewController {

    @IBOutlet weak var TweetTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func onTapTweet(_ sender: Any) {
        if TweetTextField.text != ""{
            TwitterAPICaller.client?.postTweet(inString: TweetTextField.text!, success: {
                print("Success")
            }, failure: { (Error) in
                print(Error)
            })
        } else{
            let alert = UIAlertController(title: "Input Tweet", message: "Their is no tweet in the textfield, please write down a tweet", preferredStyle: .alert)
            let tweetAlertAction = UIAlertAction(title: "Okay, will do", style: .cancel, handler: nil)
            alert.addAction(tweetAlertAction)
            present(alert, animated: true, completion: nil)
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
