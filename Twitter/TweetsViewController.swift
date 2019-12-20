//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Dinaol Melak on 12/12/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var tweets = [[String:Any]]()
    var numberOfTweets = 10
    let tweetRefresher = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tweetRefresher.addTarget(self, action: #selector(getTweets), for: .valueChanged)
        tableView.insertSubview(tweetRefresher, at: 0)
        
        getTweets()
        // Do any additional setup after loading the view.
        
        
    }
    @objc func getTweets(){
        numberOfTweets = 10
        TwitterAPICaller.client?.getDictionariesRequest(url: "https://api.twitter.com/1.1/statuses/home_timeline.json", parameters: ["count":self.numberOfTweets], success: { (NSDictionary) in
            self.tweets = NSDictionary as! [[String:Any]]
            self.tableView.reloadData()
            //self.tweetRefresher.endRefreshing()
            self.run(after: 2) {
                self.tweetRefresher.endRefreshing()
            }
        }, failure: { (Error) in
            print("could not get tweets")
            let alertNotify = UIAlertController(title: "Apologies!", message: "Unfortunately, Your tweets could not be found! Please Try again later.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertNotify.addAction(alertAction)
            self.present(alertNotify, animated: true, completion: nil)
        })
        
    }
    @objc func getMoreTweets(){
        numberOfTweets += 10
        TwitterAPICaller.client?.getDictionariesRequest(url: "https://api.twitter.com/1.1/statuses/home_timeline.json", parameters: ["count":self.numberOfTweets], success: { (NSDictionary) in
            self.tweets = NSDictionary as! [[String:Any]]
            self.tableView.reloadData()
            //self.tweetRefresher.endRefreshing()
            self.run(after: 2) {
                self.tweetRefresher.endRefreshing()
            }
        }, failure: { (Error) in
            print("could not get tweets")
            print(Error)
        })
        
    }
    func run(after wait: TimeInterval, closure: @escaping () -> Void){
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    @IBAction func onTapLogout(_ sender: Any) {
        
        TwitterAPICaller.client?.logout()
        dismiss(animated: true) {
            print("Logged OUt")
            
        }
        UserDefaults.standard.set(false, forKey: "loggedIn")
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let tweet = tweets[indexPath.row]
        let user = tweet["user"] as! [String:Any]
        let imageURL = user["profile_image_url_https"] as! String
        //print("Here------")
        cell.usernameLabel.text = user["name"] as? String
        cell.screenNameLabel.text = user["screen_name"] as? String
        cell.tweetContentLabel.text = tweet["text"] as? String
        let cellFavored = tweet["favorited"] as! Bool
        let cellreTweeted = tweet["retweeted"] as! Bool
        if cellFavored{
            cell.favored = true
        }
        if cellreTweeted{
            cell.retweeted = true
        }
        
        let url = URL(string: imageURL)!
        cell.profileImageView.af_setImage(withURL: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweets.count{
            getMoreTweets()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tweets[indexPath.row])
    }
    
    @IBAction func didTapTweet(_ sender: Any) {
        performSegue(withIdentifier: "TweetSegue", sender: self)
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
