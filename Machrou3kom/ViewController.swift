//
//  ViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-04-29.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit
import Auth0
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func signInBtnAction(_ sender: UIButton) {
        var token:String = ""
        Auth0
            .webAuth()
            .connection("instagram")
            .audience("https://machrou3kom.auth0.com/userinfo")
            .start {
                switch $0 {
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                case .success(let credentials):
                    // Do something with credentials e.g.: save them.
                    // Auth0 will automatically dismiss the login page
                    print("Credentials: \(credentials)")
                    token = credentials.accessToken!
                    let defaults = UserDefaults.standard
                    if let country = defaults.string(forKey: "country")
                    {
                        Auth0
                            .authentication()
                            .userInfo(withAccessToken: token)
                            .start { result in
                                switch result {
                                case .success(let profile):
                                    print("User Profile: \(profile.sub)")
                                    let defaults = UserDefaults.standard
                                    
                                    // Store
                                    defaults.set(profile.sub, forKey: "profile_sub")
                                    
                                case .failure(let error):
                                    print("Failed with \(error)")
                                }
                        }
                        self.dismiss(animated: true, completion: nil)
                        self.performSegue(withIdentifier: "goCategoryPage", sender: self)
                    } else {
                        self.performSegue(withIdentifier: "setCountry", sender: self)
                    }
                }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

