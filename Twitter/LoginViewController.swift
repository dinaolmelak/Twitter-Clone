//
//  LoginViewController.swift
//  Twitter
//
//  Created by Dinaol Melak on 12/12/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loginButton.layer.cornerRadius = 25
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "loggedIn") == true{
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            print("Logged IN")
        }
    }
    @IBAction func didTapLogin(_ sender: Any) {
        let requestToken = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: requestToken, success: {
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            UserDefaults.standard.set(true, forKey: "loggedIn")
            print("Logged IN")
        }, failure: { (Error) in
            print("Error Loggin in")
        })
       
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
